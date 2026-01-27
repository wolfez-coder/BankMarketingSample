# BankMarketingSample

> **⚠️ FOR TESTING PURPOSES ONLY**

Data analysis pipeline for bank marketing dataset.

## Project Structure
([Data Source](https://archive.ics.uci.edu/dataset/222/bank+marketing))

- **`data_preprocessing.py`** - Base level data cleaning and preparation
- **`raw_data/`** - Raw input data
- **`prod_data/`** - Cleaned production-ready data
- **`analysis/`** - Initial analysis and SQL queries
- **Tableau Public** - Interactive visualizations ([Tableau](https://public.tableau.com/app/profile/zachary.wolfe4241/viz/Presentation_17695237104710/BankAnalysis?publish=yes))

raw_data/
└─ bank-additional-full.csv
↓
data_preprocessing.py (cleaning & preparation)
↓
prod_data/
└─ cleaned dataset
↓
sqlite3 database
└─ general_stats

## Getting Started

1. Run `data_preprocessing.py` to clean raw data
2. Output flows to `prod_data/`
3. Load into sqlite3 database for analysis