import os
import pandas as pd
import mysql.connector  # Use psycopg2 for PostgreSQL

# RDS database connection details
RDS_HOST = os.getenv('RDS_HOST')
RDS_USER = os.getenv('RDS_USER')
RDS_PASSWORD = os.getenv('RDS_PASSWORD')
RDS_DATABASE = os.getenv('RDS_DATABASE')

# Connect to RDS
conn = mysql.connector.connect(
    host=RDS_HOST,
    user=RDS_USER,
    password=RDS_PASSWORD,
    database=RDS_DATABASE
)
cursor = conn.cursor()

# Local folder path
main_folder = "Data\Raw-data creation\CSBS"

# Traverse all folders
for subfolder in os.listdir(main_folder):
    folder_path = os.path.join(main_folder, subfolder)
    if os.path.isdir(folder_path):
        csv_file = os.path.join(folder_path, "attendance.csv")

        if os.path.exists(csv_file):
            # Extract the date from the folder name
            table_name = f"attendance_{subfolder.replace('-', '_')}"

            # Create table if it doesn't exist
            create_table_query = f"""
            CREATE TABLE IF NOT EXISTS {table_name} (
                name VARCHAR(255),
                roll_no VARCHAR(50),
                period1 VARCHAR(10),
                period2 VARCHAR(10),
                period3 VARCHAR(10),
                period4 VARCHAR(10),
                period5 VARCHAR(10),
                period6 VARCHAR(10),
                period7 VARCHAR(10),
                period8 VARCHAR(10)
            );
            """
            cursor.execute(create_table_query)

            # Read the CSV file
            df = pd.read_csv(csv_file)

            # Insert data into the table
            for _, row in df.iterrows():
                insert_query = f"""
                INSERT INTO {table_name} (name, roll_no, period1, period2, period3, period4, period5, period6, period7, period8)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
                """
                cursor.execute(insert_query, tuple(row))

            conn.commit()
            print(f"Data from {csv_file} imported successfully into table {table_name}.")

# Close the connection
cursor.close()