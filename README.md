Florida COVID-19 Data
================
2020-07-15 19:04:50

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-15 | 301,810  | 0                  | 4,626  | 0                | 2,735,953 |
| Yesterday   | 2020-07-14 | 291,629  | 10,181             | 4,514  | 112              | 2,685,243 |
| Last Week   | 2020-07-08 | 223,783  | 78,027             | 3,991  | 635              | 2,320,207 |
| 2 Weeks Ago | 2020-07-01 | 158,997  | 142,813            | 3,650  | 976              | 1,980,354 |

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
| All          |                           8217 | <span style="color: #6BAA75">↓ -136</span> | 12567<span style="color: #aaa">/47985</span> | 971<span style="color: #aaa">/5166</span> |
| Miami-Dade   |                           1849 | <span style="color: #6BAA75">↓ -9</span>   | 1621<span style="color: #aaa">/6838</span>   | 154<span style="color: #aaa">/839</span>  |
| Broward      |                           1170 | <span style="color: #6BAA75">↓ -58</span>  | 932<span style="color: #aaa">/4471</span>    | 35<span style="color: #aaa">/483</span>   |
| Palm Beach   |                            649 | <span style="color: #6BAA75">↓ -3</span>   | 1118<span style="color: #aaa">/3082</span>   | 115<span style="color: #aaa">/304</span>  |
| Orange       |                            582 | <span style="color: #EC4E20">↑ 14</span>   | 938<span style="color: #aaa">/3411</span>    | 78<span style="color: #aaa">/296</span>   |
| Duval        |                            519 | <span style="color: #6BAA75">↓ -16</span>  | 832<span style="color: #aaa">/3131</span>    | 87<span style="color: #aaa">/352</span>   |
| Hillsborough |                            255 | <span style="color: #6BAA75">↓ -38</span>  | 644<span style="color: #aaa">/3334</span>    | 35<span style="color: #aaa">/338</span>   |
| Lee          |                            243 | <span style="color: #6BAA75">↓ -31</span>  | 261<span style="color: #aaa">/1494</span>    | 16<span style="color: #aaa">/124</span>   |
| Pinellas     |                            238 | <span style="color: #EC4E20">↑ 1</span>    | 575<span style="color: #aaa">/2419</span>    | 47<span style="color: #aaa">/247</span>   |
| Collier      |                            200 | <span style="color: #EC4E20">↑ 7</span>    | 156<span style="color: #aaa">/752</span>     | 22<span style="color: #aaa">/58</span>    |
| Osceola      |                            181 | <span style="color: #6BAA75">↓ -12</span>  | 312<span style="color: #aaa">/854</span>     | 37<span style="color: #aaa">/91</span>    |

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
