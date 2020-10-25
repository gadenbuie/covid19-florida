Florida COVID-19 Data
================
2020-10-25 19:05:40

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-25 | 778,636  | 0                  | 16,632 | 0                | 5,952,723 |
| Yesterday   | 2020-10-24 | 776,251  | 2,385              | 16,620 | 12               | 5,938,061 |
| Last Week   | 2020-10-18 | 755,020  | 23,616             | 16,168 | 464              | 5,722,392 |
| 2 Weeks Ago | 2020-10-11 | 734,491  | 44,145             | 15,552 | 1,080            | 5,550,531 |

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
| All          |                           2219 | <span style="color: #EC4E20">↑ 59</span>  | 16773<span style="color: #aaa">/43949</span> | 1646<span style="color: #aaa">/4430</span> |
| Miami-Dade   |                            295 | <span style="color: #EC4E20">↑ 11</span>  | 2648<span style="color: #aaa">/5934</span>   | 257<span style="color: #aaa">/686</span>   |
| Broward      |                            189 | <span style="color: #6BAA75">↓ -13</span> | 1082<span style="color: #aaa">/4055</span>   | 115<span style="color: #aaa">/344</span>   |
| Hillsborough |                            147 | <span style="color: #EC4E20">↑ 2</span>   | 862<span style="color: #aaa">/3089</span>    | 41<span style="color: #aaa">/343</span>    |
| Orange       |                            141 | <span style="color: #EC4E20">↑ 4</span>   | 1235<span style="color: #aaa">/3229</span>   | 147<span style="color: #aaa">/257</span>   |
| Palm Beach   |                            134 | <span style="color: #EC4E20">↑ 6</span>   | 1382<span style="color: #aaa">/2625</span>   | 148<span style="color: #aaa">/244</span>   |
| Pinellas     |                            127 | <span style="color: #EC4E20">↑ 5</span>   | 999<span style="color: #aaa">/2144</span>    | 72<span style="color: #aaa">/233</span>    |
| Duval        |                            116 | <span style="color: #EC4E20">↑ 4</span>   | 1088<span style="color: #aaa">/2657</span>   | 128<span style="color: #aaa">/309</span>   |
| Polk         |                             84 | <span style="color: #EC4E20">↑ 2</span>   | 460<span style="color: #aaa">/1225</span>    | 55<span style="color: #aaa">/125</span>    |
| Osceola      |                             80 | <span style="color: #EC4E20">↑ 9</span>   | 313<span style="color: #aaa">/836</span>     | 44<span style="color: #aaa">/79</span>     |
| Lee          |                             66 | <span style="color: #EC4E20">↑ 6</span>   | 437<span style="color: #aaa">/1382</span>    | 32<span style="color: #aaa">/105</span>    |

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
