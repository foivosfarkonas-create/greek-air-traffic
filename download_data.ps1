# Downloads monthly passenger numbers for every Greek airport from Eurostat
# and saves them to data/greek_airports_passengers.csv
#
# Dataset: avia_paoa (air passenger transport by main airports)
# https://ec.europa.eu/eurostat/databrowser/view/avia_paoa/default/table
#
# Run from the project folder:  .\download_data.ps1

$dataset = "avia_paoa"
$apiBase = "https://ec.europa.eu/eurostat/api/dissemination"

# Step 1: get the list of all airports in the dataset and keep the Greek ones.
# Greek airport codes start with "EL_" (Eurostat uses EL for Greece).
Write-Host "Finding Greek airports..."
$metadataUrl = "$apiBase/statistics/1.0/data/${dataset}?freq=M&unit=PAS&tra_meas=PAS_CRD&schedule=TOTAL&tra_cov=TOTAL&lastTimePeriod=1"
$metadata = Invoke-RestMethod -Uri $metadataUrl -TimeoutSec 120
$airportCodes = @($metadata.dimension.rep_airp.category.label.PSObject.Properties.Name) |
    Where-Object { $_ -like "EL_*" }
Write-Host "Found $($airportCodes.Count) Greek airports."

# Step 2: download all months for those airports as a CSV file.
# The key selects: monthly (M), passengers (PAS), passengers carried (PAS_CRD),
# the Greek airports, all schedule types (TOTAL), all destinations (TOTAL).
$airports = $airportCodes -join "+"
$key = "M.PAS.PAS_CRD.$airports.TOTAL.TOTAL"
$csvUrl = "$apiBase/sdmx/2.1/data/$dataset/${key}?format=SDMX-CSV"

New-Item -ItemType Directory -Force "data" | Out-Null
Write-Host "Downloading data..."
Invoke-WebRequest -Uri $csvUrl -OutFile "data\greek_airports_passengers.csv" -TimeoutSec 300
Write-Host "Saved to data\greek_airports_passengers.csv"
