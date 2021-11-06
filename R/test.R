#' Perform one-sided z-test (proportion test)
#'
#' @param df dataframe that contains the data
#' @param var the variable of which we want to compare the means
#' @param treatment_var the treatment variable
#'
#' @return
#' @export
perform_prop_test <- function(df, var, treatment_var = 'treat') {
  
  control_sample <- df %>% 
    filter(!!as.name(treatment_var) == FALSE) %>% nrow()
  control_overspent <- df %>% 
    filter(!!as.name(treatment_var) == FALSE, !!as.name(var) == TRUE) %>% nrow()
  treatment_sample <- df %>% 
    filter(!!as.name(treatment_var) == TRUE) %>% nrow()
  treatment_overspent <- df %>% 
    filter(!!as.name(treatment_var) == TRUE, !!as.name(var) == TRUE) %>% nrow()
  
  prop.test(x = c(treatment_overspent, control_overspent), 
            n = c(treatment_sample, control_sample),
            alternative = "less")
}