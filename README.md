Florida COVID-19 Data
================
2020-08-27 19:10:42

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-27 | 611,991  | 0                  | 11,011 | 0                | 4,517,364 |
| Yesterday   | 2020-08-26 | 608,722  | 3,269              | 10,872 | 139              | 4,492,818 |
| Last Week   | 2020-08-20 | 588,602  | 23,389             | 10,186 | 825              | 4,335,752 |
| 2 Weeks Ago | 2020-08-13 | 557,137  | 54,854             | 9,047  | 1,964            | 4,122,118 |

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
| All          |                           4252 | <span style="color: #6BAA75">↓ -153</span> | 14549<span style="color: #aaa">/46425</span> | 1223<span style="color: #aaa">/4847</span> |
| Miami-Dade   |                            767 | <span style="color: #6BAA75">↓ -35</span>  | 2237<span style="color: #aaa">/6268</span>   | 173<span style="color: #aaa">/781</span>   |
| Broward      |                            543 | <span style="color: #6BAA75">↓ -16</span>  | 909<span style="color: #aaa">/4053</span>    | 86<span style="color: #aaa">/411</span>    |
| Duval        |                            264 | <span style="color: #EC4E20">↑ 12</span>   | 950<span style="color: #aaa">/3125</span>    | 92<span style="color: #aaa">/345</span>    |
| Palm Beach   |                            238 | <span style="color: #6BAA75">↓ -15</span>  | 1286<span style="color: #aaa">/2747</span>   | 118<span style="color: #aaa">/286</span>   |
| Hillsborough |                            206 | <span style="color: #6BAA75">↓ -4</span>   | 612<span style="color: #aaa">/3173</span>    | 47<span style="color: #aaa">/334</span>    |
| Orange       |                            199 | <span style="color: #6BAA75">↓ -14</span>  | 1020<span style="color: #aaa">/3438</span>   | 84<span style="color: #aaa">/288</span>    |
| Gadsden      |                            181 | <span style="color: #EC4E20">↑ 16</span>   | 197<span style="color: #aaa">/756</span>     | 0<span style="color: #aaa">/0</span>       |
| Polk         |                            145 | <span style="color: #6BAA75">↓ -8</span>   | 300<span style="color: #aaa">/1343</span>    | 15<span style="color: #aaa">/137</span>    |
| Pinellas     |                            135 | <span style="color: #6BAA75">↓ -1</span>   | 808<span style="color: #aaa">/2134</span>    | 51<span style="color: #aaa">/251</span>    |
| Lee          |                            120 | <span style="color: #6BAA75">↓ -7</span>   | 392<span style="color: #aaa">/1499</span>    | 32<span style="color: #aaa">/109</span>    |

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
