Florida COVID-19 Data
================
2020-10-01 19:09:03

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-01 | 709,144  | 0                  | 14,619 | 0                | 5,325,835 |
| Yesterday   | 2020-09-30 | 706,516  | 2,628              | 14,488 | 131              | 5,301,184 |
| Last Week   | 2020-09-24 | 693,040  | 16,104             | 13,961 | 658              | 5,179,499 |
| 2 Weeks Ago | 2020-09-17 | 674,456  | 34,688             | 13,247 | 1,372            | 5,010,973 |

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
| All          |                           2080 | <span style="color: #6BAA75">↓ -18</span> | 14619<span style="color: #aaa">/46366</span> | 1366<span style="color: #aaa">/4649</span> |
| Miami-Dade   |                            280 | <span style="color: #EC4E20">↑ 11</span>  | 2268<span style="color: #aaa">/6348</span>   | 195<span style="color: #aaa">/754</span>   |
| Broward      |                            202 | <span style="color: #EC4E20">↑ 16</span>  | 1036<span style="color: #aaa">/4141</span>   | 143<span style="color: #aaa">/315</span>   |
| Hillsborough |                            146 | <span style="color: #6BAA75">↓ -1</span>  | 528<span style="color: #aaa">/3227</span>    | 27<span style="color: #aaa">/351</span>    |
| Duval        |                            128 | <span style="color: #6BAA75">↓ -2</span>  | 944<span style="color: #aaa">/2820</span>    | 102<span style="color: #aaa">/335</span>   |
| Orange       |                            120 | <span style="color: #EC4E20">↑ 8</span>   | 1103<span style="color: #aaa">/3354</span>   | 147<span style="color: #aaa">/257</span>   |
| Palm Beach   |                            110 | <span style="color: #6BAA75">↓ -1</span>  | 1304<span style="color: #aaa">/2739</span>   | 135<span style="color: #aaa">/266</span>   |
| Polk         |                             91 | <span style="color: #EC4E20">↑ 4</span>   | 324<span style="color: #aaa">/1335</span>    | 20<span style="color: #aaa">/124</span>    |
| Pinellas     |                             88 | <span style="color: #6BAA75">↓ -3</span>  | 939<span style="color: #aaa">/2348</span>    | 67<span style="color: #aaa">/226</span>    |
| Brevard      |                             76 | <span style="color: #EC4E20">↑ 5</span>   | 400<span style="color: #aaa">/1215</span>    | 25<span style="color: #aaa">/139</span>    |
| Osceola      |                             73 | <span style="color: #EC4E20">↑ 2</span>   | 260<span style="color: #aaa">/894</span>     | 30<span style="color: #aaa">/93</span>     |

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
