
Florida COVID-19 Data
=====================

| When        | Day        |  Positive|  Deaths|  Negative|  Inconclusive|  Total|  Pending|
|:------------|:-----------|---------:|-------:|---------:|-------------:|------:|--------:|
| Today       | 2020-04-03 |      9585|     163|     82112|            58|  91755|     1225|
| Yesterday   | 2020-04-02 |      9008|     144|     71324|            53|  80385|     1389|
| Last Week   | 2020-03-27 |      3198|      46|     31106|            18|  34322|     2637|
| 2 Weeks Ago | 2020-03-20 |       563|      11|      5710|             0|   6273|     1094|

Parsed from the [Florida's COVID-19 Data and Surveillance Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86).

![](plots/covid-19-florida-testing.png)

![](plots/covid-19-florida-total-positive.png)

![](plots/covid-19-florida-county-top-6.png)

![](plots/covid-19-florida-change-new-cases.png)

![](plots/covid-19-florida-daily-test-changes.png)

![](plots/covid-19-florida-age.png)

![](plots/covid-19-florida-age-deaths.png)

![](plots/covid-19-florida-age-sex.png)

Sources
-------

-   [Florida's COVID-19 Data and Surveillance Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86)

-   [Florida Department of Health COVID-19 status page](http://www.floridahealth.gov/diseases-and-conditions/COVID-19/)

-   PDF Reports released daily on [Florida Disaster Covid-19](http://www.floridahealth.gov/diseases-and-conditions/COVID-19/)

The data structure and format of the released data changes frequently. I'm keeping track of the impact of these changes in this repo in [NEWS.md](NEWS.md).

FL DOH Dashboard
----------------

One table is extracted from the [Florida's COVID-19 Data and Surveillance Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86).

-   Current test counts: [data/covid-19-florida\_dash\_summary.csv](data/covid-19-florida_dash_summary.csv)

The `timestamp` column of indicates when the dashboard was polled for changes.

Testing statistics prior to 2020-03-16 18:00:00 EDT were imported from <https://covidtracking.com>.

![](screenshots/fodh_maps_arcgis_com__apps__opsdashboard.png)

Snapshots and Data Capture
--------------------------

Initially this repo gathered data from the [Florida Department of Health COVID-19 status page](http://www.floridahealth.gov/diseases-and-conditions/COVID-19/). This page has been [reformatted several times](screenshots/floridahealth_gov__diseases-and-conditions__COVID-19.png) and the data structure changes frequently, so currently I am collecting snapshots of the webpage and not trying to parse these tables.

I am also capturing a snapshot (HTML) and screenshot of the [Florida's COVID-19 Data and Surveillance Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86). Data extracted from the dashboard are currently used for the current test count summaries, available in [covid-19-florida-tests.csv](covid-19-florida-tests.csv).

Prior to the afternoon of 2020-03-18, the dashboard reported county-level case counts. Around 4pm on 2020-03-18, the dashboard layout was modified, making these counts inaccessible. Similarly, prior to this update I was relying on the reported "last update time" listed in the dashboard, but since then I have been using the time at which the dashboard was checked for any time stamps from this source.

On the same day that county-level data became inaccessible in the dashboard, FL DOH started releasing PDF reports, which I have begun to collect in [pdfs/](pdfs/). The name of the report contains a time stamp, therefore I am periodically checking the FL DOH web page for the updated link. I've been able to extract most of the data from the PDF tables. Individual tables are stored in time stamped folders, using the time stamp in the PDF file name. The unified data files are available in [data/](data/) and prefixed with `covid-19-florida_pdf_`.
