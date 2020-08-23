Florida COVID-19 Data
================
2020-08-23 07:12:01

## Today

| When           | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :------------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Yesterday      | 2020-08-22 | 597,597  | 0                  | 10,411 | 0                | 4,401,847 |
| The Day Before | 2020-08-21 | 593,286  | 4,311              | 10,304 | 107              | 4,367,212 |
| Last Week      | 2020-08-16 | 573,416  | 24,181             | 9,587  | 824              | 4,232,628 |
| 2 Weeks Ago    | 2020-08-09 | 532,806  | 64,791             | 8,315  | 2,096            | 3,985,663 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                   | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :--------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           4749 | <span style="color: #6BAA75">↓ -3</span> | 15428<span style="color: #aaa">/44927</span> | 1259<span style="color: #aaa">/4848</span> |
| Miami-Dade   |                            895 | <span style="color: #6BAA75">↓ -8</span> | 2157<span style="color: #aaa">/6425</span>   | 157<span style="color: #aaa">/818</span>   |
| Broward      |                            637 |                                          | 1014<span style="color: #aaa">/4011</span>   | 84<span style="color: #aaa">/423</span>    |
| Duval        |                            270 |                                          | 1011<span style="color: #aaa">/2722</span>   | 105<span style="color: #aaa">/336</span>   |
| Palm Beach   |                            269 |                                          | 1384<span style="color: #aaa">/2640</span>   | 106<span style="color: #aaa">/305</span>   |
| Orange       |                            248 |                                          | 978<span style="color: #aaa">/3329</span>    | 87<span style="color: #aaa">/285</span>    |
| Hillsborough |                            241 |                                          | 680<span style="color: #aaa">/3055</span>    | 58<span style="color: #aaa">/306</span>    |
| Polk         |                            163 |                                          | 364<span style="color: #aaa">/1283</span>    | 36<span style="color: #aaa">/134</span>    |
| Pinellas     |                            159 |                                          | 809<span style="color: #aaa">/2203</span>    | 63<span style="color: #aaa">/239</span>    |
| Lee          |                            148 |                                          | 472<span style="color: #aaa">/1393</span>    | 29<span style="color: #aaa">/112</span>    |
| Alachua      |                            116 |                                          | 255<span style="color: #aaa">/1437</span>    | 16<span style="color: #aaa">/292</span>    |

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
