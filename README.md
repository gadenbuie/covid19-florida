Florida COVID-19 Data
================
2020-09-27 12:14:32

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-09-27 | 700,564  | 0                  | 14,202 | 0                | 5,253,441 |
| Yesterday   | 2020-09-26 | 698,682  | 1,882              | 14,190 | 12               | 5,235,007 |
| Last Week   | 2020-09-20 | 683,754  | 16,810             | 13,459 | 743              | 5,095,089 |
| 2 Weeks Ago | 2020-09-13 | 663,994  | 36,570             | 12,764 | 1,438            | 4,923,930 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                  | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :-------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           2101 | <span style="color: #EC4E20">↑ 2</span> | 16690<span style="color: #aaa">/44744</span> | 1412<span style="color: #aaa">/4579</span> |
| Miami-Dade   |                            270 | <span style="color: #EC4E20">↑ 2</span> | 3487<span style="color: #aaa">/6047</span>   | 185<span style="color: #aaa">/748</span>   |
| Broward      |                            215 |                                         | 1141<span style="color: #aaa">/3994</span>   | 98<span style="color: #aaa">/368</span>    |
| Hillsborough |                            141 |                                         | 568<span style="color: #aaa">/3162</span>    | 46<span style="color: #aaa">/334</span>    |
| Orange       |                            122 |                                         | 1091<span style="color: #aaa">/3275</span>   | 135<span style="color: #aaa">/269</span>   |
| Duval        |                            120 |                                         | 886<span style="color: #aaa">/2909</span>    | 128<span style="color: #aaa">/306</span>   |
| Palm Beach   |                            111 |                                         | 1400<span style="color: #aaa">/2620</span>   | 147<span style="color: #aaa">/253</span>   |
| Pinellas     |                             98 |                                         | 931<span style="color: #aaa">/2193</span>    | 64<span style="color: #aaa">/218</span>    |
| Polk         |                             84 |                                         | 400<span style="color: #aaa">/1228</span>    | 29<span style="color: #aaa">/115</span>    |
| Alachua      |                             70 |                                         | 272<span style="color: #aaa">/1431</span>    | 34<span style="color: #aaa">/274</span>    |
| Osceola      |                             67 |                                         | 281<span style="color: #aaa">/869</span>     | 35<span style="color: #aaa">/88</span>     |

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
