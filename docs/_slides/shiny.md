---
---

## Interact with Shiny

Enough about "smart" documents, what about "interactive"?

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

===

## Input and Output

The [shiny][2] package provides functions that generate two key types of
content in the output document: input and output "widgets". The user can change
the input and the output, e.g. a table or plot, dynamically responds.

<img src="{{ site.baseurl }}/docs/images/arrows3.png" title=" " alt=" " width="100%" />

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
```{r echo = FALSE}
selectInput('pick_species',
  label = 'Pick a Species',
  choices = unique(species[['id']]))
```
````

RStudio has a nice [gallery][3] of input objects and accompanying sample code.
{:.notes}

## Contexts

As shown in the figure above, an interactive document runs R code in multiple
"contexts"; for example, while rendering the document and in the connected R
process running on the server. The "data" context is a special context needed
for cached chunk output that we want available to the server.

````
```{r load_data, echo = FALSE, cache.extra = md5sum('{{ site.handouts[1] }}'), context = 'data'}
source('{{ site.handouts[1] }}')
rodents <- subset(rodents, !is.na(weight))
```
````

You might have to clear (i.e. delete) the cache since we added the runtime.

## Output Objects

Output objects are created in ther "server" context by several functions in the
[shiny]{:.rlib} package that produce a range of widgets.

````
```{r context = 'server'}
library(dplyr)
output[['ts_plot']] <- renderPlot({
  animals %>%
    filter(species_id == input[['pick_species']]) %>%
    ggplot(aes(year)) + 
      geom_bar()
})
```
````
````
```{r echo = FALSE}
plotOutput('ts_plot')
```
````

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
reactivity: each one "knows" its content should react to certain changes in the
environment, including to the `input` list.
{:.notes}

Create additional environment-aware objects with `reactive()` from the
[shiny](){:.rlib} package. A useful type of reactive object for an efficient pipeline
is the result of data manipulations, which can be calculated once and used
multiple times.

````
```{r context = 'server'}
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

===

## Reactivity

Don't forget to include your plot in the document!

````
```{r echo = FASE}
plotOutput('react_ts_plot')
```
````

In the worked example, the step of filtering the `animals` data frame still only
occurs once. In a scenario where the subset of animals were used for multiple
computations or vizualitions, creating the reactive `plot_data()` object makes
a more efficient pipeline.
{:.notes}
