Florida COVID-19 Data
================
2020-08-08 19:09:11

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-08 | 526,577  | 0                  | 8,238  | 0                | 3,945,872 |
| Yesterday   | 2020-08-07 | 518,075  | 8,502              | 8,051  | 187              | 3,896,939 |
| Last Week   | 2020-08-01 | 480,028  | 46,549             | 7,144  | 1,094            | 3,679,443 |
| 2 Weeks Ago | 2020-07-25 | 414,511  | 112,066            | 5,894  | 2,344            | 3,336,377 |

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
| All          |                           7116 | <span style="color: #6BAA75">↓ -28</span> | 14977<span style="color: #aaa">/44717</span> | 1157<span style="color: #aaa">/5034</span> |
| Miami-Dade   |                           1587 | <span style="color: #6BAA75">↓ -13</span> | 1836<span style="color: #aaa">/6665</span>   | 134<span style="color: #aaa">/859</span>   |
| Broward      |                           1022 | <span style="color: #EC4E20">↑ 1</span>   | 982<span style="color: #aaa">/4186</span>    | 52<span style="color: #aaa">/468</span>    |
| Palm Beach   |                            422 | <span style="color: #6BAA75">↓ -14</span> | 1465<span style="color: #aaa">/2709</span>   | 112<span style="color: #aaa">/306</span>   |
| Hillsborough |                            383 |                                           | 669<span style="color: #aaa">/3157</span>    | 61<span style="color: #aaa">/335</span>    |
| Duval        |                            371 | <span style="color: #6BAA75">↓ -1</span>  | 983<span style="color: #aaa">/2776</span>    | 101<span style="color: #aaa">/340</span>   |
| Orange       |                            363 | <span style="color: #EC4E20">↑ 13</span>  | 1021<span style="color: #aaa">/3377</span>   | 92<span style="color: #aaa">/280</span>    |
| Pinellas     |                            276 | <span style="color: #6BAA75">↓ -3</span>  | 684<span style="color: #aaa">/2197</span>    | 58<span style="color: #aaa">/235</span>    |
| Polk         |                            231 | <span style="color: #6BAA75">↓ -20</span> | 414<span style="color: #aaa">/1243</span>    | 25<span style="color: #aaa">/145</span>    |
| Lee          |                            201 | <span style="color: #6BAA75">↓ -5</span>  | 353<span style="color: #aaa">/1432</span>    | 34<span style="color: #aaa">/107</span>    |
| Escambia     |                            165 | <span style="color: #EC4E20">↑ 1</span>   | 474<span style="color: #aaa">/1021</span>    | 7<span style="color: #aaa">/140</span>     |

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
