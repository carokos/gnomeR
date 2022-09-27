library(cbioportalR)
library(dplyr)

names_df <- read.csv(here::here("data-raw", "accepted-column-names.csv"))

names_df <- names_df %>%
  mutate(sc_maf_column_name = snakecase::to_snake_case(maf_column_name)) %>%
  mutate(sc_api_column_name = snakecase::to_snake_case(api_column_name)) %>%
  mutate(internal_column_name = case_when(
    sc_maf_column_name == "tumor_sample_barcode" ~ "sample_id",
    sc_maf_column_name == "" & sc_api_column_name != "" ~ sc_api_column_name,
    TRUE ~ sc_maf_column_name
  ))



usethis::use_data(names_df, overwrite = TRUE)
