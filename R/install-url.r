#' Install a package from a url
#'
#' This function is vectorised so you can install multiple packages in
#' a single command.
#'
#' @param url location of package on internet. The url should point to a
#'   zip file, a tar file or a bzipped/gzipped tar file.
#' @param subdir subdirectory within url bundle that contains the R package.
#' @param config additional configuration argument (e.g. proxy,
#'   authentication) passed on to \code{\link[httr]{GET}}.
#' @param ... Other arguments passed on to \code{\link{install.packages}}.
#' @param quiet if \code{TRUE} suppresses output from this function.
#' @export
#' @family package installation
#' @examples
#' \dontrun{
#' install_url("https://github.com/hadley/stringr/archive/master.zip")
#' }
install_url <- function(url, subdir = NULL, config = list(), ..., quiet = FALSE) {
  remotes <- lapply(url, url_remote, subdir = subdir, config = config)
  install_remotes(remotes, ..., quiet = quiet)
}

url_remote <- function(url, subdir = NULL, config = list()) {

  if (file_ext(url) == "zip" || file_ext(url) == "tgz") {
    pkg_type = "binary"
  } else {
    pkg_type = "source"
  }

  remote("url",
    url = url,
    subdir = subdir,
    config = config,
    pkg_type = pkg_type
  )
}

#' @export
remote_download.url_remote <- function(x, quiet = FALSE) {
  if (!quiet) {
    message("Downloading package from url: ", x$url)
  }

  bundle <- file.path(tempdir(), basename(x$url))
  download(bundle, x$url, x$config)
}

#' @export
remote_metadata.url_remote <- function(x, bundle = NULL, source = NULL) {
  list(
    RemoteType = "url",
    RemoteUrl = x$url,
    RemoteSubdir = x$subdir,
    RemotePkgType = x$pkg_type
  )
}

#' @export
remote_package_info.url_remote <- function(remote, ...) {
  list(Package = NA_character_,
       version = NA_character_)
}

#' @export
remote_package_name.url_remote <- function(remote, ...) {
  res <- remote_package_info(remote, ...)
  res$Package
}

#' @export
remote_sha.url_remote <- function(remote, ...) {
  NA_character_
}

#' @export
format.url_remote <- function(x, ...) {
  "URL"
}
