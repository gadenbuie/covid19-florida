Florida COVID-19 Data
================
2020-07-24 19:05:15

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-24 | 402,312  | 0                  | 5,768  | 0                | 3,276,636 |
| Yesterday   | 2020-07-23 | 389,868  | 12,444             | 5,632  | 136              | 3,210,942 |
| Last Week   | 2020-07-17 | 327,241  | 75,071             | 4,912  | 856              | 2,880,768 |
| 2 Weeks Ago | 2020-07-10 | 244,151  | 158,161            | 4,203  | 1,565            | 2,421,627 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                     | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :----------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           9200 | <span style="color: #6BAA75">↓ -222</span> | 13371<span style="color: #aaa">/47101</span> | 1020<span style="color: #aaa">/5128</span> |
| Miami-Dade   |                           1980 | <span style="color: #6BAA75">↓ -18</span>  | 1553<span style="color: #aaa">/6955</span>   | 113<span style="color: #aaa">/855</span>   |
| Broward      |                           1283 | <span style="color: #6BAA75">↓ -21</span>  | 908<span style="color: #aaa">/4494</span>    | 49<span style="color: #aaa">/492</span>    |
| Orange       |                            596 | <span style="color: #6BAA75">↓ -6</span>   | 1044<span style="color: #aaa">/3400</span>   | 85<span style="color: #aaa">/287</span>    |
| Palm Beach   |                            573 | <span style="color: #6BAA75">↓ -32</span>  | 1155<span style="color: #aaa">/3044</span>   | 106<span style="color: #aaa">/315</span>   |
| Hillsborough |                            569 | <span style="color: #6BAA75">↓ -38</span>  | 550<span style="color: #aaa">/3256</span>    | 29<span style="color: #aaa">/344</span>    |
| Duval        |                            494 | <span style="color: #6BAA75">↓ -16</span>  | 938<span style="color: #aaa">/3081</span>    | 102<span style="color: #aaa">/339</span>   |
| Pinellas     |                            416 | <span style="color: #6BAA75">↓ -12</span>  | 593<span style="color: #aaa">/2355</span>    | 36<span style="color: #aaa">/253</span>    |
| Polk         |                            276 | <span style="color: #6BAA75">↓ -2</span>   | 335<span style="color: #aaa">/1341</span>    | 14<span style="color: #aaa">/147</span>    |
| Lee          |                            233 | <span style="color: #6BAA75">↓ -8</span>   | 241<span style="color: #aaa">/1559</span>    | 14<span style="color: #aaa">/127</span>    |
| Osceola      |                            211 | <span style="color: #6BAA75">↓ -6</span>   | 297<span style="color: #aaa">/840</span>     | 34<span style="color: #aaa">/72</span>     |

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
