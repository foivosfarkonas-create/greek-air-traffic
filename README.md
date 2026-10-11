# Greek Air Traffic

How much does each Greek airport depend on the summer tourist season?

This project analyses monthly passenger numbers for all 47 Greek airports reported to Eurostat, from 1999 to today. It looks at three questions:

1. Which airports carry the most passengers?
2. How seasonal is each airport (summer vs. winter traffic)?
3. How did traffic change before, during and after COVID-19?

*Work in progress: the analysis notebook and findings are coming next.*

## Data

- Source: [Eurostat, dataset `avia_paoa`](https://ec.europa.eu/eurostat/databrowser/view/avia_paoa/default/table) (air passenger transport by main airports)
- Measure: passengers carried, all flights (scheduled and charter), all destinations
- File: `data/greek_airports_passengers.csv`

## How to run

Requirements: Windows with PowerShell and Python 3.13.

```powershell
# 1. Create a virtual environment and install the libraries
python -m venv .venv
.venv\Scripts\python.exe -m pip install -r requirements.txt

# 2. (Optional) Download the latest data from Eurostat
powershell -ExecutionPolicy Bypass -File .\download_data.ps1
```

## Tools

Python, pandas, matplotlib, Jupyter.
