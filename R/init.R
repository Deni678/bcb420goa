.onLoad <- function(libname, pkgname) {
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    install.packages("dplyr")
  }
  if (!requireNamespace("readr", quietly = TRUE)) {
    install.packages("readr")
  }
  if (!requireNamespace("ontologyIndex", quietly = TRUE)) {
    install.packages("ontologyIndex")
  }
  library(ontologyIndex)
  library(dplyr)
  library(readr)
  invisible()
}

.onAttach <- function(libname, pkgname) {

  m <- c(sprintf("\nWelcome: this is the %s package.\n", pkgname),
         sprintf("Author(s):\n  %s\n",
                    utils::packageDescription(pkgname)$Author),
         sprintf("Maintainer:\n  %s\n",
                    utils::packageDescription(pkgname)$Maintainer),
         sprintf("\nThis package requires the following files in "),
         sprintf("getwd()/data '%s':\n\n",file.path(getwd(),"data")),
         sprintf("GO annotations for h.sapiens (default URL:%s)\n",
                        goa.human.deafult.url),
         sprintf("Ontology (default URL:%s)\n\n", ontology.filename.default.url),
         sprintf("You can call %s::download_default() to download the data.\n",
                        pkgname))

  packageStartupMessage(paste(m, collapse = ""))
}

init <- function() {
  data.dir <- file.path(getwd(),"data")
  if (!file.exists(file.path(data.dir,human.gaf.filename))) {
    stop(
      sprintf("File '%s' is required in '%s'. You can download it from '%s'.\n",
              human.gaf.filename, data.dir, goa.human.deafult.url))
  }

  if (!file.exists(file.path(data.dir,ontology.filename))) {
    stop(
      sprintf("File '%s' is required in '%s'. You can download it from '%s'.\n",
              ontology.filename, data.dir, ontology.filename.default.url))
  }

  cat(sprintf("Loading GO annotation file '%s'...", file.path(data.dir,human.gaf.filename)))
  human.gaf <- read.csv(file.path(data.dir,human.gaf.filename),
                        header = FALSE,
                        sep = "\t",
                        comment.char = "!",  #skip the metadata rows
                        col.names = column.names )

  human.gaf.records <- length(human.gaf$DB_Object_ID)

  human.gaf.unique.ids <- length(unique(human.gaf$DB_Object_ID))

  cat(sprintf("\nNumber of records in GOA human: %d. Unique genes: %d.",
          human.gaf.records,human.gaf.unique.ids))

  #  Ontology
  # ontologyIndex is a library that helps us read obo files
  cat(sprintf("\nLoading ontology from '%s'...",
              file.path(data.dir,ontology.filename)))
  # this may take ~1min
  ontology <- ontologyIndex::get_OBO(file.path(data.dir,ontology.filename),
                                     propagate_relationships = c("is_a",
                                                                 "regulates",
                                                                 "part_of",
                                                                 "negatively_regulates",
                                                                 "positively_regulates"),
                                     extract_tags = "minimal")

  cat(sprintf("\nNumber of records in ontology: %d.", nrow(ontology)))

  df <- data.frame(ontology$id, ontology$name)

  cat("\njoining annotated data with ontology...")
  db <- dplyr::inner_join(human.gaf, df, by = c("GO_ID" = "ontology.id"))

  cat(sprintf("\nNumber of annotations with ontologies: %d.\n", nrow(db)))

  return(db)
}

version <- function() {
  source("dev/toBrowser.R")
  toBrowser()
}

tree <- function() {
  source("dev/rptTwee.R")
  rptTwee()
}

