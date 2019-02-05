# 1. About this package:
This package describes the workflow for downloading gene annotation data from [Gene Ontology Annotation](http://www.geneontology.org Gene Ontology Annotation) and how to annotate an example gene set and shows how to compute some database statistics [Ashburn, 2000] .

The package passes all checks without errors or warnings.
The structure of the package is as follows:


# 2. About Gene Ontology Annotation (GOA):
###   2.1  What is it?

Defining the function of a gene is more difficult than it might appear. Unlike with sequence and localization, there is no natural set fo terms used to define a gene's function. Gene Ontology is useful because it provides a common language with defined meaning to discuss gene function. This common language allows us to compare, categorize and collect gene functions. (Ashburn, 2000) [Source](http://steipe.biochemistry.utoronto.ca/abc/assets/BIN-FUNC-GO.pdf) 

###   2.2  Why is it useful?

Gene Ontology is useful because it provides a common language with defined meaning to discuss gene function. This common language allows us to compare, categorize and collect gene functions.


### 2.3 The Data
Gene Ontology contains "GO terms"- which describe biological functions of genes- as well as the
relationships between the. GO tesorms are the nodes in the gene ontology graph and are divided into three different categories: <br>
 * molecular function  - "has_a" <br>
 * cellular concepts - "is_a" <br>
 * biological process - "part_of" <br>
Gene Ontology Annotation (GOA) is part of GO's biocuration project which aims to associate the UniProt IDs of genes with their GO symbol annotation (Ashburn, 2000)
[Source] (http://steipe.biochemistry.utoronto.ca/abc/index.php/BIN-FUNC-GO)

Gene Ontology Annotation is a link between a gene and a GO term annotation. 
which describes its 
All Gene Ontology Annotations data is available under a CC-BY 4.0 license. This document is based on the version of GOA updated on 2018/04/11. 

### 2.4 Data Semantics:
<b>Ontology (OBO) Files contain GO terms.</b> <br>
Each term contains: <br>
<br>
1. unique identifier (i.e. 'GO Term') in format GO: 7-digit identifier<br>
2. namespace - one of the three sub-ontologies (molecular function, cellular components, biological processes)<br>
3. definition- description of what the specific GO term represents (and references) <br>
4.  relationship to other terms- whether it is a 'has_a', 'is_a','part_of' relationship to one or more other GO terms<br>

Gene Ontology Annotation (GAF) Files:
This package will be focus on genes in <i>Homo sapiens</i>.<br>
These files are tab-deliminated and have 17 fields of information <br> [Source](http://geneontology.org/page/go-annotation-file-gaf-format-21).<br>
<br>
<br>
The fields necessary for this package are:<br>
* The Database from which the object identifier is used <br>
* The UniProt identifier of an object <br>
* The <b> gene symbol </b> (i.e. HGNC gene symbol) <br>
* The <b> GO_ID </b> associated with the gene (i.e. <b> the GO term annotation </b>) <br>

Describe the function of genes using terms in Gene Ontology. Each GOA describes an association between a gene and a GO term. There are three different subcategories of gene ontologies. <br>
These annotations are derived from three sources of evidence which are represented by an Evidence Code for each GOA and either a reference or description of annotation <br>
[Source](http://geneontology.org/page/go-annotations ) : <br>
* Experimentally-supported annotations <b> (EXP) </b> <br> 
* Phylogenetically-inferred annotations <b> (IBA) </b> <br>
* Computationally-inferred annotations <b> (IEA) </b> <br>

## 3. Prerequisites
Install the package bcb420goa from the GitHub repository.
```{r}
library(bcb420goa)
```

## 4. Data Download
This package requires two datafiles to be stored in a subfolder data in your working directory :
You can download the files from the links provided. <br>
GO Annotation File: (http://geneontology.org/gene-associations/goa_human.gaf.gz) <br>
Ontology file: (http://purl.obolibrary.org/obo/go/go-basic.obo) <br>

Alternatively, you can call the following function which will download the files 
automatically and store them in the appropriate directory:
#```{r}
# #bcb420goa::download_default()
#```
Note: This function should only need to be called once the first time the package is used- as 
long as the files are not manually deleted.
```{r}
 human.gaf <- read.csv(file.path(getwd(),"data/goa_human.gaf.gz"),
                        header = FALSE,
                        sep = "\t",
                        comment.char = "!",  #skip the metadata rows
                        col.names = column.names )
  head(human.gaf)
```


## 5. Initialization
Once, we have downloaded the two files above in our local directory, we need to load, parse and 
join the two files. We store this in some randomly named dataframe. This only needs to be done
once each time you load the library.  E.g.
```{r}
 df<- bcb420goa::init()
 
```

## 6. Annotation

```{r}
  (result <- getGOAnnotation(c("BLOC1S1", "BLOC1S2", "BORCS5"), df))
  
```

## 7. Example Gene Set Annotation

```{r}
exampleGeneSet <- c("AMBRA1", "ATG14", "ATP2A1", "ATP2A2", "ATP2A3", "BECN1", "BECN2",
          "BIRC6", "BLOC1S1", "BLOC1S2", "BORCS5", "BORCS6", "BORCS7",
          "BORCS8", "CACNA1A", "CALCOCO2", "CTTN", "DCTN1", "EPG5", "GABARAP",
          "GABARAPL1", "GABARAPL2", "HDAC6", "HSPB8", "INPP5E", "IRGM",
          "KXD1", "LAMP1", "LAMP2", "LAMP3", "LAMP5", "MAP1LC3A", "MAP1LC3B",
          "MAP1LC3C", "MGRN1", "MYO1C", "MYO6", "NAPA", "NSF", "OPTN",
          "OSBPL1A", "PI4K2A", "PIK3C3", "PLEKHM1", "PSEN1", "RAB20", "RAB21",
          "RAB29", "RAB34", "RAB39A", "RAB7A", "RAB7B", "RPTOR", "RUBCN",
          "RUBCNL", "SNAP29", "SNAP47", "SNAPIN", "SPG11", "STX17", "STX6",
          "SYT7", "TARDBP", "TFEB", "TGM2", "TIFA", "TMEM175", "TOM1",
          "TPCN1", "TPCN2", "TPPP", "TXNIP", "UVRAG", "VAMP3", "VAMP7",
          "VAMP8", "VAPA", "VPS11", "VPS16", "VPS18", "VPS33A", "VPS39",
          "VPS41", "VTI1B", "YKT6")
(res<- getGOAnnotation(exampleGeneSet, df))

```

## 8. Statistics

## 9. Sources
Example and template for use of rpt package was taken from 
[rpt package](https://github.com/hyginn/rpt). <br>
Gene Ontology Annotation Data taken from [Gene Ontology Annotation](http://geneontology.org/page/download-go-annotations)<br>
Ontology Annotation Data taken from [Ontology](http://purl.obolibrary.org/obo/go.obo)<br>
Wickham,H., et al. 2018. Package 'dplyr'. (https://dplyr.tidyverse.org)<br>
Greene, D., et al. 2019. Package 'OntologyIndex'.(https://cran.r-project.org/web/packages/ontologyIndex/ontologyIndex.pdf)<br>
Wickham,H., et al. 2018. Package 'readr'.
(https://cran.r-project.org/web/packages/readr/readr.pdf)<br>
Ashburner et al. Gene ontology: tool for the unification of biology (2000) Nat Genet 25(1):25-9. Online at Nature Genetics.<br>
GO Consortium, Nucleic Acids Res., 2017 <br>
http://geneontology.org/page/ontology-documentation <br>
http://geneontology.org/page/go-annotations <br>
http://steipe.biochemistry.utoronto.ca/abc/assets/BIN-FUNC-GO.pdf <br>

