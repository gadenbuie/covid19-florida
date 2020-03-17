# Florida COVID-19 Data

Parsed from the [Florida Department of Health COVID-19 status page][main-page].

![](plots/covid-19-florida-testing.png)

## FL DOH Main Page

The table from the FL DOH main page is parsed and saved verbatim into [covid-19-florida-doh.csv](covid-19-florida-doh.csv). The "as of" timestamp listed on the web page is added into the table in the `timestamp` column.

[screenshot](screenshots/floridahealth_gov__diseases-and-conditions__COVID-19.png)

## FL DOH Dashboard

Two tables are extracted from the [Florida's COVID-19 Data and Surveillance Dashboard][dashboard].

- County-level case count: [covid-19-florida-cases-county.csv](covid-19-florida-cases-county.csv)
- Current test counts: [covid-19-florida-tests.csv](covid-19-florida-tests.csv)

The "last updated timestamp" is also extracted from the dashboard and saved in the `timestamp` column of both of the above tables.

Testing statistics prior to 2020-03-16 18:00:00 EDT were imported from <https://covidtracking.com>.

![](screenshots/fodh_maps_arcgis_com__apps__opsdashboard.png)

[main-page]: http://www.floridahealth.gov/diseases-and-conditions/COVID-19/
[dashboard]: https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86