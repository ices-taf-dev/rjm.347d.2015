#' Run TAF Analysis
#'
#' Run entire TAF analysis, both bootstrap procedure and scripts.
#'
#' @param force whether to remove existing directory.
#'
#' @note
#' This function creates a new working directory with the same name as the
#' package, before running the bootstrap procedure (\code{taf.bootstrap}) and
#' TAF scripts (\code{sourceAll}).
#'
#' @seealso
#' \code{\link[icesTAF]{taf.bootstrap}} sets up data files and software.
#'
#' \code{\link[icesTAF]{sourceAll}} runs all TAF scripts.
#'
#' \code{\link[icesTAF]{icesTAF-package}} gives an overview of the icesTAF
#' package.
#'
#' @importFrom icesTAF cp mkdir sourceAll taf.bootstrap
#' @importFrom utils packageName
#'
#' @examples
#' \dontrun{
#' run()
#' }
#'
#' @export

run <- function(force=FALSE)
{
  ## Get package name
  pkg <- packageName()

  ## Create new working directory, copy TAF analysis from package
  if(dir.exists(pkg) & !force)
    stop("directory ", pkg, " exists")
  unlink(pkg, recursive=TRUE)
  mkdir(pkg)
  cp(file.path(system.file(package=pkg), "taf/*"), pkg)
  owd <- setwd(pkg); on.exit(setwd(owd))

  ## Run analysis
  taf.bootstrap()
  sourceAll()
}
