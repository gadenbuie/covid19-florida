Florida COVID-19 Data
================
2020-08-04 19:06:25

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-04 | 497,330  | 0                  | 7,526  | 0                | 3,784,458 |
| Yesterday   | 2020-08-03 | 491,884  | 5,446              | 7,279  | 247              | 3,752,798 |
| Last Week   | 2020-07-28 | 441,977  | 55,353             | 6,240  | 1,286            | 3,480,299 |
| 2 Weeks Ago | 2020-07-21 | 369,834  | 127,496            | 5,319  | 2,207            | 3,099,750 |

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
| All          |                           7857 | <span style="color: #6BAA75">↓ -81</span> | 20451<span style="color: #aaa">/46088</span> | 1002<span style="color: #aaa">/5179</span> |
| Miami-Dade   |                           1718 | <span style="color: #EC4E20">↑ 63</span>  | 1664<span style="color: #aaa">/6822</span>   | 123<span style="color: #aaa">/879</span>   |
| Broward      |                           1103 | <span style="color: #6BAA75">↓ -20</span> | 1003<span style="color: #aaa">/4375</span>   | 48<span style="color: #aaa">/474</span>    |
| Palm Beach   |                            476 | <span style="color: #6BAA75">↓ -50</span> | 1241<span style="color: #aaa">/2964</span>   | 88<span style="color: #aaa">/331</span>    |
| Hillsborough |                            468 | <span style="color: #EC4E20">↑ 17</span>  | 584<span style="color: #aaa">/3275</span>    | 11<span style="color: #aaa">/376</span>    |
| Duval        |                            451 | <span style="color: #EC4E20">↑ 13</span>  | 1005<span style="color: #aaa">/2763</span>   | 96<span style="color: #aaa">/341</span>    |
| Orange       |                            413 | <span style="color: #6BAA75">↓ -19</span> | 960<span style="color: #aaa">/3442</span>    | 79<span style="color: #aaa">/293</span>    |
| Pinellas     |                            326 | <span style="color: #EC4E20">↑ 6</span>   | 559<span style="color: #aaa">/2351</span>    | 29<span style="color: #aaa">/258</span>    |
| Polk         |                            256 | <span style="color: #6BAA75">↓ -11</span> | 385<span style="color: #aaa">/1269</span>    | 8<span style="color: #aaa">/148</span>     |
| Lee          |                            233 | <span style="color: #EC4E20">↑ 19</span>  | 304<span style="color: #aaa">/1462</span>    | 22<span style="color: #aaa">/109</span>    |
| Escambia     |                            180 | <span style="color: #6BAA75">↓ -3</span>  | 388<span style="color: #aaa">/1085</span>    | 9<span style="color: #aaa">/138</span>     |

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
