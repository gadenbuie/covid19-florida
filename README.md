Florida COVID-19 Data
================
2020-07-17 07:04:54

## Today

| When           | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :------------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Yesterday      | 2020-07-16 | 315,775  | 0                  | 4,782  | 0                | 2,815,618 |
| The Day Before | 2020-07-15 | 301,810  | 13,965             | 4,626  | 156              | 2,735,953 |
| Last Week      | 2020-07-10 | 244,151  | 71,624             | 4,203  | 579              | 2,421,627 |
| 2 Weeks Ago    | 2020-07-03 | 178,594  | 137,181            | 3,785  | 997              | 2,081,360 |

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
| All          |                           9109 | <span style="color: #EC4E20">↑ 14</span> | 12948<span style="color: #aaa">/47696</span> | 1021<span style="color: #aaa">/5173</span> |
| Miami-Dade   |                           1917 | <span style="color: #EC4E20">↑ 14</span> | 1537<span style="color: #aaa">/6909</span>   | 146<span style="color: #aaa">/856</span>   |
| Broward      |                           1201 |                                          | 989<span style="color: #aaa">/4453</span>    | 58<span style="color: #aaa">/443</span>    |
| Palm Beach   |                            670 |                                          | 1070<span style="color: #aaa">/3106</span>   | 106<span style="color: #aaa">/308</span>   |
| Orange       |                            606 |                                          | 947<span style="color: #aaa">/3501</span>    | 77<span style="color: #aaa">/296</span>    |
| Hillsborough |                            542 |                                          | 726<span style="color: #aaa">/3297</span>    | 38<span style="color: #aaa">/337</span>    |
| Duval        |                            521 |                                          | 918<span style="color: #aaa">/3036</span>    | 95<span style="color: #aaa">/344</span>    |
| Pinellas     |                            434 |                                          | 529<span style="color: #aaa">/2359</span>    | 43<span style="color: #aaa">/256</span>    |
| Polk         |                            297 |                                          | 258<span style="color: #aaa">/1365</span>    | 12<span style="color: #aaa">/150</span>    |
| Lee          |                            248 |                                          | 256<span style="color: #aaa">/1583</span>    | 13<span style="color: #aaa">/127</span>    |
| Collier      |                            196 |                                          | 134<span style="color: #aaa">/775</span>     | 19<span style="color: #aaa">/62</span>     |

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
