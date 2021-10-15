# `input_html`: Path to html file that requires downlit parsing. Assumes that source Rmd file is in
# same location. Not vectorised over `input_html`.
# `output_html`: Path to write output html file.

# `downlit::downlit_html_path` will find all packages (attached or not), but fails to identify the
# core component packages of package collections such as tidyverse and tidymodels for individual
# html files.

downlit_html_path2 <- function(input_html, output_html) {
  require(downlit)
  require(withr)

  if (missing(input_html) | missing(output_html)) {
    stop("Values for both `input_html` and `output_html` must be supplied.")
  }

  path_to_rmd <- paste0(
    dirname(input_html),
    "/",
    gsub(pattern="\\.html", replacement=".Rmd", x=basename(input_html))
  )

  source_code <- readLines(path_to_rmd)
  package_collections <- character(0)

  if (any(grepl(pattern="library\\(tidyverse\\)|require\\(tidyverse\\)", x=source_code))) {
    package_collections <- append(package_collections, "tidyverse")
  }

  if (any(grepl(pattern="library\\(tidymodels\\)|require\\(tidymodels\\)", x=source_code))) {
    package_collections <- append(package_collections, "tidymodels")
  }

  if (length(package_collections) == 0) {
    downlit_html_path(input_html, output_html)
  } else {
    core_packages <- mapply(getNamespace, package_collections, SIMPLIFY=FALSE)
    core_packages <- mapply(getElement, core_packages, name="core", SIMPLIFY=FALSE)
    core_packages <- Reduce(union, core_packages)

    with_options(
      list(downlit.attached = core_packages),
      downlit_html_path(input_html, output_html)
    )
  }
}
