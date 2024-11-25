#!/bin/bash

# Defensive programming: check if a single argument is passed
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <path-to-compressed-fasta-file>"
  exit 1
fi

# Assign the argument to a variable
fasta_file=$1

# Check if the file exists
if [ ! -f "$fasta_file" ]; then
  echo "Error: File '$fasta_file' does not exist."
  exit 1
fi

# Begin processing
echo "Processing file: $fasta_file"

# Total number of sequences
echo "Calculating total number of sequences..."
total_sequences=$(zgrep -c "^>" "$fasta_file")
echo "Total sequences: $total_sequences"

# Count sequences by country
echo "Counting sequences by country..."
zgrep "^>" "$fasta_file" | awk -F'|' '{print $NF}' | sort | uniq -c | sort -rn > sequences_by_country.txt
echo "Counts by country saved to sequences_by_country.txt"

# OPTIONAL: Count sequences with >29,000 and <29,000 base pairs
echo "Counting sequences by length..."
zcat "$fasta_file" | bioawk -c fastx '{if(length($seq) > 29000) over++; else under++} END {print "Over 29,000 bp:", over; print "Under 29,000 bp:", under}' > sequence_length_counts.txt
echo "Sequence length counts saved to sequence_length_counts.txt"

# End of processing
echo "Processing complete."
