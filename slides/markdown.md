---
---

## Markdown Syntax

Before getting to the good stuff, a quick introduction to "dumb" Markdown
formatting.

===

## Text and Emphasis

Text in Markdown is rendered as is, albeit in some pre-defined size and font,
into an HTML file by default. Text fenced by "\*" is translated by the Markdown
interpreter into italics for emphasis.
{:.notes}

Adding emphasis is an example of "marking up" plain text with a *light-weight*
syntax, i.e. the code is readable before being rendered into a document.

===

## Bulleted Lists

Sequential lines beginning with "-" are grouped into a bulleted list.

```
- SQL
- Python
- R
```
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Numbered Lists

Sequential lines beginning with a number are grouped into a numbered list.
The actual number you use is irrelevant.

```
6. SQL
1. Python
5. R
```
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Tables

Separate text with vertical bars (`|`) to indicate columns of a table and
hyphens (`-`) to mark the beginning of a table or to separate the header row.

```
id | treatment
---|----------
1  | control
2  | exclosure
```
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Configuration

Text at the top of a Markdown file and fenced by `---` stores configuration.
Variables set here can, for example, change the type of document produced.

```
---
output: html_document
---
```
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

Change the output variable to `ioslides_presentation` and knit again to generate
output formatted as a slideshow.

===

## Headers

Default formatting for an `html_document` differs in some cases from an
`ioslides_presentation`. The use of `#` to indicate a hierarchy of heading sizes
serves an additional purpose in a slideshow.

```
# The Biggest Heading

## The Second Biggest Heading

### The Third Biggest Heading
```
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

===

## Preformatted Text

Text fenced by either one or three "backticks" (the "\`" character) is left
untouched by the Markdown interpreter, usually for the purpose of displaying
code. Everything else is formatted according to a light-weight syntax.

````
```
The *emphasis* indicated by asterisks here does not become
italicized, as it would outside a "code fence".
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}

That's three backtick characters, found next to the "1" on QWERTY keyboards,
above and below the text. A single backtick leave's code "inline", while three
(or more) backticks indicate a separate block of preformatted text or a
"chunk".
{:.notes}

===

You can write R code in a chunk, but it's still just "dumb" Markdown.

````
```
seq(1, 10)
```
````
{:.text-document title="{{ site.data.lesson.handouts[0] }}"}
