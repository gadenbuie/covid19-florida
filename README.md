Florida COVID-19 Data
================
2020-08-26 19:11:55

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-26 | 608,722  | 0                  | 10,872 | 0                | 4,492,818 |
| Yesterday   | 2020-08-25 | 605,502  | 3,220              | 10,717 | 155              | 4,466,524 |
| Last Week   | 2020-08-19 | 584,047  | 24,675             | 10,067 | 805              | 4,306,239 |
| 2 Weeks Ago | 2020-08-12 | 550,901  | 57,821             | 8,898  | 1,974            | 4,087,579 |

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
| All          |                           4405 | <span style="color: #6BAA75">↓ -141</span> | 14276<span style="color: #aaa">/46391</span> | 1162<span style="color: #aaa">/4897</span> |
| Miami-Dade   |                            802 | <span style="color: #6BAA75">↓ -29</span>  | 2052<span style="color: #aaa">/6460</span>   | 145<span style="color: #aaa">/816</span>   |
| Broward      |                            559 | <span style="color: #6BAA75">↓ -25</span>  | 939<span style="color: #aaa">/4182</span>    | 81<span style="color: #aaa">/412</span>    |
| Palm Beach   |                            253 | <span style="color: #EC4E20">↑ 10</span>   | 1263<span style="color: #aaa">/2781</span>   | 117<span style="color: #aaa">/287</span>   |
| Duval        |                            252 | <span style="color: #6BAA75">↓ -7</span>   | 878<span style="color: #aaa">/2787</span>    | 92<span style="color: #aaa">/349</span>    |
| Orange       |                            213 | <span style="color: #6BAA75">↓ -15</span>  | 958<span style="color: #aaa">/3457</span>    | 88<span style="color: #aaa">/284</span>    |
| Hillsborough |                            210 | <span style="color: #6BAA75">↓ -25</span>  | 667<span style="color: #aaa">/3142</span>    | 45<span style="color: #aaa">/329</span>    |
| Gadsden      |                            165 |                                            | 197<span style="color: #aaa">/756</span>     | 0<span style="color: #aaa">/0</span>       |
| Polk         |                            153 | <span style="color: #6BAA75">↓ -3</span>   | 316<span style="color: #aaa">/1327</span>    | 18<span style="color: #aaa">/134</span>    |
| Pinellas     |                            136 | <span style="color: #EC4E20">↑ 5</span>    | 794<span style="color: #aaa">/2154</span>    | 50<span style="color: #aaa">/251</span>    |
| Lee          |                            127 | <span style="color: #6BAA75">↓ -9</span>   | 385<span style="color: #aaa">/1479</span>    | 33<span style="color: #aaa">/108</span>    |

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
