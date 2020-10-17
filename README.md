Florida COVID-19 Data
================
2020-10-17 12:08:33

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-17 | 752,481  | 0                  | 16,118 | 0                | 5,704,100 |
| Yesterday   | 2020-10-16 | 748,437  | 4,044              | 16,030 | 88               | 5,673,685 |
| Last Week   | 2020-10-10 | 728,921  | 23,560             | 15,372 | 746              | 5,518,162 |
| 2 Weeks Ago | 2020-10-03 | 714,591  | 37,890             | 14,803 | 1,315            | 5,376,459 |

Parsed from the [Florida’s COVID-19 Data and Surveillance
Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86).

Prior to 2020-04-25, Florida DOH published updated data twice per day.
Starting 2020-04-25, Florida DOH updates once per day at approximately
11am. Since 2020-05-06, the updates are occasionally later in the day.
In the following charts, for a given day, I use the last value reported
prior to 8am of the subsequent day. I take snapshots of the various FL
DOH data sources at 7am, noon and 7pm daily.

## Confirmed Cases

![](plots/covid-19-florida-daily-test-changes.png)

![](plots/covid-19-florida-deaths-by-day.png)

![](plots/covid-19-florida-county-top-6.png)

<div class="columns">

<div class="column is-full-mobile">

![](plots/covid-19-florida-testing.png)

</div>

<div class="column is-full-mobile">

![](plots/covid-19-florida-total-positive.png)

</div>

</div>

## Hospital and ICU Utilization

| County       | Current COVID Hospitalizations | Change Since Yesterday | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :--------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           2083 |                        | 15186<span style="color: #aaa">/46478</span> | 1413<span style="color: #aaa">/4591</span> |
| Miami-Dade   |                            267 |                        | 2290<span style="color: #aaa">/6339</span>   | 223<span style="color: #aaa">/724</span>   |
| Broward      |                            177 |                        | 1044<span style="color: #aaa">/4183</span>   | 96<span style="color: #aaa">/335</span>    |
| Hillsborough |                            144 |                        | 476<span style="color: #aaa">/3247</span>    | 35<span style="color: #aaa">/324</span>    |
| Orange       |                            130 |                        | 1619<span style="color: #aaa">/3357</span>   | 129<span style="color: #aaa">/275</span>   |
| Duval        |                            129 |                        | 844<span style="color: #aaa">/2922</span>    | 89<span style="color: #aaa">/348</span>    |
| Pinellas     |                            121 |                        | 963<span style="color: #aaa">/2301</span>    | 61<span style="color: #aaa">/244</span>    |
| Palm Beach   |                             99 |                        | 1293<span style="color: #aaa">/2722</span>   | 142<span style="color: #aaa">/258</span>   |
| Polk         |                             82 |                        | 357<span style="color: #aaa">/1292</span>    | 34<span style="color: #aaa">/128</span>    |
| Brevard      |                             77 |                        | 391<span style="color: #aaa">/1241</span>    | 37<span style="color: #aaa">/130</span>    |
| Osceola      |                             70 |                        | 291<span style="color: #aaa">/885</span>     | 41<span style="color: #aaa">/86</span>     |

![](plots/covid-19-florida-icu-usage.png)

## Daily Testing

![](plots/covid-19-florida-tests-per-case.png)

<!-- ![](plots/covid-19-florida-change-new-cases.png) -->

![](plots/covid-19-florida-tests-percent-positive.png)

![](plots/covid-19-florida-test-and-case-growth.png)

## Cases and Deaths by Age

![](plots/covid-19-florida-weekly-events-by-age.png)

![](plots/covid-19-florida-age.png)

![](plots/covid-19-florida-age-deaths.png)

![](plots/covid-19-florida-age-sex.png)

## Sources

  - [Florida’s COVID-19 Data and Surveillance
    Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86)

  - [Florida Department of Health COVID-19 status
    page](http://www.floridahealth.gov/diseases-and-conditions/COVID-19/)

  - PDF Reports released daily on [Florida Disaster
    Covid-19](http://www.floridahealth.gov/diseases-and-conditions/COVID-19/)

The data structure and format of the released data changes frequently.
I’m keeping track of the impact of these changes in this repo in
[NEWS.md](NEWS.md).

## FL DOH Dashboard

One table is extracted from the [Florida’s COVID-19 Data and
Surveillance
Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86).

  - Current test counts:
    [data/covid-19-florida\_dash\_summary.csv](data/covid-19-florida_dash_summary.csv)

The `timestamp` column of indicates when the dashboard was polled for
changes.

Testing statistics prior to 2020-03-16 18:00:00 EDT were imported from
<https://covidtracking.com>.

![](screenshots/fodh_maps_arcgis_com__apps__opsdashboard.png)

## Snapshots and Data Capture

Initially this repo gathered data from the [Florida Department of Health
COVID-19 status
page](http://www.floridahealth.gov/diseases-and-conditions/COVID-19/).
This page has been [reformatted several
times](screenshots/floridahealth_gov__diseases-and-conditions__COVID-19.png)
and the data structure changes frequently, so currently I am collecting
snapshots of the webpage and not trying to parse these tables.

I am also capturing a snapshot (HTML) and screenshot of the [Florida’s
COVID-19 Data and Surveillance
Dashboard](https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86).
Data extracted from the dashboard are currently used for the current
test count summaries, available in
[covid-19-florida-tests.csv](covid-19-florida-tests.csv).

Prior to the afternoon of 2020-03-18, the dashboard reported
county-level case counts. Around 4pm on 2020-03-18, the dashboard layout
was modified, making these counts inaccessible. Similarly, prior to this
update I was relying on the reported “last update time” listed in the
dashboard, but since then I have been using the time at which the
dashboard was checked for any time stamps from this source.

On the same day that county-level data became inaccessible in the
dashboard, FL DOH started releasing PDF reports, which I have begun to
collect in [pdfs/](pdfs/). The name of the report contains a time stamp,
therefore I am periodically checking the FL DOH web page for the updated
link. I’ve been able to extract most of the data from the PDF tables.
Individual tables are stored in time stamped folders, using the time
stamp in the PDF file name. The unified data files are available in
[data/](data/) and prefixed with `covid-19-florida_pdf_`.
