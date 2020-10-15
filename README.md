Florida COVID-19 Data
================
2020-10-15 19:08:59

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-15 | 744,988  | 0                  | 15,932 | 0                | 5,643,521 |
| Yesterday   | 2020-10-14 | 741,632  | 3,356              | 15,788 | 144              | 5,615,247 |
| Last Week   | 2020-10-08 | 726,013  | 18,975             | 15,254 | 678              | 5,489,758 |
| 2 Weeks Ago | 2020-10-01 | 709,144  | 35,844             | 14,619 | 1,313            | 5,325,835 |

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
| All          |                           2119 | <span style="color: #6BAA75">↓ -36</span> | 14886<span style="color: #aaa">/46759</span> | 1405<span style="color: #aaa">/4624</span> |
| Miami-Dade   |                            282 | <span style="color: #EC4E20">↑ 10</span>  | 2332<span style="color: #aaa">/6300</span>   | 236<span style="color: #aaa">/710</span>   |
| Broward      |                            183 | <span style="color: #EC4E20">↑ 11</span>  | 979<span style="color: #aaa">/4213</span>    | 104<span style="color: #aaa">/340</span>   |
| Hillsborough |                            155 | <span style="color: #EC4E20">↑ 1</span>   | 501<span style="color: #aaa">/3258</span>    | 68<span style="color: #aaa">/311</span>    |
| Orange       |                            141 | <span style="color: #6BAA75">↓ -5</span>  | 1631<span style="color: #aaa">/3356</span>   | 130<span style="color: #aaa">/274</span>   |
| Duval        |                            121 | <span style="color: #6BAA75">↓ -16</span> | 812<span style="color: #aaa">/2930</span>    | 84<span style="color: #aaa">/353</span>    |
| Palm Beach   |                            115 | <span style="color: #6BAA75">↓ -1</span>  | 1320<span style="color: #aaa">/2697</span>   | 145<span style="color: #aaa">/258</span>   |
| Pinellas     |                            113 | <span style="color: #6BAA75">↓ -15</span> | 900<span style="color: #aaa">/2344</span>    | 50<span style="color: #aaa">/249</span>    |
| Polk         |                             80 | <span style="color: #6BAA75">↓ -5</span>  | 319<span style="color: #aaa">/1328</span>    | 22<span style="color: #aaa">/136</span>    |
| Brevard      |                             75 | <span style="color: #6BAA75">↓ -2</span>  | 414<span style="color: #aaa">/1229</span>    | 37<span style="color: #aaa">/130</span>    |
| Osceola      |                             71 | <span style="color: #6BAA75">↓ -5</span>  | 284<span style="color: #aaa">/877</span>     | 40<span style="color: #aaa">/82</span>     |

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
