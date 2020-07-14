Florida COVID-19 Data
================
2020-07-14 12:03:48

## Today

| When           | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :------------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Yesterday      | 2020-07-13 | 282,435  | 0                  | 4,381  | 0                | 2,639,961 |
| The Day Before | 2020-07-12 | 269,811  | 12,624             | 4,346  | 35               | 2,574,394 |
| Last Week      | 2020-07-07 | 213,794  | 68,641             | 3,943  | 438              | 2,269,577 |
| 2 Weeks Ago    | 2020-06-30 | 152,434  | 130,001            | 3,604  | 777              | 1,945,385 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                    | Available Hospital Beds                      | Available ICU Beds                         |
| :----------- | -----------------------------: | :---------------------------------------- | :------------------------------------------- | :----------------------------------------- |
| All          |                           8187 | <span style="color: #EC4E20">↑ 136</span> | 12877<span style="color: #aaa">/47577</span> | 1057<span style="color: #aaa">/5087</span> |
| Miami-Dade   |                           1822 | <span style="color: #EC4E20">↑ 14</span>  | 1631<span style="color: #aaa">/6755</span>   | 158<span style="color: #aaa">/801</span>   |
| Broward      |                           1220 | <span style="color: #EC4E20">↑ 9</span>   | 957<span style="color: #aaa">/4488</span>    | 60<span style="color: #aaa">/459</span>    |
| Palm Beach   |                            637 | <span style="color: #EC4E20">↑ 15</span>  | 1151<span style="color: #aaa">/3038</span>   | 103<span style="color: #aaa">/322</span>   |
| Orange       |                            568 | <span style="color: #EC4E20">↑ 7</span>   | 969<span style="color: #aaa">/3452</span>    | 97<span style="color: #aaa">/275</span>    |
| Duval        |                            515 | <span style="color: #6BAA75">↓ -15</span> | 886<span style="color: #aaa">/2985</span>    | 95<span style="color: #aaa">/345</span>    |
| Hillsborough |                            291 | <span style="color: #EC4E20">↑ 26</span>  | 617<span style="color: #aaa">/3347</span>    | 28<span style="color: #aaa">/346</span>    |
| Lee          |                            274 | <span style="color: #EC4E20">↑ 40</span>  | 236<span style="color: #aaa">/1519</span>    | 15<span style="color: #aaa">/125</span>    |
| Pinellas     |                            237 | <span style="color: #EC4E20">↑ 22</span>  | 558<span style="color: #aaa">/2465</span>    | 46<span style="color: #aaa">/250</span>    |
| Seminole     |                            194 | <span style="color: #EC4E20">↑ 30</span>  | 155<span style="color: #aaa">/758</span>     | 7<span style="color: #aaa">/66</span>      |
| Osceola      |                            183 | <span style="color: #6BAA75">↓ -19</span> | 321<span style="color: #aaa">/838</span>     | 35<span style="color: #aaa">/93</span>     |

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
