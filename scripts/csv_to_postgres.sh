#!/bin/bash

# Source the configuration file
source ./config/database.conf

# Directory containing CSV files
CSV_DIR="../parch_and_posey/data"

# Create the database if it doesn't exist
psql -U $DB_USER -c "CREATE DATABASE $DB_NAME;"

# Iterate over CSV files
for csv_file in "$CSV_DIR"/*.csv; do
    # Get the filename without extension to use as table name
    table_name=$(basename "$csv_file" .csv)
    
    # Create table and import data
    psql -U $DB_USER -d $DB_NAME <<EOF
    CREATE TABLE IF NOT EXISTS $table_name (
        $(head -n 1 "$csv_file" | sed 's/,/ text,/g' | sed 's/$/ text/')
    );
    
    COPY $table_name FROM '$csv_file' DELIMITER ',' CSV HEADER;
EOF
    
    echo "Imported $csv_file into $table_name table"
done

echo "All CSV files have been imported into the PostgreSQL database."