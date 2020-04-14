# 2020-04-13

- At some point in the last few days, the Cases variable in the Line List table
  served via ArcGis changed from a numeric timestamp to a character `d/m/Y HH:MM`
  timestamp.

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