---
---

## Reproducible Pipeline

A pipeline might rely on several scripts that separately aquire data, tidy it,
fit or run models, and validate results. Embedding calls to those external
scripts is one way to create a one-click pipeline.

===

## Sourced Input

The `source` function in R includes the contents of a separate file in the
current code chunk. The entire script is evaluated in the current environment.

````
```{r load_data, echo = FALSE}
source('{{ site.data.lesson.handouts[1] }}')
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

The lesson's `.R` worksheet is an R script creating a `rodents` data frame,
which "sourcing" makes available to following lines as well as subsequent code
chunks.
{:.notes}

===

````
```{r bar_plot}
library(ggplot2)
ggplot(rodents, aes(x = species_id, y = count)) +
  geom_bar(stat = 'identity')
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

If your entire pipeline can be scripted in R, you *could* embed the entire
analysis in code chunks within your write-up. The better practice demonstrated
here is "modularizing" your analysis by splitting it into isolated scripts, and
then using an [rmarkdown](){:.rlib} document to execute the pipeline.
{:.notes}

===

## Non-sourced Input

RMarkdown code chunks are not limited to R. Several "engines", including
Python and SQL, can be used for code written directly into a code chunk.

````
```{python}
greeting = 'Hello, {}!'
print(greeting.format('World'))
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

Access to your operating system shell, for example the Linux Bash interpreter,
provides a way to run any scripted pipeline step.

````
```{bash}
echo "Hello, ${USER}!"
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

An important distinction between sourced and non-sourced input is the inabillity
of interpreters other than R to return R objects. By using `source`, an R script
is run in the current R session, which provides an easy way to pass data between
scripts. Typically, file-based input and output is necessary for multi-lingual
pipelines. For Python, however, the
[reticulate](https://rstudio.github.io/reticulate/articles/r_markdown.html)
package provides a bi-directional interface.
{:.notes}

===

## Efficient Pipelines

There is no reason to run every step of a pipeline after making changes
"downstream". Like more comprehensive software for automating pipelines,
[rmarkdown](){:.rlib} includes the notion of tracking dependencies and caching
results. Cached code chunks are not re-evaluated unless the content of the code
changes.
{:.notes}

Enable `cache` in a `setup` chunk to turn off re-evaluation of any code
chunk that has not been modified since the last `knit`.

````
```{r setup, include = FALSE}
library(knitr)
opts_chunk$set(message = FALSE, warning = FALSE, cache = TRUE)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Cache

Render the worksheet again to create a cache for each code chunk, *and then*
modify your `bar_plot` chunk to show species' weights and render again. The
"slow" `load_data` chunk zips right by, using its cache, but the plot will
change.

````
```{r bar_plot}
library(ggplot2)
ggplot(rodents, aes(x = species_id, y = weight)) +
  geom_bar(stat = 'identity')
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Cache Dependencies

With the `dependson` option, even an unmodified chunk will be re-evaluated if a
dependency runs.

````
```{r clean_bar_plot, dependson = 'load_data'}
ggplot(rodents, aes(x = species_id, y = weight)) +
  geom_bar(stat = 'identity')
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

Add the above new chunk with `dependson = 'load_data'` so it updates if and only
if the load_data chunk is executed. Knit the document and compare the
`bar_chart` and `clean_bar_chart` outputs; at this point `bar_plot` and
`clean_bar_plot` should be identical. Now make `load_data` clean the data, then
`knit` again and compare the plots.
{:.notes}

````
```{r load_data, echo = FALSE}
source('{{ site.data.lesson.handouts[1] }}')
rodents <- subset(rodents, !is.na(weight))
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

The updated result of `clean_bar_plot` now reflects the cleaning operation on
the `rodents` data frame. But the `bar_plot` chunk simply loaded results from
its cache, because the dependency was not explicit.
{:.notes}

Note that while the second plot is re-drawn when the `load_data` *chunk*
changes, the chunk mostly just brings in sourced input. The `rodents` variable
could change if the code in the sourced file is updated, but this would *not*
trigger re-generation of the second plot!
{:.notes}

===

## External Dependencies

By adding the option `cache.extra`, any trigger can be given to force
re-evaluation of an unmodified chunk. In combination with the `md5sum` function
from the `tools` package, it provides a mechanism for external file
dependencies.

````
```{r setup}
library(knitr)
library(tools)
opts_chunk$set(message = FALSE, warning = FALSE, cache = TRUE)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

With the [tools](){:.rlib} package loaded in the "setup" chunk, we can use it
within any chunk option definition.

````
```{r load_data, echo = FALSE, cache.extra = md5sum('{{ site.data.lesson.handouts[1] }}')}
source('{{ site.data.lesson.handouts[1] }}')
rodents <- subset(rodents, !is.na(weight))
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

A change to the `rodents` data frame, for example by dropping NAs at a more
appropriate data cleaning step in the sourced `.R` script, will now be reflected
in the `clean_bar_plot` result with `dependson = load_data`, but not the
`bar_plot` plot.
{:.notes}
