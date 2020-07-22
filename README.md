Florida COVID-19 Data
================
2020-07-22 12:06:09

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-22 | 379,619  | 0                  | 5,459  | 0                | 3,154,711 |
| Yesterday   | 2020-07-21 | 369,834  | 9,785              | 5,319  | 140              | 3,099,750 |
| Last Week   | 2020-07-15 | 301,810  | 77,809             | 4,626  | 833              | 2,735,953 |
| 2 Weeks Ago | 2020-07-08 | 223,783  | 155,836            | 3,991  | 1,468            | 2,320,207 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                    | Available Hospital Beds                      | Available ICU Beds                        |
| :----------- | -----------------------------: | :---------------------------------------- | :------------------------------------------- | :---------------------------------------- |
| All          |                           9497 | <span style="color: #6BAA75">↓ -23</span> | 12927<span style="color: #aaa">/47720</span> | 956<span style="color: #aaa">/5286</span> |
| Miami-Dade   |                           2006 | <span style="color: #6BAA75">↓ -52</span> | 1540<span style="color: #aaa">/6949</span>   | 126<span style="color: #aaa">/833</span>  |
| Broward      |                           1313 | <span style="color: #EC4E20">↑ 23</span>  | 874<span style="color: #aaa">/4552</span>    | 44<span style="color: #aaa">/480</span>   |
| Palm Beach   |                            605 | <span style="color: #6BAA75">↓ -18</span> | 1136<span style="color: #aaa">/3052</span>   | 100<span style="color: #aaa">/311</span>  |
| Hillsborough |                            595 | <span style="color: #6BAA75">↓ -9</span>  | 614<span style="color: #aaa">/3366</span>    | 36<span style="color: #aaa">/349</span>   |
| Orange       |                            584 | <span style="color: #6BAA75">↓ -12</span> | 982<span style="color: #aaa">/3451</span>    | 56<span style="color: #aaa">/319</span>   |
| Duval        |                            512 | <span style="color: #6BAA75">↓ -16</span> | 939<span style="color: #aaa">/3133</span>    | 120<span style="color: #aaa">/439</span>  |
| Pinellas     |                            452 | <span style="color: #6BAA75">↓ -2</span>  | 544<span style="color: #aaa">/2421</span>    | 41<span style="color: #aaa">/250</span>   |
| Polk         |                            298 | <span style="color: #EC4E20">↑ 21</span>  | 257<span style="color: #aaa">/1363</span>    | 8<span style="color: #aaa">/150</span>    |
| Lee          |                            261 | <span style="color: #6BAA75">↓ -9</span>  | 235<span style="color: #aaa">/1524</span>    | 12<span style="color: #aaa">/129</span>   |
| Osceola      |                            239 | <span style="color: #EC4E20">↑ 48</span>  | 256<span style="color: #aaa">/906</span>     | 46<span style="color: #aaa">/85</span>    |

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
