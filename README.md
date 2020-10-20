Florida COVID-19 Data
================
2020-10-20 19:09:31

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-20 | 760,389  | 0                  | 16,308 | 0                | 5,767,947 |
| Yesterday   | 2020-10-19 | 756,727  | 3,662              | 16,222 | 86               | 5,739,283 |
| Last Week   | 2020-10-13 | 738,749  | 21,640             | 15,722 | 586              | 5,593,424 |
| 2 Weeks Ago | 2020-10-06 | 720,125  | 40,264             | 14,945 | 1,363            | 5,433,578 |

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
| All          |                           2089 | <span style="color: #EC4E20">↑ 32</span> | 14941<span style="color: #aaa">/46028</span> | 1430<span style="color: #aaa">/4603</span> |
| Miami-Dade   |                            259 | <span style="color: #6BAA75">↓ -6</span> | 2400<span style="color: #aaa">/6258</span>   | 201<span style="color: #aaa">/751</span>   |
| Broward      |                            193 | <span style="color: #EC4E20">↑ 5</span>  | 1070<span style="color: #aaa">/4150</span>   | 106<span style="color: #aaa">/335</span>   |
| Hillsborough |                            149 | <span style="color: #EC4E20">↑ 9</span>  | 582<span style="color: #aaa">/3250</span>    | 55<span style="color: #aaa">/319</span>    |
| Duval        |                            132 | <span style="color: #EC4E20">↑ 14</span> | 841<span style="color: #aaa">/2781</span>    | 93<span style="color: #aaa">/333</span>    |
| Orange       |                            120 | <span style="color: #6BAA75">↓ -2</span> | 1111<span style="color: #aaa">/3311</span>   | 141<span style="color: #aaa">/263</span>   |
| Pinellas     |                            118 | <span style="color: #EC4E20">↑ 5</span>  | 818<span style="color: #aaa">/2336</span>    | 48<span style="color: #aaa">/248</span>    |
| Palm Beach   |                            106 | <span style="color: #EC4E20">↑ 7</span>  | 1350<span style="color: #aaa">/2677</span>   | 154<span style="color: #aaa">/239</span>   |
| Osceola      |                             78 | <span style="color: #6BAA75">↓ -1</span> | 291<span style="color: #aaa">/883</span>     | 43<span style="color: #aaa">/84</span>     |
| Polk         |                             77 | <span style="color: #EC4E20">↑ 1</span>  | 354<span style="color: #aaa">/1330</span>    | 42<span style="color: #aaa">/138</span>    |
| Brevard      |                             63 | <span style="color: #6BAA75">↓ -3</span> | 437<span style="color: #aaa">/1174</span>    | 45<span style="color: #aaa">/121</span>    |

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
