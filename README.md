Florida COVID-19 Data
================
2020-07-30 19:05:16

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-30 | 461,379  | 0                  | 6,709  | 0                | 3,579,117 |
| Yesterday   | 2020-07-29 | 451,423  | 9,956              | 6,457  | 252              | 3,526,765 |
| Last Week   | 2020-07-23 | 389,868  | 71,511             | 5,632  | 1,077            | 3,210,942 |
| 2 Weeks Ago | 2020-07-16 | 315,775  | 145,604            | 4,782  | 1,927            | 2,815,618 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                     | Available Hospital Beds                      | Available ICU Beds                        |
| :----------- | -----------------------------: | :----------------------------------------- | :------------------------------------------- | :---------------------------------------- |
| All          |                           8395 | <span style="color: #6BAA75">↓ -325</span> | 13066<span style="color: #aaa">/46969</span> | 998<span style="color: #aaa">/5208</span> |
| Miami-Dade   |                           1827 | <span style="color: #6BAA75">↓ -119</span> | 1580<span style="color: #aaa">/6957</span>   | 111<span style="color: #aaa">/891</span>  |
| Broward      |                           1232 | <span style="color: #6BAA75">↓ -35</span>  | 905<span style="color: #aaa">/4560</span>    | 41<span style="color: #aaa">/481</span>   |
| Palm Beach   |                            532 | <span style="color: #6BAA75">↓ -29</span>  | 1204<span style="color: #aaa">/2957</span>   | 102<span style="color: #aaa">/321</span>  |
| Duval        |                            469 | <span style="color: #EC4E20">↑ 6</span>    | 906<span style="color: #aaa">/2877</span>    | 105<span style="color: #aaa">/336</span>  |
| Hillsborough |                            460 | <span style="color: #6BAA75">↓ -16</span>  | 569<span style="color: #aaa">/3207</span>    | 24<span style="color: #aaa">/364</span>   |
| Orange       |                            459 | <span style="color: #6BAA75">↓ -41</span>  | 952<span style="color: #aaa">/3489</span>    | 74<span style="color: #aaa">/298</span>   |
| Pinellas     |                            372 | <span style="color: #6BAA75">↓ -4</span>   | 590<span style="color: #aaa">/2317</span>    | 33<span style="color: #aaa">/264</span>   |
| Polk         |                            278 | <span style="color: #6BAA75">↓ -30</span>  | 303<span style="color: #aaa">/1338</span>    | 14<span style="color: #aaa">/150</span>   |
| Escambia     |                            202 | <span style="color: #EC4E20">↑ 17</span>   | 333<span style="color: #aaa">/1117</span>    | 9<span style="color: #aaa">/132</span>    |
| St. Lucie    |                            170 | <span style="color: #6BAA75">↓ -6</span>   | 109<span style="color: #aaa">/786</span>     | 11<span style="color: #aaa">/79</span>    |

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
