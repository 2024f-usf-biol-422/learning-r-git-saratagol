#!/bin/bash

set -euo pipefail

# This script renders the R Markdown file with the specified parameters

# Sara Tagol
# October 30, 2024
# sptagol@usfca.edu

# Check that exactly two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_snp_csv> <sample_id>"
    echo "Example: $0 data/sample_snp_data.csv SRR12345678"
    exit 1
fi

# Assign command-line arguments to variables
SNP_FILE="$1"
SAMPLE_ID="$2"

# Render the R Markdown file with specified parameters using Rscript
Rscript -e "rmarkdown::render('Report.Rmd', params = list(snp_file ='$SNP_FILE', sample_id = '$SAMPLE_ID'))"

mv Report.html output/$SAMPLE_ID.html

