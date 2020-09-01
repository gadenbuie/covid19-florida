# 2020-09-01

- I started to hit the strict 100MB file limit for the _Cases by Day_ data set
  archived from the FL DOH ArcGIS API. Instead of appending each new snapshot,
  only the latest snapshot will be kept, starting from 2020-08-31.

# 2020-07-17

- The ArcGIS feature layer with state summary statistics for the dashboard now
  include a state total where the `countyname` is `State`, or possibly `A State`.

# 2020-07-13

- Capture dataa from AHCA: hospitalizations, hospital bed capacity and icu capacity

# 2020-07-12

- I added the "deaths by day" to the data collected from the ArcGIS feature server.
  Note that the deaths included in this data are only Florida residents, and
  include residents who were diagnosed/isolated outside of Florida.
  
  https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/ArcGIS/rest/services/Florida_COVID_19_Deaths_by_Day/FeatureServer/
  
- The health metrics data snapshot is only saved if the data has changed since
  the last update.

# 2020-06-23

- Now that the line list has passed 100k cases, the ArcGIS API requires scientific
  notation for result offests above 1e5. I've updated the query paging to fix this
  issue, but it seems that as of 2020-06-23 13:30 the line list has not yet been
  updated today (the number of rows is equal to yesterday's cases).

# 2020-06-08

- The location and file name format of the PDF reports was changed on 2020-06-04.
  I noticed on 2020-06-08 and updated my scripts, but the reports from
  2020-06-04 through 2020-06-07 were not stored.
  
- Reports on serology and antibody testing were added, presumably at the same
  time as the change in report location and naming (guess: 2020-06-04).

# 2020-05-21

- I updated the PDF extraction scripts to fix the extraction of the lab testing
  summary tables. In working on this, I noticed that the column headers have
  changed three times since these reports have been published:
  
  - Originally "Laboratory", "Negative", "Positive", "Total", "% Positive"
  - On 2020-03-18, "Laboratory" was changed to "Reporting Lab"
  - On 2020-04-11 (afternoon update), the "Inconclusive" column was added

# 2020-05-19

- I've found the updated link to the cases by zip code data and have resumed
  collecting those data.

# 2020-05-16

- The total tests reported on the dashboard between 2020-05-15 19:00 and 
  2020-05-16 08:00 EDT were out of range and are clearly erroneous.
  
- The data updates seem to be happening later in the day after 1pm, so I've
  gone back to using the last snapshot of the day for the day's counts.

# 2020-05-10

- The line list API was removed on 2020-05-09 from the public FeatureServer but 
  is still available under a new URL. I've updated my scripts to pull from that 
  URL and I don't think I've missed any updates.
  

# 2020-05-08

- The `event_date` column was removed on 2020-05-07 from the line list and
  as of 2020-05-08 the `age` column is missing for all cases. It's likely that
  the removal of the `event_date` is related to recent news coverage about
  early cases of coronavirus, see [issue #17](https://github.com/gadenbuie/covid19-florida/issues/17)
  for more discussion. I may have missed a day of updates (2020-05-07).
  
- The URL for the cases by day timeseries API changed, I may have also missed
  an update here.
  
# 2020-05-06 -- 2020-05-07

- It appears that there were issues with updates to the dashboard and data on
  these days. I believe the 11am update on 2020-05-07 was late (updated
  sometime between 12pm and 7pm). I've corrected the daily counts in the data
  used in my charts by treating the 2020-05-07 19:00 snapshot as if it happened
  at 2020-05-07 12:59.

# 2020-04-29

- Added **Health Metrics** data set that was released on 2020-04-28.
  <https://fdoh.maps.arcgis.com/home/item.html?id=492f02b473df4c8f8aa68fedf420c933>
  
- Fixed directory names in `pdfs/` so that they do not include `":"` (#18).

# 2020-04-25

- Starting Saturday April 25, the COVID-19 case and testing counts are only
  updated once daily, at around 11am. I've modified my summary plots and scripts
  to use the last snapshot of reported counts prior to 1pm, so that daily changes
  prior to the 2020-04-25 change are comparable to changes obsevered after.

# 2020-04-22 and 2020-04-23

- The evening update on 2020-04-22 may have come later than usual and my 
  snapshot may have missed the last update of the day. I've manually adjusted
  the `dash_summary` and `arcgis_summary` tables to match.
  
- As of 2020-04-23 in the morning, the line list is currently not available.
  This is causing the dashboard to show "0 Total Cases". I adjusted the snapshot
  scripts so that updates will be stored only when the table is available.

# 2020-04-13

- At some point in the last few days, the Cases variable in the Line List table
  served via ArcGIS changed from a numeric timestamp to a character `d/m/Y HH:MM`
  timestamp.
  
- Similarly Florida resident deaths were previously reported in the variable
  `fl_res_deaths`, which was renamed `c_fl_res_deaths` in the county-level
  summary table served via ArcGIS.

# 2020-04-09

- Additional tables that have been added to the dashboard are now also available
  via the arcgis API. I've added the Cases By Zip and Cases by Day tables to the
  data sets. The raw `geojson` for cases by zip are also included in
  `data/geojson`.
  
- I fixed an issue with the line list query to better utilize the arcgis API.
  I mised one or possibly two updates to this table in since 2020-04-08.

# 2020-03-26

- The total number of positive cases (regardless of Florida residency status)
  was remove from the dashboard in the evening. The dashboard now only shows the
  number of positive cases among Florida residents.

# 2020-03-25

- The division of ages in the case count by age range summary on Page 2 of the
  PDF report has changed from 0-9, 10-19, etc. to 0-4, 5-14, 15-24, etc. in the
  2020-03-25-1007 report.
  
- The order of the columns in the `county_testing` table changed with the
  2020-03-25-1007 report to
  
   - `county`, `pending`, `inconclusive`, `negative`, `positive`, `percent`, `total`
  
  and the heading of the page was changed from _All persons tested_ to
  _All persons with tests reported_.

# 2020-03-24

- PDF processing is now part of the automatic update. Failures in the extraction
  process are recorded in the README.md file in the pdf-specific data folder
  in `pdfs/`.
  
- Added a few more strategies for parsing the Line List tables in the PDF repots
  that fixed a few issues in previous extractions and should make the process
  more robust.

# 2020-03-23

- Added historical PDF reports from 2020-03-16,17,18 that were found via Google

- **Internal** Fixed two issues with the Line List tables extracted from the 
  PDFs. One of the issues caused the extraction to fail for the 2020-03-22 18:28
  report, which is now added. The other issue caused cases who are listed in
  both the line list of cases and the line list of deaths to be double counted.
  The cases who died are now removed from the line list of cases (matched based
  on county, age, sex, date of counting) and death is indicated via the `died`
  column.
  
- Added plot showing age distribution by sex among positive cases

# 2020-03-22

## Major Changes

For better organization, I've moved all of the data files into the same folder:
`data/`. Files that are *not* actively updated are stored in `old/`.

- `covid-19-florida-tests.csv` -> [data/covid-19-florida_dash_summary.csv](data/covid-19-florida_dash_summary.csv)
- `covid-19-florida-cases-county.csv` -> [data/old/covid-19-florida_dash_county.csv](data/old/covid-19-florida_dash_county.csv)
- `covid-19-florida-doh.csv` -> [data/old/covid-19-florida-doh.csv](data/old/covid-19-florida-doh.csv)
- The combined data extracted from the PDFS moved from `pdfs/data` to [data/](data/)
  and the `covid-19-florida-pdf-` prefix was added.


## Other updates

- The county-level confirmed cases table now spans multiple pages (2-3), as of 
  the 2020-03-22 09:51 report.

- The _community spread_ table added in the 2020-03-21 10:08:00 EDT report was
  removed in the next report (2020-03-21 17:31:00 EDT).
  
- A column for people with _inconclusive_ test results was added to the 
  county-level testing table on pages 5-6 of the 2020-03-21 17:31:00 EDT report.
  
- The text for the count of tests awaiting results at BHPL changed from
  _Awaiting BPHL testing_ to _Awaiting BPHL (state public health lab) testing_
  in the 2020-03-21 17:31:00 EDT report, and then back again to the original
  wording in the next iteration (2020-03-22 09:51:00 EDT).
  
- *Internal* I added `try_safely()` to minimize parsing errors that might break
  the complete pdf processing pipeline. I also muffled parsing of pdf text 
  tables with `quietly()`.
  
- The *county deaths* label was changed to *deaths* in the afternoon of 
  between 2020-03-21 11:26:37 EDT and 2020-03-21 16:26:06 EDT.
  
- *Internal* Use the negatives reported in the PDF and the positive, pending,
  and deaths reported in the dashboard for the plots on the front page. Also
  replace change in "resolved" cases with plot of new deaths.
  
- Fixed issue with dashboard html processing so that the values on the main
  display are used preferentially over values in inner tabs.

# 2020-03-21

- A _community spread_ table was added to the 2020-03-21 10:08:00 EDT report
  and includes cases where travel or contact with a confirmed case cannot be
  established as the source of infection.
  
- The dashboard now reports *county deaths* and *florida deaths*. The former is
  now preferentially used for the number of deaths in the plot in the README of
  this repo.