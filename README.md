Florida COVID-19 Data
================
2020-08-05 16:26:25

## Today

| When        | Day        | Positive | New Positive Since | Deaths | New Deaths Since | Total     |
| :---------- | :--------- | :------- | :----------------- | :----- | :--------------- | :-------- |
| Today       | 2020-08-05 | 502,739  | 0                  | 7,751  | 0                | 3,814,884 |
| Yesterday   | 2020-08-04 | 497,330  | 5,409              | 7,526  | 225              | 3,784,458 |
| Last Week   | 2020-07-29 | 451,423  | 51,316             | 6,457  | 1,294            | 3,526,765 |
| 2 Weeks Ago | 2020-07-22 | 379,619  | 123,120            | 5,459  | 2,292            | 3,154,711 |

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

| County       | Current COVID Hospitalizations | Change Since Yesterday                     | Available Hospital Beds                      | Available ICU Beds                        |
| :----------- | -----------------------------: | :----------------------------------------- | :------------------------------------------- | :---------------------------------------- |
| All          |                           7615 | <span style="color: #6BAA75">↓ -242</span> | 13375<span style="color: #aaa">/46543</span> | 948<span style="color: #aaa">/5205</span> |
| Miami-Dade   |                           1670 | <span style="color: #6BAA75">↓ -48</span>  | 1569<span style="color: #aaa">/6893</span>   | 86<span style="color: #aaa">/900</span>   |
| Broward      |                           1072 | <span style="color: #6BAA75">↓ -31</span>  | 1000<span style="color: #aaa">/4267</span>   | 46<span style="color: #aaa">/474</span>   |
| Palm Beach   |                            485 | <span style="color: #EC4E20">↑ 9</span>    | 1237<span style="color: #aaa">/2958</span>   | 93<span style="color: #aaa">/322</span>   |
| Hillsborough |                            435 | <span style="color: #6BAA75">↓ -33</span>  | 539<span style="color: #aaa">/3355</span>    | 13<span style="color: #aaa">/377</span>   |
| Duval        |                            423 | <span style="color: #6BAA75">↓ -28</span>  | 913<span style="color: #aaa">/2844</span>    | 101<span style="color: #aaa">/340</span>  |
| Orange       |                            404 | <span style="color: #6BAA75">↓ -9</span>   | 926<span style="color: #aaa">/3464</span>    | 68<span style="color: #aaa">/304</span>   |
| Pinellas     |                            307 | <span style="color: #6BAA75">↓ -19</span>  | 563<span style="color: #aaa">/2349</span>    | 41<span style="color: #aaa">/245</span>   |
| Polk         |                            263 | <span style="color: #EC4E20">↑ 7</span>    | 322<span style="color: #aaa">/1321</span>    | 9<span style="color: #aaa">/147</span>    |
| Lee          |                            174 | <span style="color: #6BAA75">↓ -59</span>  | 271<span style="color: #aaa">/1501</span>    | 28<span style="color: #aaa">/113</span>   |
| Escambia     |                            172 | <span style="color: #6BAA75">↓ -8</span>   | 376<span style="color: #aaa">/1097</span>    | 12<span style="color: #aaa">/135</span>   |

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
