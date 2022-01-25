# Working with Canadian open data

:maple_leaf::bar_chart: Acquire, clean, and explore Canadian open data.

A fork of [iamdavecampbell/data-set-acquisition](https://github.com/iamdavecampbell/data-set-acquisition).

---

The rendered files can be viewed [here](https://adamoshen.github.io/canadian-open-data/).

The RMarkdown files are first knitted to html, then passed to the `downlit`
highlighter in `R/downlit_html_path2.R` for accessible syntax highlighting and
linking of functions to their respective documentations.

The packages required to knit the included RMarkdown files include:

- `rmarkdown`
- `knitr` 1.16+
- `svglite`
- any other packages specified in the individual files

The packages required to run `R/downlit_html_path2.R` include:

- `downlit`
- `withr`

To reduce knit time, code chunks for downloading and unzipping data currently
have `eval` set to `FALSE`. Before knitting the RMarkdown files, you should
run these chunks first to ensure that you have local copies of the data.
