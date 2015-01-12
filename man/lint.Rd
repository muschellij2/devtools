% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/lint.r
\name{lint}
\alias{lint}
\title{Lint all source files in a package.}
\usage{
lint(pkg = ".", ...)
}
\arguments{
\item{pkg}{package description, can be path or package name. See
\code{\link{as.package}} for more information}

\item{...}{additional arguments passed to \code{\link[lintr]{lint_package}}}
}
\description{
The default lintings correspond to the style guide at
\url{http://r-pkgs.had.co.nz/r.html#style}, however it is possible to
override any or all of them using the \code{linters} parameter.
}
\seealso{
\code{\link[lintr]{lint_package}}, \code{\link[lintr]{lint}}
}
