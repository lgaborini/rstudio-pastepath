# pastepath

<!-- badges: start -->

[![R-CMD-check](https://github.com/lgaborini/rstudio-pastepath/workflows/R-CMD-check/badge.svg)](https://github.com/lgaborini/rstudio-pastepath/actions)

<!-- badges: end -->

The goal of {pastepath} is to let Windows users copy-paste a path in RStudio (e.g. from Explorer), automatically dealing with the backslashes/quotes.

-   Backslashes `\` are always converted to `/`
-   Double quotes are added, if necessary

## Examples

-   `C:\Users\MyUser\my project` becomes `"C:/Users/MyUser/my project"`  
   `"C:\Users\MyUser\my project"` becomes `"C:/Users/MyUser/my project"`  
   `'C:\Users\MyUser\my project'` becomes `'C:/Users/MyUser/my project'`  

-   Relative paths:  
    `data\cache` becomes `"data/cache"`

## Installation

You can install the addin from this GitHub:

``` {.r}
remotes::install_github("lgaborini/rstudio-pastepath")
```

## Usage

The addin provides two commands:

-   "Paste path as character vector" (default usage)  
    Useful for paths containing spaces, the clipboard contents are escaped, then surrounded by `"` (unless already wrapped in `"` or `'`).  
    Note: it works also for text data to quickly create a character vector.  
-   "Paste path without quotes"  
   As before, but it skips the wrapping.
   
**Protip**: assign a keyboard shortcut to one of these commands (e.g. `ctrl+shift+V`)!
