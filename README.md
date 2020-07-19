Florida COVID-19 Data
================
2020-07-19 12:06:07

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-19 | 350,047  | 0                  | 5,091  | 0                | 3,002,641 |
| Yesterday   | 2020-07-18 | 337,569  | 12,478             | 5,002  | 89               | 2,931,988 |
| Last Week   | 2020-07-12 | 269,811  | 80,236             | 4,346  | 745              | 2,574,007 |
| 2 Weeks Ago | 2020-07-05 | 200,111  | 149,936            | 3,832  | 1,259            | 2,200,199 |

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
| All          |                           9331 | <span style="color: #EC4E20">↑ 193</span> | 14729<span style="color: #aaa">/45914</span> | 1194<span style="color: #aaa">/5055</span> |
| Miami-Dade   |                           2010 | <span style="color: #EC4E20">↑ 45</span>  | 1909<span style="color: #aaa">/6926</span>   | 257<span style="color: #aaa">/842</span>   |
| Broward      |                           1240 | <span style="color: #EC4E20">↑ 22</span>  | 1005<span style="color: #aaa">/4321</span>   | 58<span style="color: #aaa">/460</span>    |
| Orange       |                            612 | <span style="color: #EC4E20">↑ 19</span>  | 1127<span style="color: #aaa">/3280</span>   | 81<span style="color: #aaa">/294</span>    |
| Palm Beach   |                            606 | <span style="color: #EC4E20">↑ 22</span>  | 1226<span style="color: #aaa">/2927</span>   | 102<span style="color: #aaa">/319</span>   |
| Hillsborough |                            562 | <span style="color: #6BAA75">↓ -10</span> | 805<span style="color: #aaa">/3164</span>    | 46<span style="color: #aaa">/325</span>    |
| Duval        |                            521 | <span style="color: #EC4E20">↑ 37</span>  | 1047<span style="color: #aaa">/2921</span>   | 101<span style="color: #aaa">/340</span>   |
| Pinellas     |                            466 | <span style="color: #EC4E20">↑ 31</span>  | 516<span style="color: #aaa">/2328</span>    | 40<span style="color: #aaa">/258</span>    |
| Polk         |                            271 | <span style="color: #6BAA75">↓ -26</span> | 436<span style="color: #aaa">/1288</span>    | 28<span style="color: #aaa">/137</span>    |
| Lee          |                            252 | <span style="color: #6BAA75">↓ -1</span>  | 260<span style="color: #aaa">/1496</span>    | 9<span style="color: #aaa">/132</span>     |
| Osceola      |                            199 | <span style="color: #EC4E20">↑ 18</span>  | 351<span style="color: #aaa">/816</span>     | 40<span style="color: #aaa">/89</span>     |

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
