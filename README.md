Florida COVID-19 Data
================
2020-07-20 19:05:13

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-20 | 360,394  | 0                  | 5,183  | 0                | 3,052,106 |
| Yesterday   | 2020-07-19 | 350,047  | 10,347             | 5,091  | 92               | 3,002,641 |
| Last Week   | 2020-07-13 | 282,435  | 77,959             | 4,381  | 802              | 2,639,574 |
| 2 Weeks Ago | 2020-07-06 | 206,447  | 153,947            | 3,880  | 1,303            | 2,233,940 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                    | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :---------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           9489 | <span style="color: #EC4E20">↑ 126</span> | 14156<span style="color: #aaa">/45913</span> | 1106<span style="color: #aaa">/5030</span> |
| Miami-Dade   |                           2052 | <span style="color: #EC4E20">↑ 44</span>  | 1518<span style="color: #aaa">/6945</span>   | 148<span style="color: #aaa">/824</span>   |
| Broward      |                           1266 | <span style="color: #EC4E20">↑ 26</span>  | 955<span style="color: #aaa">/4391</span>    | 57<span style="color: #aaa">/461</span>    |
| Palm Beach   |                            624 | <span style="color: #EC4E20">↑ 6</span>   | 1284<span style="color: #aaa">/2899</span>   | 106<span style="color: #aaa">/319</span>   |
| Orange       |                            605 | <span style="color: #6BAA75">↓ -7</span>  | 1132<span style="color: #aaa">/3261</span>   | 79<span style="color: #aaa">/293</span>    |
| Hillsborough |                            563 | <span style="color: #EC4E20">↑ 8</span>   | 685<span style="color: #aaa">/3275</span>    | 43<span style="color: #aaa">/349</span>    |
| Duval        |                            522 | <span style="color: #EC4E20">↑ 1</span>   | 886<span style="color: #aaa">/2908</span>    | 96<span style="color: #aaa">/340</span>    |
| Pinellas     |                            481 | <span style="color: #EC4E20">↑ 15</span>  | 518<span style="color: #aaa">/2388</span>    | 51<span style="color: #aaa">/246</span>    |
| Polk         |                            284 | <span style="color: #6BAA75">↓ -16</span> | 369<span style="color: #aaa">/1287</span>    | 8<span style="color: #aaa">/156</span>     |
| Lee          |                            276 | <span style="color: #EC4E20">↑ 24</span>  | 291<span style="color: #aaa">/1540</span>    | 18<span style="color: #aaa">/123</span>    |
| Escambia     |                            207 | <span style="color: #EC4E20">↑ 9</span>   | 380<span style="color: #aaa">/984</span>     | 5<span style="color: #aaa">/113</span>     |

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
