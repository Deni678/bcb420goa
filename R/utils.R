#utils.R
#
#' Helper function - downloads the required data files

download_default <- function() {
  wd <- getwd()
  data.dir <- file.path(wd,"data")
  ifelse(!dir.exists(data.dir), dir.create(data.dir), FALSE)
  cat(sprintf("Files will be downloaded into:%s\n", data.dir))
  download.file(
    url = goa.human.deafult.url,
    destfile = file.path(data.dir,human.gaf.filename)
  )
  download.file(
    url = ontology.filename.default.url,
    destfile = file.path(data.dir,ontology.filename)
  )
  cat(sprintf("\tGOA file:%s\t(size:%s)\n\tOntology:%s\t(size:%s)",
              file.path(data.dir,human.gaf.filename),
              file.size(file.path(data.dir,human.gaf.filename)),
              file.path(data.dir,ontology.filename),
              file.size(file.path(data.dir,ontology.filename))
  ))
}
