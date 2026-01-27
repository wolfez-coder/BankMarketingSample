# BankMarketingSample

> **⚠️ FOR TESTING PURPOSES ONLY**

Data analysis pipeline for bank marketing dataset.

## Project Structure
The following data is sourced from: ([source](https://archive.ics.uci.edu/dataset/222/bank+marketing))

- **`data_preprocessing.py`** - Base level data cleaning and preparation
- **`raw_data/`** - Raw input data
- **`prod_data/`** - Cleaned production-ready data
- **`SQL/`** - Initial analysis
- **Tableau Public** - Interactive visualizations ([Bank Data Presentation](https://public.tableau.com/views/Presentation_17695237104710/BankAnalysis?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link))

## Getting Started

1. Run `data_preprocessing.py` to clean raw data
2. Output flows to `prod_data/`
3. Load into sqlite3 database for analysis
