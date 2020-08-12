Florida COVID-19 Data
================
2020-08-12 19:10:57

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-12 | 550,901  | 0                  | 8,898  | 0                | 4,087,579 |
| Yesterday   | 2020-08-11 | 542,792  | 8,109              | 8,685  | 213              | 4,049,275 |
| Last Week   | 2020-08-05 | 502,739  | 48,162             | 7,751  | 1,147            | 3,814,884 |
| 2 Weeks Ago | 2020-07-29 | 451,423  | 99,478             | 6,457  | 2,441            | 3,526,765 |

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
| All          |                           6551 | <span style="color: #6BAA75">↓ -204</span> | 13886<span style="color: #aaa">/46993</span> | 1119<span style="color: #aaa">/5078</span> |
| Miami-Dade   |                           1368 | <span style="color: #6BAA75">↓ -74</span>  | 1705<span style="color: #aaa">/6805</span>   | 145<span style="color: #aaa">/867</span>   |
| Broward      |                            885 | <span style="color: #6BAA75">↓ -35</span>  | 988<span style="color: #aaa">/4263</span>    | 57<span style="color: #aaa">/464</span>    |
| Palm Beach   |                            421 | <span style="color: #6BAA75">↓ -21</span>  | 1294<span style="color: #aaa">/2860</span>   | 104<span style="color: #aaa">/317</span>   |
| Duval        |                            371 | <span style="color: #6BAA75">↓ -14</span>  | 929<span style="color: #aaa">/2834</span>    | 110<span style="color: #aaa">/331</span>   |
| Hillsborough |                            334 | <span style="color: #EC4E20">↑ 18</span>   | 541<span style="color: #aaa">/3211</span>    | 41<span style="color: #aaa">/333</span>    |
| Orange       |                            305 | <span style="color: #6BAA75">↓ -34</span>  | 928<span style="color: #aaa">/3464</span>    | 70<span style="color: #aaa">/302</span>    |
| Pinellas     |                            256 | <span style="color: #EC4E20">↑ 1</span>    | 616<span style="color: #aaa">/2282</span>    | 54<span style="color: #aaa">/250</span>    |
| Polk         |                            200 | <span style="color: #6BAA75">↓ -23</span>  | 397<span style="color: #aaa">/1321</span>    | 28<span style="color: #aaa">/152</span>    |
| Lee          |                            180 | <span style="color: #6BAA75">↓ -2</span>   | 375<span style="color: #aaa">/1415</span>    | 39<span style="color: #aaa">/102</span>    |
| Escambia     |                            161 | <span style="color: #6BAA75">↓ -13</span>  | 389<span style="color: #aaa">/1106</span>    | 12<span style="color: #aaa">/135</span>    |

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
