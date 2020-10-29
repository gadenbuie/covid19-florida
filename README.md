Florida COVID-19 Data
================
2020-10-29 19:08:18

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-10-29 | 794,624  | 0                  | 16,854 | 0                | 6,091,565 |
| Yesterday   | 2020-10-28 | 790,426  | 4,198              | 16,775 | 79               | 6,053,154 |
| Last Week   | 2020-10-22 | 768,091  | 26,533             | 16,470 | 384              | 5,821,939 |
| 2 Weeks Ago | 2020-10-15 | 744,988  | 49,636             | 15,932 | 922              | 5,643,521 |

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
| All          |                           2338 | <span style="color: #6BAA75">↓ -2</span> | 14439<span style="color: #aaa">/47013</span> | 1431<span style="color: #aaa">/4662</span> |
| Miami-Dade   |                            338 | <span style="color: #EC4E20">↑ 15</span> | 2322<span style="color: #aaa">/6373</span>   | 181<span style="color: #aaa">/756</span>   |
| Broward      |                            206 |                                          | 1019<span style="color: #aaa">/4283</span>   | 81<span style="color: #aaa">/392</span>    |
| Hillsborough |                            152 | <span style="color: #6BAA75">↓ -5</span> | 733<span style="color: #aaa">/3294</span>    | 55<span style="color: #aaa">/325</span>    |
| Orange       |                            140 | <span style="color: #EC4E20">↑ 4</span>  | 1001<span style="color: #aaa">/3448</span>   | 122<span style="color: #aaa">/276</span>   |
| Palm Beach   |                            140 | <span style="color: #6BAA75">↓ -1</span> | 1275<span style="color: #aaa">/2774</span>   | 153<span style="color: #aaa">/232</span>   |
| Duval        |                            131 | <span style="color: #6BAA75">↓ -2</span> | 930<span style="color: #aaa">/2804</span>    | 108<span style="color: #aaa">/329</span>   |
| Pinellas     |                            123 | <span style="color: #6BAA75">↓ -6</span> | 895<span style="color: #aaa">/2255</span>    | 64<span style="color: #aaa">/236</span>    |
| Osceola      |                             81 | <span style="color: #6BAA75">↓ -2</span> | 283<span style="color: #aaa">/872</span>     | 40<span style="color: #aaa">/83</span>     |
| Polk         |                             79 |                                          | 389<span style="color: #aaa">/1305</span>    | 83<span style="color: #aaa">/103</span>    |
| Alachua      |                             74 | <span style="color: #EC4E20">↑ 3</span>  | 270<span style="color: #aaa">/1466</span>    | 48<span style="color: #aaa">/260</span>    |

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
