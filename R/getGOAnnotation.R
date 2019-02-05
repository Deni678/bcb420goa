#' getGOAnnotation
#'
#' \code{<function>} description.
#'
#' Details.
#' @section <title>: Additional explanation.
#'
#' @param <p> <description>.
#' @param <q> <description>.
#' @return <description>.
#'
#' @family <optional description of family>
#'
#' @author \href{https://orcid.org/0000-0002-1134-6758}{Boris Steipe} (aut)
#'
#' @seealso \code{\link{<function>}} <describe related function>, ... .
#'
#' @examples
#' # <explain what the example does>
#' myFunction(1i, 1i)
#'
#' @export
getGOAnnotation <- function(list.of.genes, annotated.ontology) {

  for (gene in list.of.genes) {
    if (gene %in% annotated.ontology$DB_Object_Symbol) {
      cat(sprintf("\t%s\n", gene))
      }
    else {
      cat(sprintf("\tUnknown gene:\t%s", gene))}
  }

  v_DB_Object_Symbol <-
    annotated.ontology[annotated.ontology$DB_Object_Symbol %in% list.of.genes,
                       "DB_Object_Symbol"]

  v_DB_Object_Symbol <-
    lapply(v_DB_Object_Symbol, as.character)

  ontology.names <-
    annotated.ontology[annotated.ontology$DB_Object_Symbol %in% list.of.genes,
                       "ontology.name"]

  ontology.names <-
    lapply(ontology.names, as.character)

  rows <- length(list.of.genes)
  cols <- length(unique(ontology.names))

  M <- matrix(nrow = rows, ncol = cols)
  colnames(M) <- unique(ontology.names)
  rownames(M) <- list.of.genes
  for (i in 1:length(v_DB_Object_Symbol)) {
    M[as.character(v_DB_Object_Symbol[i]), as.character(ontology.names[i])] = "y"
  }
  return(M)
}

