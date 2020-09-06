Florida COVID-19 Data
================
2020-09-06 12:17:13

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-09-06 | 646,431  | 0                  | 12,001 | 0                | 4,784,770 |
| Yesterday   | 2020-09-05 | 643,867  | 2,564              | 11,963 | 38               | 4,763,807 |
| Last Week   | 2020-08-30 | 621,586  | 24,845             | 11,263 | 738              | 4,599,608 |
| 2 Weeks Ago | 2020-08-23 | 600,571  | 45,860             | 10,462 | 1,539            | 4,428,633 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                   | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :--------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           3226 | <span style="color: #6BAA75">↓ -3</span> | 16544<span style="color: #aaa">/43983</span> | 1379<span style="color: #aaa">/4587</span> |
| Miami-Dade   |                            573 | <span style="color: #6BAA75">↓ -3</span> | 2508<span style="color: #aaa">/5971</span>   | 163<span style="color: #aaa">/768</span>   |
| Broward      |                            371 |                                          | 1169<span style="color: #aaa">/3896</span>   | 91<span style="color: #aaa">/380</span>    |
| Duval        |                            198 |                                          | 1111<span style="color: #aaa">/2727</span>   | 132<span style="color: #aaa">/305</span>   |
| Palm Beach   |                            167 |                                          | 1323<span style="color: #aaa">/2664</span>   | 125<span style="color: #aaa">/276</span>   |
| Hillsborough |                            166 |                                          | 739<span style="color: #aaa">/2958</span>    | 51<span style="color: #aaa">/318</span>    |
| Orange       |                            143 |                                          | 1114<span style="color: #aaa">/3271</span>   | 113<span style="color: #aaa">/263</span>   |
| Pinellas     |                            132 |                                          | 1068<span style="color: #aaa">/2098</span>   | 62<span style="color: #aaa">/229</span>    |
| Gadsden      |                            124 |                                          | 208<span style="color: #aaa">/745</span>     | 0<span style="color: #aaa">/0</span>       |
| Polk         |                            107 |                                          | 404<span style="color: #aaa">/1208</span>    | 23<span style="color: #aaa">/117</span>    |
| Lee          |                             97 |                                          | 423<span style="color: #aaa">/1437</span>    | 29<span style="color: #aaa">/111</span>    |

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
