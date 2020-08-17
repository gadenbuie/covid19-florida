Florida COVID-19 Data
================
2020-08-17 12:06:21

## Today

| When           | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :------------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Yesterday      | 2020-08-16 | 573,416  | 0                  | 9,587  | 0                | 4,232,628 |
| The Day Before | 2020-08-15 | 569,637  | 3,779              | 9,480  | 107              | 4,202,725 |
| Last Week      | 2020-08-10 | 536,961  | 36,455             | 8,408  | 1,179            | 4,013,857 |
| 2 Weeks Ago    | 2020-08-03 | 491,884  | 81,532             | 7,279  | 2,308            | 3,752,798 |

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
| All          |                           5687 | <span style="color: #6BAA75">↓ -1</span> | 15989<span style="color: #aaa">/44286</span> | 1369<span style="color: #aaa">/4776</span> |
| Miami-Dade   |                           1146 | <span style="color: #EC4E20">↑ 3</span>  | 2202<span style="color: #aaa">/6325</span>   | 185<span style="color: #aaa">/820</span>   |
| Broward      |                            729 | <span style="color: #EC4E20">↑ 1</span>  | 1124<span style="color: #aaa">/4071</span>   | 85<span style="color: #aaa">/424</span>    |
| Palm Beach   |                            367 | <span style="color: #6BAA75">↓ -1</span> | 1442<span style="color: #aaa">/2661</span>   | 114<span style="color: #aaa">/290</span>   |
| Duval        |                            310 |                                          | 976<span style="color: #aaa">/2646</span>    | 121<span style="color: #aaa">/320</span>   |
| Hillsborough |                            292 |                                          | 816<span style="color: #aaa">/2959</span>    | 62<span style="color: #aaa">/326</span>    |
| Orange       |                            263 |                                          | 1123<span style="color: #aaa">/3254</span>   | 103<span style="color: #aaa">/269</span>   |
| Pinellas     |                            219 |                                          | 596<span style="color: #aaa">/2221</span>    | 60<span style="color: #aaa">/240</span>    |
| Polk         |                            168 |                                          | 385<span style="color: #aaa">/1226</span>    | 15<span style="color: #aaa">/130</span>    |
| Lee          |                            152 |                                          | 380<span style="color: #aaa">/1409</span>    | 34<span style="color: #aaa">/107</span>    |
| Escambia     |                            137 |                                          | 458<span style="color: #aaa">/1037</span>    | 16<span style="color: #aaa">/131</span>    |

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
