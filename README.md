Florida COVID-19 Data
================
2020-07-27 13:08:43

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-27 | 432,747  | 0                  | 6,049  | 0                | 3,431,497 |
| Yesterday   | 2020-07-26 | 423,855  | 8,892              | 5,972  | 77               | 3,386,503 |
| Last Week   | 2020-07-20 | 360,394  | 72,353             | 5,183  | 866              | 3,052,106 |
| 2 Weeks Ago | 2020-07-13 | 282,435  | 150,312            | 4,381  | 1,668            | 2,639,574 |

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
| All          |                           9098 | <span style="color: #EC4E20">↑ 147</span> | 14635<span style="color: #aaa">/45613</span> | 1153<span style="color: #aaa">/5049</span> |
| Miami-Dade   |                           1975 | <span style="color: #EC4E20">↑ 67</span>  | 1660<span style="color: #aaa">/6905</span>   | 125<span style="color: #aaa">/880</span>   |
| Broward      |                           1271 | <span style="color: #EC4E20">↑ 11</span>  | 1021<span style="color: #aaa">/4313</span>   | 49<span style="color: #aaa">/481</span>    |
| Palm Beach   |                            616 | <span style="color: #EC4E20">↑ 10</span>  | 1407<span style="color: #aaa">/2850</span>   | 126<span style="color: #aaa">/300</span>   |
| Orange       |                            528 | <span style="color: #6BAA75">↓ -12</span> | 1145<span style="color: #aaa">/3262</span>   | 106<span style="color: #aaa">/265</span>   |
| Hillsborough |                            518 | <span style="color: #EC4E20">↑ 15</span>  | 699<span style="color: #aaa">/3158</span>    | 50<span style="color: #aaa">/328</span>    |
| Duval        |                            490 | <span style="color: #EC4E20">↑ 3</span>   | 1083<span style="color: #aaa">/2930</span>   | 105<span style="color: #aaa">/336</span>   |
| Pinellas     |                            427 | <span style="color: #EC4E20">↑ 11</span>  | 516<span style="color: #aaa">/2390</span>    | 48<span style="color: #aaa">/255</span>    |
| Polk         |                            291 | <span style="color: #EC4E20">↑ 14</span>  | 337<span style="color: #aaa">/1290</span>    | 13<span style="color: #aaa">/152</span>    |
| Lee          |                            213 | <span style="color: #EC4E20">↑ 2</span>   | 311<span style="color: #aaa">/1449</span>    | 15<span style="color: #aaa">/126</span>    |
| Escambia     |                            205 | <span style="color: #6BAA75">↓ -2</span>  | 385<span style="color: #aaa">/1036</span>    | 6<span style="color: #aaa">/135</span>     |

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
