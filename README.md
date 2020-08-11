Florida COVID-19 Data
================
2020-08-10 20:24:22

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-10 | 536,961  | 0                  | 8,408  | 0                | 4,013,857 |
| Yesterday   | 2020-08-09 | 532,806  | 4,155              | 8,315  | 93               | 3,985,663 |
| Last Week   | 2020-08-03 | 491,884  | 45,077             | 7,279  | 1,129            | 3,752,798 |
| 2 Weeks Ago | 2020-07-27 | 432,747  | 104,214            | 6,049  | 2,359            | 3,431,497 |

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
| All          |                           6948 | <span style="color: #EC4E20">↑ 100</span> | 15362<span style="color: #aaa">/44217</span> | 1286<span style="color: #aaa">/4876</span> |
| Miami-Dade   |                           1480 | <span style="color: #6BAA75">↓ -23</span> | 1896<span style="color: #aaa">/6575</span>   | 142<span style="color: #aaa">/853</span>   |
| Broward      |                            933 | <span style="color: #EC4E20">↑ 24</span>  | 1081<span style="color: #aaa">/4175</span>   | 69<span style="color: #aaa">/444</span>    |
| Palm Beach   |                            441 | <span style="color: #EC4E20">↑ 13</span>  | 1406<span style="color: #aaa">/2744</span>   | 119<span style="color: #aaa">/296</span>   |
| Duval        |                            406 | <span style="color: #EC4E20">↑ 21</span>  | 1053<span style="color: #aaa">/2693</span>   | 111<span style="color: #aaa">/330</span>   |
| Orange       |                            340 | <span style="color: #EC4E20">↑ 4</span>   | 1061<span style="color: #aaa">/3280</span>   | 97<span style="color: #aaa">/275</span>    |
| Hillsborough |                            336 | <span style="color: #6BAA75">↓ -16</span> | 743<span style="color: #aaa">/3048</span>    | 64<span style="color: #aaa">/313</span>    |
| Pinellas     |                            251 | <span style="color: #6BAA75">↓ -8</span>  | 713<span style="color: #aaa">/2188</span>    | 65<span style="color: #aaa">/232</span>    |
| Polk         |                            228 | <span style="color: #6BAA75">↓ -5</span>  | 358<span style="color: #aaa">/1262</span>    | 13<span style="color: #aaa">/147</span>    |
| Lee          |                            212 | <span style="color: #EC4E20">↑ 25</span>  | 376<span style="color: #aaa">/1416</span>    | 86<span style="color: #aaa">/75</span>     |
| Escambia     |                            175 | <span style="color: #EC4E20">↑ 8</span>   | 468<span style="color: #aaa">/1027</span>    | 11<span style="color: #aaa">/136</span>    |

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
