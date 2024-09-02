#!/bin/bash

# Set URL variable
export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Confirm file
confirm_file() {
    if [ -f "$1" ]; then
        echo "The file $1 has been successfully saved."
    else
        echo "Error: The file $1 is missing."
        exit 1
    fi
}

# Extract
echo "Extracting ..."
mkdir -p raw
wget -O raw/data.csv $CSV_URL
confirm_file "raw/data.csv"

# Transform
echo "Transforming ..."
mkdir -p Transformed

# Rename and select columns
awk -F',' 'NR==1 {for (i=1; i<=NF; i++) if ($i=="Variable_code") col=i}
     NR==1 {print "year,Value,Units,variable_code"}
     NR>1 {print $1","$2","$3","$col}' raw/data.csv > Transformed/2023_year_finance.csv
confirm_file "Transformed/2023_year_finance.csv"

# Load into Gold
echo "Loading..."
mkdir -p Gold
cp Transformed/2023_year_finance.csv Gold/
confirm_file "Gold/2023_year_finance.csv"

# Process completed successfully
echo "The ETL process has completed successfully!"