---
---

## How Smart?

The reproducible pipeline under construction begins with open data, uses scripts
to perform analyses and create visualizations, and ideally ends in a published
write-up.

[rmarkdown](){:.rlib} merges code and documentation, allowing you to create
automatic reports that include the results of computations and visualizations
created on-the-fly.

===

## How Interactive?

Rather than rendering to a static document, RStudio lets you easily inject
[shiny](){:.rlib} input and output widgets to documents constructed with RMarkdown.
These widgets can accept user input through forms, menus, and sliders, and cause
corresponding tables, plots, and other graphical output to dynamically update.
{:.notes}

Interactive documents require connection to a live R process, which any user
running RStudio can provide, but so can hosting services like
http://www.shinyapps.io/.

===

## Lesson Objectives

1. Start with "dumb" documents and the basics of Markdown.
1. Envision an efficient, one-click pipeline with RMarkdown.
1. Create an interactive document with Shiny.

===

## Markdown

Markdown exists outside of the R environment. Like R, it is both a language and
an interpreter.

1. It is a **language** with special characters and a syntax that convey
formatting instructions inside text files.

1. The accompanying **interpreter** reads text files and outputs one of several
types of formatted documents (e.g Word, PDF, and HTML).

===

## RMarkdown

The [rmarkdown][1] package bundles the formatting ability of Markdown
with the ability to send embedded code to an R interpreter and capture the
result.

===

## Seeing is Believing

The handout for this lesson _is_ this lesson. The lesson's `.Rmd` worksheet is
the RMarkdown source for this document (with a few ommissions for you to
fill in). Open it and find this line of code:



~~~r
> data.frame(counts = c(4, 5, 6))
~~~
{:.input title="Console"}


~~~
  counts
1      4
2      5
3      6
~~~
{:.output}


The output *is not in the source*---it was "knit" into the rendered
output. Press the "Knit" button in RStudio to generate the single-page view of
this lesson. As we proceed, fill in the `...` areas of your worksheet, and press
the "Knit" button to verify the output.
{:.notes}
