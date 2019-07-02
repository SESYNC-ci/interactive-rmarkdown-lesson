---
---

## R + Markdown

The [rmarkdown](){:.rlib} package evaluates the R expressions within a code fence and
inserts the result into the output document. To send these "code chunks" to the
R interpreter, append `{r}` to the upper fence.

````
```{r}
seq(1, 10)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Chunk Options

Each code chunk runs under options specified globally or within the `{r, ...}`
expression. The option `echo = FALSE` would cause the output to render without
the input. The option `eval = FALSE`, would prevent evaluation and output
rendering.

````
```{r, echo = FALSE}
seq(1, 10)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Chunk Labels

The first entry after `{r` will be interpretted as a chunk label if it is not
setting an option. Chunk options are specified after the optional label and
separated by commas. Labels do not show up in the document---we'll have other
uses for them.

````
```{r does_not_run, eval = FALSE}
seq(1, 10)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}
