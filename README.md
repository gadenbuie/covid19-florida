Florida COVID-19 Data
================
2020-07-16 12:04:32

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-16 | 315,775  | 0                  | 4,782  | 0                | 2,815,618 |
| Yesterday   | 2020-07-15 | 301,810  | 13,965             | 4,626  | 156              | 2,735,953 |
| Last Week   | 2020-07-09 | 232,718  | 83,057             | 4,111  | 671              | 2,357,398 |
| 2 Weeks Ago | 2020-07-02 | 169,106  | 146,669            | 3,718  | 1,064            | 2,032,183 |

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
| All          |                           9091 | <span style="color: #EC4E20">↑ 874</span> | 12926<span style="color: #aaa">/47726</span> | 1009<span style="color: #aaa">/5182</span> |
| Miami-Dade   |                           1879 | <span style="color: #EC4E20">↑ 30</span>  | 1549<span style="color: #aaa">/6905</span>   | 145<span style="color: #aaa">/857</span>   |
| Broward      |                           1203 | <span style="color: #EC4E20">↑ 33</span>  | 989<span style="color: #aaa">/4453</span>    | 58<span style="color: #aaa">/443</span>    |
| Palm Beach   |                            670 | <span style="color: #EC4E20">↑ 21</span>  | 1070<span style="color: #aaa">/3106</span>   | 106<span style="color: #aaa">/308</span>   |
| Orange       |                            625 | <span style="color: #EC4E20">↑ 43</span>  | 936<span style="color: #aaa">/3510</span>    | 75<span style="color: #aaa">/296</span>    |
| Hillsborough |                            542 | <span style="color: #EC4E20">↑ 287</span> | 726<span style="color: #aaa">/3297</span>    | 38<span style="color: #aaa">/337</span>    |
| Duval        |                            522 | <span style="color: #EC4E20">↑ 3</span>   | 918<span style="color: #aaa">/3036</span>    | 90<span style="color: #aaa">/349</span>    |
| Pinellas     |                            435 | <span style="color: #EC4E20">↑ 197</span> | 529<span style="color: #aaa">/2359</span>    | 42<span style="color: #aaa">/257</span>    |
| Polk         |                            297 | <span style="color: #EC4E20">↑ 144</span> | 258<span style="color: #aaa">/1365</span>    | 12<span style="color: #aaa">/150</span>    |
| Lee          |                            248 | <span style="color: #EC4E20">↑ 5</span>   | 256<span style="color: #aaa">/1583</span>    | 13<span style="color: #aaa">/127</span>    |
| Collier      |                            196 | <span style="color: #6BAA75">↓ -4</span>  | 134<span style="color: #aaa">/775</span>     | 19<span style="color: #aaa">/62</span>     |

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
