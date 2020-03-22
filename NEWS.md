# 2020-03-22

- The _community spread_ table added in the 2020-03-21 10:08:00 EDT report was
  removed in the next report (2020-03-21 17:31:00 EDT).
  
- A column for people with _inconclusive_ test results was added to the 
  county-level testing table on pages 5-6 of the 2020-03-21 17:31:00 EDT report.
  
- The text for the count of tests awaiting results at BHPL changed from
  _Awaiting BPHL testing_ to _Awaiting BPHL (state public health lab) testing_
  in the 2020-03-21 17:31:00 EDT report, and then back again to the original
  wording in the next iteration (2020-03-22 09:51:00 EDT).
  
- *Internal* I added `try_safely()` to minimize parsing errors from breaking
  the complete pdf processing pipeline. I also muffled parsing of pdf text 
  tables with `quietly()`.
  
- The *county deaths* label was changed to *deaths* in the afternoon of 
  between 2020-03-21 11:26:37 EDT and 2020-03-21 16:26:06 EDT.
  
- *Internal* Use the negatives reported in the PDF and the positive, pending,
  and deaths reported in the dashboard for the plots on the front page. Also
  replace change in "resolved" cases with plot of new deaths.

# 2020-03-21

- A _community spread_ table was added to the 2020-03-21 10:08:00 EDT report
  and includes cases where travel or contact with a confirmed case cannot be
  established as the source of infection.
  
- The dashboard now reports *county deaths* and *florida deaths*. The former is
  now preferentially used for the number of deaths in the plot in the README of
  this repo.