Florida COVID-19 Data
================
2020-09-18 12:11:32

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-09-18 | 677,660  | 0                  | 13,387 | 0                | 5,038,261 |
| Yesterday   | 2020-09-17 | 674,456  | 3,204              | 13,247 | 140              | 5,010,973 |
| Last Week   | 2020-09-11 | 658,381  | 19,279             | 12,658 | 729              | 4,876,756 |
| 2 Weeks Ago | 2020-09-04 | 640,211  | 37,449             | 11,903 | 1,484            | 4,740,007 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :--------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           2385 |                        | 14958<span style="color: #aaa">/46235</span> | 1366<span style="color: #aaa">/4640</span> |
| Miami-Dade   |                            374 |                        | 2334<span style="color: #aaa">/6164</span>   | 179<span style="color: #aaa">/757</span>   |
| Broward      |                            247 |                        | 1141<span style="color: #aaa">/4146</span>   | 101<span style="color: #aaa">/356</span>   |
| Palm Beach   |                            151 |                        | 1252<span style="color: #aaa">/2811</span>   | 153<span style="color: #aaa">/259</span>   |
| Duval        |                            150 |                        | 921<span style="color: #aaa">/2843</span>    | 117<span style="color: #aaa">/320</span>   |
| Hillsborough |                            136 |                        | 489<span style="color: #aaa">/3279</span>    | 30<span style="color: #aaa">/345</span>    |
| Orange       |                            112 |                        | 1117<span style="color: #aaa">/3351</span>   | 157<span style="color: #aaa">/247</span>   |
| Polk         |                            112 |                        | 317<span style="color: #aaa">/1310</span>    | 25<span style="color: #aaa">/125</span>    |
| Pinellas     |                             89 |                        | 880<span style="color: #aaa">/2251</span>    | 54<span style="color: #aaa">/227</span>    |
| Alachua      |                             77 |                        | 197<span style="color: #aaa">/1530</span>    | 30<span style="color: #aaa">/278</span>    |
| Leon         |                             63 |                        | 146<span style="color: #aaa">/718</span>     | 10<span style="color: #aaa">/62</span>     |

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
