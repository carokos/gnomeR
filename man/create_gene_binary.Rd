% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create-gene-binary.R
\name{create_gene_binary}
\alias{create_gene_binary}
\title{Enables creation of a binary matrix from a mutation, fusion or CNA file with
a predefined list of samples (rows are samples and columns are genes)}
\usage{
create_gene_binary(
  samples = NULL,
  mutation = NULL,
  mut_type = c("omit_germline", "somatic_only", "germline_only", "all"),
  snp_only = FALSE,
  include_silent = FALSE,
  fusion = NULL,
  cna = NULL,
  high_level_cna_only = FALSE,
  specify_panel = "no",
  recode_aliases = TRUE
)
}
\arguments{
\item{samples}{a character vector specifying which samples should be included in the resulting data frame.
Default is NULL is which case all samples with an alteration in the mutation, cna or fusions file will be used. If you specify
a vector of samples that contain samples not in any of the passed genomic data frames, 0's (or NAs when appropriate if specifying a panel) will be
returned for every column of that patient row.}

\item{mutation}{A data frame of mutations in the format of a maf file.}

\item{mut_type}{The mutation type to be used. Options are "omit_germline", "somatic_only", "germline_only" or "all". Note "all" will
keep all mutations regardless of status (not recommended). Default is omit_germline which includes all somatic mutations, as well as any unknown mutation types (most of which are usually somatic)}

\item{snp_only}{Boolean to rather the genetics events to be kept only to be SNPs (insertions and deletions will be removed).
Default is FALSE.}

\item{include_silent}{Boolean to keep or remove all silent mutations. TRUE keeps, FALSE removes. Default is FALSE.}

\item{fusion}{A data frame of fusions. If not NULL the outcome will be added to the matrix with columns ending in ".fus".
Default is NULL.}

\item{cna}{A data frame of copy number alterations. If inputed the outcome will be added to the matrix with columns ending in ".del" and ".amp".
Default is NULL.}

\item{high_level_cna_only}{If TRUE, only deep deletions (-2, -1.5) or high level amplifications (2) will be counted as events
in the binary matrix. Gains (1) and losses (1) will be ignored. Default is \code{FALSE} where all CNA events are counted.}

\item{specify_panel}{a character vector of length 1 with panel id (see gnomeR::gene_panels for available panels), "impact", or "no". Alternatively,
you may pass a data frame of \code{sample_id}-\code{panel_id} pairs specifying panels for each sample for which to insert NAs indicating genes not tested. See below for details.}

\item{recode_aliases}{boolean specifying if automated gene name alias matching should be done. Default is TRUE. When TRUE
the function will check for genes that may have more than 1 name in your data using the aliases im gnomeR::impact_alias_table alias column}
}
\value{
a data frame with sample_id and alteration binary columns with values of 0/1
}
\description{
Enables creation of a binary matrix from a mutation, fusion or CNA file with
a predefined list of samples (rows are samples and columns are genes)
}
\section{specify_panel argument}{

\itemize{
\item If a single panel id is passed (e.g. \code{specify_panel = "IMPACT468"}), all genes in your data that are not tested on that panel will be set to
\code{NA} in results for all samples (see gnomeR::gene_panels to see which genes are on each supported panels).
\item If \code{specify_panel = "impact"} is passed, impact panel version will be inferred based on each sample_id (based on \code{IMX} nomenclature) and NA's will be
annotated accordingly for each sample/panel pair.
\item If \code{specify_panel = "no"} is passed (default) data will be returned as is without any additional NA annotations.
\item If you wish to specify different panels for each sample, pass a data frame (with all samples included) with columns: \code{sample_id}, and \code{panel_id}. Each sample will be
annotated with NAs according to that specific panel. If a sample in your data is missing from the \code{sample_id} column in the
\code{specify_panel} dataframe, it will be returned with no annotation (equivalent of setting it to "no").
}
}

\examples{
mut.only <- create_gene_binary(mutation = gnomeR::mutations)

samples <- gnomeR::mutations$sampleId

bin.mut <- create_gene_binary(
  samples = samples, mutation = gnomeR::mutations,
  mut_type = "omit_germline", snp_only = FALSE,
  include_silent = FALSE
)

}
