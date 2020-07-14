Florida COVID-19 Data
================
2020-07-14 10:19:34

## Today

| When           | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :------------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Yesterday      | 2020-07-13 | 282,435  | 0                  | 4,381  | 0                | 2,639,961 |
| The Day Before | 2020-07-12 | 269,811  | 12,624             | 4,346  | 35               | 2,574,394 |
| Last Week      | 2020-07-07 | 213,794  | 68,641             | 3,943  | 438              | 2,269,577 |
| 2 Weeks Ago    | 2020-06-30 | 152,434  | 130,001            | 3,604  | 777              | 1,945,385 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                   | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :--------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           8050 | <span style="color: #6BAA75">↓ -1</span> | 13756<span style="color: #aaa">/46213</span> | 1153<span style="color: #aaa">/4999</span> |
| Miami-Dade   |                           1808 |                                          | 1703<span style="color: #aaa">/6666</span>   | 155<span style="color: #aaa">/802</span>   |
| Broward      |                           1210 | <span style="color: #6BAA75">↓ -1</span> | 1028<span style="color: #aaa">/4396</span>   | 60<span style="color: #aaa">/459</span>    |
| Palm Beach   |                            622 |                                          | 1258<span style="color: #aaa">/2913</span>   | 109<span style="color: #aaa">/316</span>   |
| Orange       |                            561 |                                          | 1129<span style="color: #aaa">/3291</span>   | 101<span style="color: #aaa">/264</span>   |
| Duval        |                            530 |                                          | 976<span style="color: #aaa">/2835</span>    | 115<span style="color: #aaa">/325</span>   |
| Hillsborough |                            265 |                                          | 742<span style="color: #aaa">/3263</span>    | 39<span style="color: #aaa">/345</span>    |
| Lee          |                            234 |                                          | 277<span style="color: #aaa">/1484</span>    | 18<span style="color: #aaa">/121</span>    |
| Pinellas     |                            215 |                                          | 477<span style="color: #aaa">/2461</span>    | 26<span style="color: #aaa">/276</span>    |
| Osceola      |                            202 |                                          | 208<span style="color: #aaa">/837</span>     | 36<span style="color: #aaa">/91</span>     |
| Collier      |                            188 |                                          | 134<span style="color: #aaa">/741</span>     | 22<span style="color: #aaa">/58</span>     |

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
