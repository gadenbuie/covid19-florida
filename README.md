Florida COVID-19 Data
================
2020-10-22 19:07:31

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-22 | 768,091  | 0                  | 16,470 | 0                | 5,821,939 |
| Yesterday   | 2020-10-21 | 762,533  | 5,558              | 16,413 | 57               | 5,779,019 |
| Last Week   | 2020-10-15 | 744,988  | 23,103             | 15,932 | 538              | 5,643,521 |
| 2 Weeks Ago | 2020-10-08 | 726,013  | 42,078             | 15,254 | 1,216            | 5,489,758 |

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
| All          |                           2074 | <span style="color: #6BAA75">↓ -46</span> | 14629<span style="color: #aaa">/46566</span> | 1370<span style="color: #aaa">/4679</span> |
| Miami-Dade   |                            275 | <span style="color: #EC4E20">↑ 2</span>   | 2381<span style="color: #aaa">/6278</span>   | 225<span style="color: #aaa">/723</span>   |
| Broward      |                            185 | <span style="color: #6BAA75">↓ -24</span> | 1001<span style="color: #aaa">/4216</span>   | 91<span style="color: #aaa">/358</span>    |
| Hillsborough |                            136 | <span style="color: #6BAA75">↓ -12</span> | 761<span style="color: #aaa">/3174</span>    | 72<span style="color: #aaa">/309</span>    |
| Orange       |                            116 | <span style="color: #EC4E20">↑ 4</span>   | 1051<span style="color: #aaa">/3410</span>   | 124<span style="color: #aaa">/278</span>   |
| Pinellas     |                            116 | <span style="color: #6BAA75">↓ -8</span>  | 771<span style="color: #aaa">/2344</span>    | 63<span style="color: #aaa">/240</span>    |
| Palm Beach   |                            114 | <span style="color: #EC4E20">↑ 2</span>   | 1235<span style="color: #aaa">/2797</span>   | 135<span style="color: #aaa">/259</span>   |
| Duval        |                            102 | <span style="color: #6BAA75">↓ -13</span> | 975<span style="color: #aaa">/2761</span>    | 110<span style="color: #aaa">/327</span>   |
| Osceola      |                             84 | <span style="color: #EC4E20">↑ 3</span>   | 287<span style="color: #aaa">/884</span>     | 30<span style="color: #aaa">/93</span>     |
| Polk         |                             83 | <span style="color: #EC4E20">↑ 4</span>   | 371<span style="color: #aaa">/1309</span>    | 42<span style="color: #aaa">/138</span>    |
| Lee          |                             67 | <span style="color: #EC4E20">↑ 4</span>   | 289<span style="color: #aaa">/1532</span>    | 24<span style="color: #aaa">/104</span>    |

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
