Florida COVID-19 Data
================
2020-10-24 19:07:46

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-24 | 776,251  | 0                  | 16,620 | 0                | 5,938,061 |
| Yesterday   | 2020-10-23 | 771,780  | 4,471              | 16,544 | 76               | 5,865,752 |
| Last Week   | 2020-10-17 | 752,481  | 23,770             | 16,118 | 502              | 5,704,100 |
| 2 Weeks Ago | 2020-10-10 | 728,921  | 47,330             | 15,372 | 1,248            | 5,518,162 |

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
| All          |                           2160 | <span style="color: #EC4E20">↑ 114</span> | 15875<span style="color: #aaa">/45098</span> | 1519<span style="color: #aaa">/4564</span> |
| Miami-Dade   |                            284 | <span style="color: #EC4E20">↑ 15</span>  | 2595<span style="color: #aaa">/6062</span>   | 224<span style="color: #aaa">/721</span>   |
| Broward      |                            202 | <span style="color: #EC4E20">↑ 17</span>  | 979<span style="color: #aaa">/4176</span>    | 102<span style="color: #aaa">/349</span>   |
| Hillsborough |                            145 | <span style="color: #EC4E20">↑ 11</span>  | 837<span style="color: #aaa">/3138</span>    | 70<span style="color: #aaa">/317</span>    |
| Orange       |                            137 | <span style="color: #EC4E20">↑ 22</span>  | 1128<span style="color: #aaa">/3378</span>   | 127<span style="color: #aaa">/277</span>   |
| Palm Beach   |                            128 | <span style="color: #EC4E20">↑ 11</span>  | 1361<span style="color: #aaa">/2687</span>   | 144<span style="color: #aaa">/249</span>   |
| Pinellas     |                            122 | <span style="color: #EC4E20">↑ 7</span>   | 968<span style="color: #aaa">/2174</span>    | 64<span style="color: #aaa">/248</span>    |
| Duval        |                            112 | <span style="color: #EC4E20">↑ 9</span>   | 999<span style="color: #aaa">/2724</span>    | 110<span style="color: #aaa">/327</span>   |
| Polk         |                             82 | <span style="color: #6BAA75">↓ -1</span>  | 429<span style="color: #aaa">/1255</span>    | 46<span style="color: #aaa">/134</span>    |
| Osceola      |                             71 | <span style="color: #6BAA75">↓ -13</span> | 305<span style="color: #aaa">/849</span>     | 46<span style="color: #aaa">/77</span>     |
| Brevard      |                             62 | <span style="color: #EC4E20">↑ 2</span>   | 431<span style="color: #aaa">/1200</span>    | 39<span style="color: #aaa">/129</span>    |

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
