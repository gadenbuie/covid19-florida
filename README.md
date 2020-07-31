Florida COVID-19 Data
================
2020-07-31 12:06:13

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-07-31 | 470,386  | 0                  | 6,966  | 0                | 3,628,088 |
| Yesterday   | 2020-07-30 | 461,379  | 9,007              | 6,709  | 257              | 3,579,117 |
| Last Week   | 2020-07-24 | 402,312  | 68,074             | 5,768  | 1,198            | 3,276,636 |
| 2 Weeks Ago | 2020-07-17 | 327,241  | 143,145            | 4,912  | 2,054            | 2,880,768 |

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
| All          |                           8246 | <span style="color: #6BAA75">↓ -149</span> | 13485<span style="color: #aaa">/46485</span> | 1020<span style="color: #aaa">/5209</span> |
| Miami-Dade   |                           1773 | <span style="color: #6BAA75">↓ -54</span>  | 1635<span style="color: #aaa">/6963</span>   | 91<span style="color: #aaa">/886</span>    |
| Broward      |                           1206 | <span style="color: #6BAA75">↓ -26</span>  | 919<span style="color: #aaa">/4535</span>    | 46<span style="color: #aaa">/482</span>    |
| Palm Beach   |                            526 | <span style="color: #6BAA75">↓ -6</span>   | 1215<span style="color: #aaa">/2938</span>   | 98<span style="color: #aaa">/325</span>    |
| Duval        |                            464 | <span style="color: #6BAA75">↓ -5</span>   | 886<span style="color: #aaa">/2876</span>    | 103<span style="color: #aaa">/334</span>   |
| Orange       |                            456 | <span style="color: #6BAA75">↓ -3</span>   | 985<span style="color: #aaa">/3408</span>    | 82<span style="color: #aaa">/290</span>    |
| Hillsborough |                            445 | <span style="color: #6BAA75">↓ -15</span>  | 579<span style="color: #aaa">/3179</span>    | 29<span style="color: #aaa">/355</span>    |
| Pinellas     |                            351 | <span style="color: #6BAA75">↓ -21</span>  | 545<span style="color: #aaa">/2336</span>    | 42<span style="color: #aaa">/253</span>    |
| Polk         |                            283 | <span style="color: #EC4E20">↑ 5</span>    | 326<span style="color: #aaa">/1309</span>    | 15<span style="color: #aaa">/172</span>    |
| Escambia     |                            199 | <span style="color: #6BAA75">↓ -3</span>   | 337<span style="color: #aaa">/1119</span>    | 14<span style="color: #aaa">/133</span>    |
| Lee          |                            164 | <span style="color: #6BAA75">↓ -4</span>   | 295<span style="color: #aaa">/1464</span>    | 26<span style="color: #aaa">/115</span>    |

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
