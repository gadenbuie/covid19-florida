Florida COVID-19 Data
================
2020-07-13 17:00:01

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-13 | 282,435  | 0                  | 4,381  | 0                | 2,639,961 |
| Yesterday   | 2020-07-12 | 269,811  | 12,624             | 4,346  | 35               | 2,574,394 |
| Last Week   | 2020-07-06 | 206,447  | 75,988             | 3,880  | 501              | 2,234,325 |
| 2 Weeks Ago | 2020-06-29 | 146,341  | 136,094            | 3,546  | 835              | 1,913,132 |

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

![](plots/covid-19-florida-icu-usage.png)

| County       | COVID Hospitalizations |
| :----------- | ---------------------: |
| All          |                   8085 |
| Miami-Dade   |                   1806 |
| Broward      |                   1209 |
| Palm Beach   |                    628 |
| Orange       |                    561 |
| Duval        |                    544 |
| Hillsborough |                    295 |
| Lee          |                    234 |
| Pinellas     |                    223 |
| Osceola      |                    202 |
| Collier      |                    189 |
| Seminole     |                    164 |
| Escambia     |                    156 |
| Polk         |                    142 |
| Volusia      |                    140 |
| St. Lucie    |                    130 |
| Sarasota     |                    129 |
| Brevard      |                    125 |
| Lake         |                    113 |
| Alachua      |                    106 |
| Marion       |                     97 |
| Pasco        |                     97 |
| Manatee      |                     89 |
| Leon         |                     71 |
| Hernando     |                     62 |
| Bay          |                     58 |
| Martin       |                     48 |
| Highlands    |                     45 |
| Charlotte    |                     39 |
| Okaloosa     |                     39 |
| Clay         |                     37 |
| St. Johns    |                     36 |
| Indian River |                     34 |
| Jackson      |                     33 |
| Baker        |                     30 |
| Citrus       |                     21 |
| Putnam       |                     21 |
| Columbia     |                     20 |
| Flagler      |                     20 |
| Santa Rosa   |                     20 |
| Sumter       |                     20 |
| Monroe       |                     15 |
| Okeechobee   |                     14 |
| Nassau       |                      6 |
| Hendry       |                      5 |
| Walton       |                      4 |
| Washington   |                      4 |
| Desoto       |                      2 |
| Calhoun      |                      1 |
| Gulf         |                      1 |
| Franklin     |                      0 |
| Gadsden      |                      0 |
| Hardee       |                      0 |
| Holmes       |                      0 |
| Madison      |                      0 |
| Suwannee     |                      0 |
| Taylor       |                      0 |
| Union        |                      0 |

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
