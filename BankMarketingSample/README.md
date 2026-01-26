# BankMarketingSample

> **⚠️ FOR TESTING PURPOSES ONLY**

Data analysis pipeline for bank marketing dataset.

## Project Structure

- **`data_preprocessing.py`** - Base level data cleaning and preparation
- **`raw_data/`** - Raw input data
- **`prod_data/`** - Cleaned production-ready data
- **`analysis/`** - Initial analysis and SQL queries
- **Tableau Public** - Interactive visualizations ([link](link))

raw_data/
└─ bank-additional-full.csv
↓
data_preprocessing.py (cleaning & preparation)
↓
prod_data/
└─ cleaned dataset
↓
sqlite3 database

## Getting Started

1. Run `data_preprocessing.py` to clean raw data
2. Output flows to `prod_data/`
3. Load into sqlite3 database for analysis