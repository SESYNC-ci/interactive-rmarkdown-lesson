[![lifecycle](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://github.com/SESYNC-ci/sesync-ci.github.io/blob/master/lesson/lesson-lifecycle.md#stable)
[![DOI](https://zenodo.org/badge/141140541.svg)](https://zenodo.org/badge/latestdoi/141140541)

## Interactive RMarkdown Lesson

Extend your data pipeline with RMarkdown and Shiny.

## Instructor Notes

* Pay close attention to which worksheet chunk is to be modified. 
* If the first page of the `ioslides_presentation` is blank, click or 
press the left arrow key to advance to the title slide. 
* rmarkdown documents rendered to HTML files can also have interactive 
elements that do not require R code to run (and therefore shiny runtime), 
such as leaflet maps or other [html widgets](http://gallery.htmlwidgets.org/).
* Shiny output objects are stored in a list. This lesson uses double bracket
list notation (eg. `output[['my_plot']]`), which is equivalent to `output$myplot`.
* cache troubleshooting with shiny runtime: under `Run Document`, clear prerendered
output

## Cyberhelp @SESYNC

The National Socio-Environmental Synthesis Center (SESYNC) curates and runs
tutorials on using cyberinfrastructure in pursuit of the Center's scientific
mission. Visit [www.sesync.org](https://www.sesync.org) to learn more about
SESYNC and [cyberhelp.sesync.org](https://cyberhelp.sesync.org) for more
tutorials and ideas.
