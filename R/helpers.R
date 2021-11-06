############################
# HELPERS ##################
############################

#' Plot boxplots by a variable
#' 
#' This function plots two box plots side-by-side. The left plot will have var on the x-axis,
#' and the right plot will also be stratified by fill_var.
#'
#' @param df_final dataframe
#' @param var variable for boxplot
#' @param fill_var variable to fill colors in boxplot
#'
#' @return plot grid objects
plot_boxplot_by_vars <- function(df_final, var, fill_var) {
  
  p1 <- df_final %>% 
    ggplot(aes(x = treat, y = !!sym(var))) + 
    geom_boxplot() +
    ggtitle(glue('Box Plot of {var}'))
  p2 <- df_final %>% 
    ggplot(aes(x = treat, y = !!sym(var), fill = !!sym(fill_var))) + 
    geom_boxplot() +
    ggtitle(glue('Box Plot of {var} by {fill_var}'))
  
  plot_grid(p1, p2, labels = c('A', 'B'))
}

#' Plot histograms by variable
#' 
#' This function plots two historgrams side-by-side. The left plot will have the original scale for var
#' and the right plot will be on the log scale.
#'
#' @param df_final processed dataframe
#' @param var variable for histogram
#'
#' @return plot grid objects
plot_hist_by_vars <- function(df_final, var) {
  
  log_var <- paste0('log_', var)
  
  p1 <- df_final %>% 
    ggplot(aes(x = !!sym(var))) +
    geom_histogram(bins = 100, fill = "#69b3a2", color = "#e9ecef", alpha = 0.9) +
    ggtitle(glue("Histogram of {str_replace_all(var, '_', ' ')}"))
  p2 <- df_final %>% 
    ggplot(aes(x = !!sym(log_var))) +
    geom_histogram(bins = 100, fill = "#69b3a2", color = "#e9ecef", alpha = 0.9) +
    ggtitle(glue("Histogram of {str_replace_all(log_var, '_', ' ')}"))
  
  plot_grid(p1, p2, labels = c('A', 'B'))
}

#' Get sample means
#' 
#' This function gets `n_inter` samples without replacement with size `sample_size` from `vec`, 
#' calculates the mean of such sample, and returns a vector of sample means of size `n_inter`.
#' 
#' @param vec vector to sample from
#' @param n_inter number of iterations to sample
#' @param sample_size sample size
#'
#' @return `n_inter` means
get_sample_means <- function(vec, n_inter, sample_size) {
  
  sampling_dist <- c()
  for (i in 1:n_inter) {
    
    if(i %% 1000 == 0){
      cat(glue('{round(i*100/n_inter, 2)}%'))
      cat('\n')
    }
    
    idx <- sample(1:length(vec), sample_size, replace = FALSE)
    sample <- vec[idx]
    mean_sample <- mean(sample)
    sampling_dist <- c(sampling_dist, mean_sample)
  }
  
  sampling_dist
}

#' Get permutation difference under the null hypothesis
#' 
#' Under the null hypothesis, the control and treatment group will have
#' similar means. Therefore, this function will get a sample of size `n_control`from the combined group,
#' then get a sample of size `n_treatment`from the combined group,
#' and calculate the difference in means between these two samples.
#'
#' @param x combined vector of values of two groups to sample from
#' @param n_control size of control group
#' @param n_treatment size of treatment group
#'
#' @return permuted difference
get_perm_diff <- function(x, n_control, n_treatment) {
  
  n <- n_treatment + n_control
  idx_control <- sample(1:n, n_control)
  idx_treatment <- setdiff(1:n, idx_control)
  mean_diff <- mean(x[idx_control]) - mean(x[idx_treatment]) 
  
  mean_diff
}

#' Get permutation differences under the null hypothesis
#'
#' @param df dataframe that contain both control and treatment data
#' @param var variable to perform permutations on
#' @param iter number of iterations, default to 100000
#'
#' @return permuted differences
get_n_perm_diffs <- function(df, var, iter = 100000) {
  
  sample_treatment <- df %>% filter(treat == TRUE) %>% nrow()
  sample_control <- df %>% filter(treat == FALSE) %>% nrow()
  
  perm_diffs <- c()
  
  for (i in 1:iter) {
    
    if(i %% 1000 == 0){
      cat(glue('{round(i*100/iter, 2)}%'))
      cat('\n')
    }
    perm_diff <- get_perm_diff(pull(df, var), sample_control, sample_treatment)
    perm_diffs <- c(perm_diffs, perm_diff)
  }
  
  perm_diffs
}
