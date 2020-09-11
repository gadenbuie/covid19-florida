Florida COVID-19 Data
================
2020-09-11 07:12:49

## Today

| When           | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :------------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Yesterday      | 2020-09-10 | 654,731  | 0                  | 12,482 | 0                | 4,850,259 |
| The Day Before | 2020-09-09 | 652,148  | 2,583              | 12,269 | 213              | 4,831,248 |
| Last Week      | 2020-09-04 | 640,211  | 14,520             | 11,903 | 579              | 4,740,007 |
| 2 Weeks Ago    | 2020-08-28 | 615,806  | 38,925             | 11,099 | 1,383            | 4,547,677 |

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
| All          |                           2896 | <span style="color: #6BAA75">↓ -1</span> | 15132<span style="color: #aaa">/47229</span> | 1241<span style="color: #aaa">/4748</span> |
| Miami-Dade   |                            464 | <span style="color: #6BAA75">↓ -5</span> | 2693<span style="color: #aaa">/6272</span>   | 142<span style="color: #aaa">/787</span>   |
| Broward      |                            324 |                                          | 1067<span style="color: #aaa">/5381</span>   | 80<span style="color: #aaa">/398</span>    |
| Hillsborough |                            167 |                                          | 606<span style="color: #aaa">/3152</span>    | 68<span style="color: #aaa">/300</span>    |
| Duval        |                            156 |                                          | 802<span style="color: #aaa">/2766</span>    | 100<span style="color: #aaa">/321</span>   |
| Palm Beach   |                            156 | <span style="color: #EC4E20">↑ 3</span>  | 1318<span style="color: #aaa">/2745</span>   | 118<span style="color: #aaa">/282</span>   |
| Orange       |                            133 |                                          | 1050<span style="color: #aaa">/3333</span>   | 105<span style="color: #aaa">/267</span>   |
| Pinellas     |                            127 |                                          | 838<span style="color: #aaa">/2322</span>    | 54<span style="color: #aaa">/263</span>    |
| Polk         |                            116 |                                          | 394<span style="color: #aaa">/1245</span>    | 23<span style="color: #aaa">/120</span>    |
| Alachua      |                             92 |                                          | 249<span style="color: #aaa">/1484</span>    | 33<span style="color: #aaa">/275</span>    |
| Gadsden      |                             87 |                                          | 208<span style="color: #aaa">/745</span>     | 0<span style="color: #aaa">/0</span>       |

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
