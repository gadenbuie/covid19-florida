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