Florida COVID-19 Data
================
2020-07-18 12:04:23

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-18 | 337,569  | 0                  | 5,002  | 0                | 2,931,988 |
| Yesterday   | 2020-07-17 | 327,241  | 10,328             | 4,912  | 90               | 2,880,768 |
| Last Week   | 2020-07-11 | 254,511  | 83,058             | 4,301  | 701              | 2,475,299 |
| 2 Weeks Ago | 2020-07-04 | 190,052  | 147,517            | 3,803  | 1,199            | 2,146,497 |

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
| All          |                           9134 | <span style="color: #EC4E20">↑ 173</span> | 14556<span style="color: #aaa">/46258</span> | 1249<span style="color: #aaa">/5082</span> |
| Miami-Dade   |                           1969 | <span style="color: #EC4E20">↑ 65</span>  | 1901<span style="color: #aaa">/6937</span>   | 233<span style="color: #aaa">/835</span>   |
| Broward      |                           1221 | <span style="color: #EC4E20">↑ 22</span>  | 983<span style="color: #aaa">/4346</span>    | 76<span style="color: #aaa">/443</span>    |
| Orange       |                            593 | <span style="color: #6BAA75">↓ -32</span> | 1130<span style="color: #aaa">/3280</span>   | 92<span style="color: #aaa">/285</span>    |
| Palm Beach   |                            584 | <span style="color: #6BAA75">↓ -49</span> | 1221<span style="color: #aaa">/2932</span>   | 99<span style="color: #aaa">/327</span>    |
| Hillsborough |                            572 | <span style="color: #EC4E20">↑ 107</span> | 790<span style="color: #aaa">/3140</span>    | 52<span style="color: #aaa">/324</span>    |
| Duval        |                            484 | <span style="color: #6BAA75">↓ -5</span>  | 988<span style="color: #aaa">/2968</span>    | 91<span style="color: #aaa">/350</span>    |
| Pinellas     |                            435 | <span style="color: #EC4E20">↑ 7</span>   | 528<span style="color: #aaa">/2427</span>    | 49<span style="color: #aaa">/242</span>    |
| Polk         |                            297 | <span style="color: #6BAA75">↓ -2</span>  | 368<span style="color: #aaa">/1332</span>    | 18<span style="color: #aaa">/152</span>    |
| Lee          |                            253 | <span style="color: #6BAA75">↓ -5</span>  | 269<span style="color: #aaa">/1494</span>    | 11<span style="color: #aaa">/130</span>    |
| Escambia     |                            191 | <span style="color: #EC4E20">↑ 16</span>  | 326<span style="color: #aaa">/1035</span>    | 2<span style="color: #aaa">/116</span>     |

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
