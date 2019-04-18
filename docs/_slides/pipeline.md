---
---

## Reproducible Pipeline

A pipeline might rely on several scripts that separately aquire data, tidy it,
fit or run models, and validate results. Embedding calls to those external
scripts is one way to create a one-click pipeline.

## Sourced Pipeline

The `source` function in R includes the contents of a separate file in the
current code chunk. The entire script is evaluated in the current environment.

````
```{r load_data, echo = FALSE}
source('{{ site.handouts[1] }}')
```
````

The lesson's `.R` worksheet is an R script creating a `rodents` data frame,
which "sourcing" makes available to following lines as well as subsequent code
chunks.
{:.notes}

## Sourced Pipeline

````
```{r bar_plot}
library(ggplot2)
ggplot(rodents, aes(x = species_id, y = count)) +
  geom_bar(stat = 'identity')
```
````

If your entire pipeline can be scripted in R, you *could* embed the entire
analysis in code chunks within your write-up. The better practice demonstrated
here is "modularizing" your analysis by splitting it into isolated scripts, and
then using an [rmarkdown][1] document to execute the pipeline.
{:.notes}

===

## Non-sourced pipelines

The code interpreter is not limited to R. Several interpreters, including
`python` and `sql`, can be used for code written directly into a code chunk.

````
```{python}
greeting = 'Hello, {}!'
print(greeting.format('world'))
```
````

===

## Non-sourced pipelines

Access to your operating system shell, for example the Linux `bash` interpreter,
provides a way to run any scripted pipeline step.

````
```{bash}
python -c 'import os; print("Hello, {}!".format(os.environ["USER"]))'
```
````

An important distinction between sourced and non-sourced pipelines is the
inabillity of interpreters other than R to return R objects. By using `source`,
an R script is run in the current R session, which provides an easy way to pass
data between scripts. Typically, file-based input and output is necessary for
multi-lingual pipelines. For Python, however, the [reticulate](https://rstudio.github.io/reticulate/articles/r_markdown.html) package
provides a bi-directional interface.
{:.notes}

===

## Efficient Pipelines

There is no reason to run every step of a pipeline after making changes
"downstream". Like more comprehensive software for automating pipelines,
[rmarkdown](){:.rlib} includes the notion of tracking dependencies and caching results.
Cached code chunks are not re-evaluated unless the content of the code changes.
{:.notes}

Enable `cache` in the `setup` chunk to turn off re-evaluation of any code
chunk that has not been modified since the last `knit`.

````
```{r setup, include = FALSE}
library(knitr)
opts_chunk$set(message = FALSE, warning = FALSE, out.width = '75%', cache = TRUE)
```
````

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

===

Add the above new chunk with `dependson = 'load_data'` so it updates if and only
if the load_data chunk is executed. Knit the document and compare the
`bar_chart` and `clean_bar_chart` outputs; at this point `bar_plot` and
`clean_bar_plot` should be identical. Now make `load_data` clean the data, then
`knit` again and compare the plots.
{:.notes}

````
```{r load_data, echo = FALSE}
source('{{ site.handouts[1] }}')
rodents <- subset(rodents, !is.na(weight))
```
````

The updated result of `clean_bar_plot` now reflects the cleaning operation on
the `rodents` data frame. But the `bar_plot` chunk simply loaded results from
its cache, because the dependency was not explicit.
{:.notes}

Note that the second plot will execute when the `load_data` *chunk* changes, but
this chunk contains a call to `source`. The `rodents` variable could change if
the code in the sourced file is updated, but this would *not* trigger
re-generation of the second plot!
{:.notes}

===

## External Dependencies

By adding the option `cache.extra`, any trigger can be given to force
re-evaluation of an unmodified chunk. In combination with the `md5sum` function
from the `tools` package, this permits external file dependencies.

````
```{r setup}
library(knitr)
library(tools)
opts_chunk$set(message = FALSE, warning = FALSE, out.width = '75%', cache = TRUE)
```
````
````
```{r load_data, echo = FALSE, cache.extra = md5sum('{{ site.handouts[1] }}')}
source('{{ site.handouts[1] }}')
rodents <- subset(rodents, !is.na(weight))
```
````

A change to the `rodents` data frame, for example by dropping NAs at a more
appropriate data cleaning step in the sourced `.R` script, will now be reflected
in the `clean_bar_plot` result with `dependson = load_data`, but not the
`bar_plot` plot.
{:.notes}
