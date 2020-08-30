Florida COVID-19 Data
================
2020-08-30 19:11:39

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-30 | 621,586  | 0                  | 11,263 | 0                | 4,599,608 |
| Yesterday   | 2020-08-29 | 619,003  | 2,583              | 11,249 | 14               | 4,575,211 |
| Last Week   | 2020-08-23 | 600,571  | 21,015             | 10,462 | 801              | 4,428,633 |
| 2 Weeks Ago | 2020-08-16 | 573,416  | 48,170             | 9,587  | 1,676            | 4,232,628 |

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
| All          |                           3791 | <span style="color: #6BAA75">↓ -8</span>  | 16431<span style="color: #aaa">/43592</span> | 1407<span style="color: #aaa">/4587</span> |
| Miami-Dade   |                            694 | <span style="color: #6BAA75">↓ -4</span>  | 2521<span style="color: #aaa">/5994</span>   | 174<span style="color: #aaa">/779</span>   |
| Broward      |                            467 | <span style="color: #6BAA75">↓ -12</span> | 1155<span style="color: #aaa">/3969</span>   | 107<span style="color: #aaa">/372</span>   |
| Duval        |                            219 | <span style="color: #6BAA75">↓ -4</span>  | 1045<span style="color: #aaa">/2712</span>   | 131<span style="color: #aaa">/310</span>   |
| Hillsborough |                            199 | <span style="color: #EC4E20">↑ 4</span>   | 764<span style="color: #aaa">/2935</span>    | 87<span style="color: #aaa">/292</span>    |
| Orange       |                            182 | <span style="color: #EC4E20">↑ 8</span>   | 1069<span style="color: #aaa">/3227</span>   | 104<span style="color: #aaa">/268</span>   |
| Gadsden      |                            175 |                                           | 198<span style="color: #aaa">/755</span>     | 0<span style="color: #aaa">/0</span>       |
| Palm Beach   |                            164 | <span style="color: #EC4E20">↑ 4</span>   | 1345<span style="color: #aaa">/2663</span>   | 131<span style="color: #aaa">/264</span>   |
| Pinellas     |                            137 | <span style="color: #EC4E20">↑ 5</span>   | 921<span style="color: #aaa">/2129</span>    | 70<span style="color: #aaa">/220</span>    |
| Polk         |                            119 | <span style="color: #EC4E20">↑ 5</span>   | 384<span style="color: #aaa">/1198</span>    | 16<span style="color: #aaa">/115</span>    |
| Lee          |                            113 | <span style="color: #6BAA75">↓ -4</span>  | 538<span style="color: #aaa">/1302</span>    | 32<span style="color: #aaa">/118</span>    |

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
