---
---

## Lesson Objectives

1. Start with "dumb" documents and the basics of Markdown.
1. Get "smart" by embedding computed document content.
1. Go "interactive" with [shiny](){:.rlib} components.
1. Envision an efficient, one-click pipeline with RMarkdown.

===

## Specific Achievements

1. Create a slideshow with interactive visualizations.

===

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
[www.shinyapps.io](https://www.shinyapps.io).

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

The [rmarkdown](){:.rlib} package bundles the formatting ability of Markdown
with the ability to send embedded code to an R interpreter and capture the
result.

===

## Seeing is Believing

The lesson's `.Rmd` worksheet is an RMarkdown script. Open it and find the
following incantation.

````
```{r}
x <- rnorm(10)
mean(x)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

Press the "Knit" button in RStudio to generate the computed document. Note that
after the code we entered is the computed result. As we proceed, fill in each
`...` in your worksheet, and press the "Knit" button to examine the result.
{:.notes}
