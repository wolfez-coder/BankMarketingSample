"""
The purpose of this file is to demonstrate a typical
preproccessing stage, prior to data analysis.

"""
FILE = "raw_data/bank-additional-full.csv" # raw data stored locally within repo
OUTPUT = "prod_data/Database/cleaned_data.csv" # you could also write this to the database in a production use case

import pandas as pd
import sqlite3

try:
    df = pd.read_csv(FILE, delimiter=';', header=0)
    print(df.info())
except Exception as e:
    print(f"Unexpected Error During Ingestion: {e}")

def clean_data(raw_data):
    raw_data['job'] = raw_data['job'].str.replace('.','',regex=False)
    raw_data['education'] = raw_data['education'].str.replace('.',' ',regex=False)
    raw_data.columns = raw_data.columns.str.strip()
    return raw_data

def output(clean_data):
    """Export cleaned data to CSV and SQLite database."""
    try:
        clean_data.to_csv(OUTPUT, index=False)
        print(f"Data successfully exported to {OUTPUT}")
        
        conn = sqlite3.connect('prod_data/Database/bank_data.db')
        clean_data.to_sql('bank_marketing', conn, if_exists='replace', index=False)
        conn.close()
        print("Data successfully exported to SQLite database")
    except Exception as e:
        print(f"Unexpected Error During Export: {e}")

def main(df):
    cleaned_df = clean_data(df)
    output(cleaned_df)

if __name__ == '__main__':
    main(df)