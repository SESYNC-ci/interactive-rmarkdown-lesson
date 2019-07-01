---
---

## Markdown Syntax

Before getting to the good stuff, a quick introduction to "dumb" Markdown
formatting.

===

## Text

Text fenced by "\*" is translated by the Markdown interpreter into italics. This
is just one example of formating text according to this *light-weight*
syntax, i.e. the document is still readable as plain text.

===

## Preformatted Text

Text fenced by "\`\`\`" is left untouched by the Markdown interpreter, usually
for the purpose of displaying code. Everything else is formatted according to
a light-weight syntax.

```
The *emphasis* indicated by asterisks here does not become
italicized, as it would outside a "code fence".
```

That's three backtick characters, found next to the "1" on QWERTY keyboards,
above and below the text.
{:.notes}

===

## Bulleted Lists

Sequential lines beginning with "-" are grouped into a bulleted list. The
following preformatted text shows the syntax.

```
- SQL
- Python
- R
```

Without a code fence (which is not present in your worksheet), the chunk of text
above will be rendered as a bulleted list. All the sections with
"(preformatted)" in the online lesson are paired with a section in your
worksheet for you to complete and then `knit`.
{:.notes}

===

## Numbered Lists

Sequential lines beginning with a number are grouped into a numbered list.
The actual number you use is irrelevant.

```
6. SQL
1. Python
5. R
```

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

===

## Configuration

Text at the top of a Markdown file and fenced by `---` stores configuration.
Variables set here can, for example, change the type of document produced.

```
---
output: html_document
---
```

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
