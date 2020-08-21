Florida COVID-19 Data
================
2020-08-21 19:11:33

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-21 | 593,286  | 0                  | 10,304 | 0                | 4,367,212 |
| Yesterday   | 2020-08-20 | 588,602  | 4,684              | 10,186 | 118              | 4,335,752 |
| Last Week   | 2020-08-14 | 563,285  | 30,001             | 9,276  | 1,028            | 4,160,565 |
| 2 Weeks Ago | 2020-08-07 | 518,075  | 75,211             | 8,051  | 2,253            | 3,896,939 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                     | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :----------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           4902 | <span style="color: #6BAA75">↓ -165</span> | 14315<span style="color: #aaa">/46562</span> | 1172<span style="color: #aaa">/4925</span> |
| Miami-Dade   |                            937 | <span style="color: #6BAA75">↓ -14</span>  | 1973<span style="color: #aaa">/6621</span>   | 157<span style="color: #aaa">/824</span>   |
| Broward      |                            664 | <span style="color: #6BAA75">↓ -26</span>  | 993<span style="color: #aaa">/4178</span>    | 76<span style="color: #aaa">/435</span>    |
| Duval        |                            289 | <span style="color: #EC4E20">↑ 12</span>   | 880<span style="color: #aaa">/2813</span>    | 96<span style="color: #aaa">/345</span>    |
| Palm Beach   |                            288 | <span style="color: #6BAA75">↓ -20</span>  | 1378<span style="color: #aaa">/2743</span>   | 111<span style="color: #aaa">/301</span>   |
| Orange       |                            259 | <span style="color: #6BAA75">↓ -14</span>  | 910<span style="color: #aaa">/3447</span>    | 81<span style="color: #aaa">/291</span>    |
| Hillsborough |                            238 | <span style="color: #6BAA75">↓ -9</span>   | 602<span style="color: #aaa">/3220</span>    | 45<span style="color: #aaa">/318</span>    |
| Pinellas     |                            169 | <span style="color: #6BAA75">↓ -8</span>   | 709<span style="color: #aaa">/2263</span>    | 62<span style="color: #aaa">/244</span>    |
| Polk         |                            148 | <span style="color: #6BAA75">↓ -7</span>   | 312<span style="color: #aaa">/1328</span>    | 20<span style="color: #aaa">/132</span>    |
| Lee          |                            140 | <span style="color: #6BAA75">↓ -4</span>   | 435<span style="color: #aaa">/1441</span>    | 37<span style="color: #aaa">/104</span>    |
| Escambia     |                            123 | <span style="color: #6BAA75">↓ -4</span>   | 439<span style="color: #aaa">/1049</span>    | 3<span style="color: #aaa">/138</span>     |

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
