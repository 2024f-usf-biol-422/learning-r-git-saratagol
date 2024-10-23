# Sara Tagol
# October 21, 2024
# sptagol@usfca.edu

# load in SNP data
library(dplyr)

#subset the data to a specific sample
subset_snp_data <- function(snp_file, sample_id) {
  snp_data <- read.csv(snp_file, stringsAsFactors = FALSE)
  subset_data <- snp_data %>%
    filter(sample == sample_id)
  return(subset_data)
}

