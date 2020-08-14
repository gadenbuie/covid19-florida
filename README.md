Florida COVID-19 Data
================
2020-08-14 19:18:19

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-14 | 563,285  | 0                  | 9,276  | 0                | 4,160,565 |
| Yesterday   | 2020-08-13 | 557,137  | 6,148              | 9,047  | 229              | 4,122,118 |
| Last Week   | 2020-08-07 | 518,075  | 45,210             | 8,051  | 1,225            | 3,896,939 |
| 2 Weeks Ago | 2020-07-31 | 470,386  | 92,899             | 6,966  | 2,310            | 3,628,088 |

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
| All          |                           5893 | <span style="color: #6BAA75">↓ -432</span> | 14173<span style="color: #aaa">/46350</span> | 1186<span style="color: #aaa">/5013</span> |
| Miami-Dade   |                           1203 | <span style="color: #6BAA75">↓ -89</span>  | 1963<span style="color: #aaa">/6539</span>   | 165<span style="color: #aaa">/826</span>   |
| Broward      |                            769 | <span style="color: #6BAA75">↓ -98</span>  | 938<span style="color: #aaa">/4230</span>    | 68<span style="color: #aaa">/451</span>    |
| Palm Beach   |                            363 | <span style="color: #6BAA75">↓ -24</span>  | 1320<span style="color: #aaa">/2825</span>   | 115<span style="color: #aaa">/301</span>   |
| Hillsborough |                            322 | <span style="color: #6BAA75">↓ -9</span>   | 598<span style="color: #aaa">/3175</span>    | 47<span style="color: #aaa">/335</span>    |
| Duval        |                            317 | <span style="color: #6BAA75">↓ -25</span>  | 846<span style="color: #aaa">/2821</span>    | 107<span style="color: #aaa">/335</span>   |
| Orange       |                            263 | <span style="color: #6BAA75">↓ -25</span>  | 953<span style="color: #aaa">/3437</span>    | 86<span style="color: #aaa">/286</span>    |
| Pinellas     |                            257 | <span style="color: #EC4E20">↑ 1</span>    | 558<span style="color: #aaa">/2399</span>    | 47<span style="color: #aaa">/251</span>    |
| Polk         |                            180 | <span style="color: #6BAA75">↓ -45</span>  | 401<span style="color: #aaa">/1267</span>    | 29<span style="color: #aaa">/143</span>    |
| Lee          |                            175 | <span style="color: #EC4E20">↑ 3</span>    | 349<span style="color: #aaa">/1439</span>    | 32<span style="color: #aaa">/109</span>    |
| Escambia     |                            157 | <span style="color: #6BAA75">↓ -6</span>   | 381<span style="color: #aaa">/1114</span>    | 9<span style="color: #aaa">/138</span>     |

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
