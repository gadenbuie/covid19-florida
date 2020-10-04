Florida COVID-19 Data
================
2020-10-04 19:07:49

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-04 | 716,459  | 0                  | 14,845 | 0                | 5,396,874 |
| Yesterday   | 2020-10-03 | 714,591  | 1,868              | 14,803 | 42               | 5,376,459 |
| Last Week   | 2020-09-27 | 700,564  | 15,895             | 14,202 | 643              | 5,253,441 |
| 2 Weeks Ago | 2020-09-20 | 683,754  | 32,705             | 13,459 | 1,386            | 5,095,089 |

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
| All          |                           2027 | <span style="color: #6BAA75">↓ -10</span> | 17704<span style="color: #aaa">/43393</span> | 1583<span style="color: #aaa">/4476</span> |
| Miami-Dade   |                            267 | <span style="color: #EC4E20">↑ 5</span>   | 2673<span style="color: #aaa">/5869</span>   | 232<span style="color: #aaa">/713</span>   |
| Broward      |                            204 | <span style="color: #6BAA75">↓ -3</span>  | 1192<span style="color: #aaa">/3864</span>   | 108<span style="color: #aaa">/343</span>   |
| Hillsborough |                            153 | <span style="color: #EC4E20">↑ 3</span>   | 762<span style="color: #aaa">/3155</span>    | 67<span style="color: #aaa">/312</span>    |
| Duval        |                            119 | <span style="color: #6BAA75">↓ -6</span>  | 1084<span style="color: #aaa">/2615</span>   | 123<span style="color: #aaa">/314</span>   |
| Orange       |                            115 | <span style="color: #6BAA75">↓ -1</span>  | 1262<span style="color: #aaa">/3102</span>   | 157<span style="color: #aaa">/247</span>   |
| Palm Beach   |                            105 | <span style="color: #EC4E20">↑ 6</span>   | 1450<span style="color: #aaa">/2545</span>   | 155<span style="color: #aaa">/253</span>   |
| Pinellas     |                             97 | <span style="color: #6BAA75">↓ -2</span>  | 1243<span style="color: #aaa">/2334</span>   | 71<span style="color: #aaa">/230</span>    |
| Polk         |                             80 |                                           | 412<span style="color: #aaa">/1243</span>    | 44<span style="color: #aaa">/134</span>    |
| Osceola      |                             71 | <span style="color: #EC4E20">↑ 3</span>   | 284<span style="color: #aaa">/852</span>     | 36<span style="color: #aaa">/87</span>     |
| Brevard      |                             65 | <span style="color: #EC4E20">↑ 1</span>   | 504<span style="color: #aaa">/1087</span>    | 38<span style="color: #aaa">/128</span>    |

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
