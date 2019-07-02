---
---

## Interact with Shiny

Enough about "smart" documents, what about "interactive"?

===

## What is Shiny?

Shiny is a web application framework for R that allows you to create interactive
apps for exploratory data analysis and visualization, to facilitate remote
collaboration, share results, and [much
more](http://shiny.rstudio.com/gallery/).

```
---
output: ioslides_presentation
runtime: shiny_prerendered
---
```
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Input and Output

The [shiny](){:.rlib} package provides functions that generate two key types of
content in the output document: input and output "widgets". The user can change
the input and the output, e.g. a table or plot, dynamically responds.

![]({% include asset.html path="images/arrows3.png" %})

Writing an interactive document requires careful attention to how your input and
output objects relate to each other, i.e. knowing what actions will initiate
what sections of code to run at what time.
{:.notes}

===

## Input Objects

Input objects collect information from the user and save it into a list variable
called `input`. The value for any given named entity in the list updates when
the user changes the input widget with the corresponding name.

````
```{r, echo = FALSE}
selectInput('pick_species',
  label = 'Pick a Species',
  choices = unique(species[['id']]))
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

RStudio has a nice
[gallery](http://shiny.rstudio.com/gallery/widget-gallery.html) of input objects
and accompanying sample code.
{:.notes}

===

## Contexts

As shown in the figure above, an interactive document runs R code in multiple
"contexts"; for example, while rendering the document and in the connected R
process running on the server. The "data" context is a special context needed
for cached chunk output that we want available to the server.

````
```{r load_data, context = 'data', echo = FALSE, cache.extra = md5sum('{{ site.data.lesson.handouts[1] }}')}
source('{{ site.data.lesson.handouts[1] }}')
rodents <- subset(rodents, !is.na(weight))
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

You have to clear (i.e. delete) the cache since we added the runtime.
{:.notes}

===

## Output Objects

Output objects are created in the "server" context by any of several functions
in the [shiny]{:.rlib} package that produce output widgets.

````
```{r, context = 'server'}
library(dplyr)
output[['ts_plot']] <- renderPlot({
  animals %>%
    filter(species_id == input[['pick_species']]) %>%
    ggplot(aes(year)) + 
      geom_bar()
})
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

````
```{r, echo = FALSE}
plotOutput('ts_plot')
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Render Functions

Key functions for creating output objects:

- `renderPrint()`
- `renderText()`
- `renderPlot()`
- `renderTable()`
- `renderDataTable()`

===

## Reactivity

The output objects in an interactive document have to be understood in terms of
reactivity: a reactive object "knows" which changes in the environment (in
particular the list called `input`) should trigger it to update its value. A
useful type of user-created reactive object for an efficient pipeline is any
result of a complicated data manipulation, which can be calculated once and used
multiple times.
{:.notes}

Create additional environment-aware objects with `reactive()` from the
[shiny](){:.rlib} package.

````
```{r, context = 'server'}
plot_data <- reactive({
  filter(animals,
         species_id == input[['pick_species']])
})
output[['react_ts_plot']] <- renderPlot({
  plot_data() %>%
    ggplot(aes(year)) +
      geom_bar()
})
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

Don't forget to include your plot in the document!

````
```{r, echo = FASE}
plotOutput('react_ts_plot')
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

In the worked example, the step of filtering the `animals` data frame still only
occurs once. In a scenario where the subset of animals were used for multiple
computations or vizualitions, creating the reactive `plot_data()` object makes
a more efficient pipeline.
{:.notes}
