Florida COVID-19 Data
================
2020-10-27 12:09:56

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-27 | 786,311  | 0                  | 16,709 | 0                | 6,014,492 |
| Yesterday   | 2020-10-26 | 782,013  | 4,298              | 16,652 | 57               | 5,984,749 |
| Last Week   | 2020-10-20 | 760,389  | 25,922             | 16,308 | 401              | 5,767,947 |
| 2 Weeks Ago | 2020-10-13 | 738,749  | 47,562             | 15,722 | 987              | 5,593,424 |

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
| All          |                           2340 | <span style="color: #EC4E20">↑ 83</span> | 16327<span style="color: #aaa">/44470</span> | 1621<span style="color: #aaa">/4438</span> |
| Miami-Dade   |                            331 | <span style="color: #EC4E20">↑ 20</span> | 2558<span style="color: #aaa">/6034</span>   | 238<span style="color: #aaa">/712</span>   |
| Broward      |                            209 | <span style="color: #EC4E20">↑ 10</span> | 1103<span style="color: #aaa">/4007</span>   | 101<span style="color: #aaa">/353</span>   |
| Hillsborough |                            155 | <span style="color: #6BAA75">↓ -3</span> | 847<span style="color: #aaa">/3134</span>    | 69<span style="color: #aaa">/318</span>    |
| Orange       |                            142 | <span style="color: #EC4E20">↑ 4</span>  | 1211<span style="color: #aaa">/3166</span>   | 155<span style="color: #aaa">/249</span>   |
| Palm Beach   |                            132 | <span style="color: #6BAA75">↓ -2</span> | 1426<span style="color: #aaa">/2726</span>   | 161<span style="color: #aaa">/229</span>   |
| Pinellas     |                            131 | <span style="color: #EC4E20">↑ 4</span>  | 930<span style="color: #aaa">/2260</span>    | 79<span style="color: #aaa">/225</span>    |
| Duval        |                            117 | <span style="color: #EC4E20">↑ 4</span>  | 1006<span style="color: #aaa">/2604</span>   | 136<span style="color: #aaa">/301</span>   |
| Osceola      |                             82 | <span style="color: #EC4E20">↑ 5</span>  | 314<span style="color: #aaa">/832</span>     | 45<span style="color: #aaa">/78</span>     |
| Polk         |                             78 | <span style="color: #6BAA75">↓ -4</span> | 429<span style="color: #aaa">/1246</span>    | 49<span style="color: #aaa">/131</span>    |
| Alachua      |                             63 | <span style="color: #EC4E20">↑ 3</span>  | 310<span style="color: #aaa">/1406</span>    | 51<span style="color: #aaa">/257</span>    |

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
