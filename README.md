# Bash Scripting
## Introduction
In the fast-paced world of data management, the ability to efficiently automate data processes is crucial. This projects showcase my expertise in using Bash scripting for automating Extract, Transform, Load (ETL) operations. My main focus is on managing CSV & JSON files and integrating them seamlessly with PostgreSQL databases, reflecting both my technical skills and my commitment to optimizing data workflows.

## Problem Statement
You have been hired as a new Data Engineer at CoreDataEngineers. The CoreDataEngineers infrastructure is based on the Linux Operating System. Your manager has tasked you with the responsibility of managing the company’s data infrastructure and version control tool.

## 1. Your manager has assigned you the task of building a **Bash** script (use only bash scripting) that performs a simple ETL process.

   - **Extract:** Download a CSV file. You can access the CSV using this [link](https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv). Save it into a folder called `raw`. Your script should confirm that the file has been saved into the `raw` folder.
   
   - **Transform:** After downloading the file, perform a simple transformation by renaming the column named `Variable_code` to `variable_code`. Then, select only the following columns: `year, Value, Units, variable_code`. Save the content of these selected columns into a file named `2023_year_finance.csv`. This file should be saved in a folder called `Transformed`, your Bash script should confirm that it was loaded into the folder.
   
   - **Load:** Load the transformed data into a directory named `Gold`. Also, confirm that the file has been saved into the folder.

   Note: Use environment variables for the URL, and call it in your script. Write a well-detailed script, add sufficient comments to the script, and print out information for each step.

## 2. Your manager has asked you to schedule the script to run daily using cron jobs. Schedule the script to run every day at 12:00 AM.

### Architecture Diagram.
![bash_scripting_etl-question1](https://github.com/user-attachments/assets/beec1e9b-8197-470b-a4fd-54eea9be8d62)

### Usage
1. Clone the repository.
```sh
   git clone https://github.com/Samuel-Njoroge/etl-in-bash.git
```
2. Navigate into the directory.
```sh
cd etl-in-bash/scripts
 ```
3. Make the `etl.sh` file executable.
```sh
  chmod +x etl.sh
```
4. Run the bash script.
```sh
 ./etl.sh
```

OR

4. Schedule the script to run daily at `12:00 AM`.
   
4.1 Open a crontab file.
```sh
crontab -e
```
4.2 Add the code in the file and save the file.
```sh
0 0 * * * etl.sh
```

## 3. Write a Bash script to move all CSV and JSON files from one folder to another folder named `json_and_CSV`. The script should be able to work with one or more Json and CSV files. 

### Architecture Diagram.
![](https://github.com/Samuel-Njoroge/etl-in-bash/blob/test/diagrams/bash_scripting_etl-q3.png)

### Usage
1. Clone the repository.
```sh
git clone https://github.com/Samuel-Njoroge/etl-in-bash.git
```
2. Navigate into the directory.
 ```sh
 cd etl-in-bash/scripts
```
3. Make the `move_files.sh` file executable.
 ```sh
 chmod +x move_files.sh
```
4. Run the bash script.
```sh
 ./move_files.sh
```

## 4. CoreDataEngineers is diversifying into the sales of goods and services. To understand the market, your organization needs to analyze their competitor, `Parch and Posey`. Download the CSV file using this [link](https://we.tl/t-2xYLL816Yt) to your local PC. After downloading, do the following:

   - Write a Bash script that iterates over and copies each of the CSV files into a PostgreSQL database (name the database `posey`).
   
   - After this, write SQL scripts with detailed comments to answer the following questions posed by your manager (Ayoola):
   
     a) Find a list of order IDs where either `gloss_qty` or `poster_qty` is greater than 4000. Only include the `id` field in the resulting table.
     
     b) Write a query that returns a list of orders where the `standard_qty` is zero and either the `gloss_qty` or `poster_qty` is over 1000.
     
     c) Find all the company names that start with a 'C' or 'W', and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.
     
     d) Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name.

### Architecture Diagram.
![](https://github.com/Samuel-Njoroge/etl-in-bash/blob/test/diagrams/bash_scripting_etl-q4.png)

### Usage
1. Clone the repository.
```sh
   git clone https://github.com/Samuel-Njoroge/etl-in-bash.git
```
2. Navigate into the directory.
```sh
cd etl-in-bash/scripts
```
3. Make the `csv_to_postgres.sh` file executable.
```sh
 chmod +x csv_to_postgres.sh
```
4. Run the bash script.
```sh
 ./csv_to_postgres.sh
```
 
### SQL Queries.
#### a) Find a list of order IDs where either `gloss_qty` or `poster_qty` is greater than 4000. Only include the `id` field in the resulting table.
##### Query
```sh
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;
```

#### b) Write a query that returns a list of orders where the `standard_qty` is zero and either the `gloss_qty` or `poster_qty` is over 1000.
##### Query
```sh
SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);
```

#### c) Find all the company names that start with a 'C' or 'W', and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.
##### Query
```sh
SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
  AND (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
  AND primary_poc NOT LIKE '%eana%';
```

#### d) Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name.
##### Query
```sh
SELECT r.name AS region_name,
       s.name AS sales_rep_name,
       a.name AS account_name
FROM region r
JOIN sales_reps s ON r.id = s.region_id
JOIN accounts a ON s.id = a.sales_rep_id
ORDER BY a.name ASC;
```
