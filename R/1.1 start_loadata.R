
##first time read original data, use arrow
install.packages('arrow')
library(arrow)
data <- arrow::read_parquet("data/data.parquet")
