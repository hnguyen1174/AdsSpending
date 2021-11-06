#' Get and Process Data
#'
#' @return processed data
#' @export
get_data <- function() {
  df_raw <- readr::read_csv(file.path(here::here(), 'data/ads_data_final.csv'))
  
  df_processed <- df_raw %>% 
    mutate(overspend = spend - budget,
           overspent = if_else(overspend > 0, 1, 0),
           overspend_prct = overspend/budget,
           log_budget = log(budget),
           log_spend = log(spend),
           capped_overspend = if_else(overspend > 0, overspend, 0),
           log_capped_overspend = log(capped_overspend + 1e-10),
           size = factor(size, levels = c("small", "medium", "large")),
           treat = factor(treat, levels = c(FALSE, TRUE)))
  
  df_processed
}