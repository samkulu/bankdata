#' Write PDF Text
#'
#'
#'
#' @param fls
#' @param dest
#' @param subfolder
#'
#' @return
#' @export
#'
#' @examples
write_pdf_txt <- function(fls, dest, subfolder = "RSearch/pdftxt"){
  # Process only files in path
  stopifnot(all(substring(fls, 1, nchar(dest)) == dest))


  # Files in subfolder
  childs <- substring(fls,nchar(dest) + 1)

  dest2 <- file.path(dest, subfolder, childs)
  dest2 <- gsub("\\\\","\\/",dest2)
  dest2 <- gsub("\\/\\/","\\/",dest2)
  dest2 <- gsub(".pdf$", " [pdf]", dest2)

  num <- length(fls)


  # Process files
  result <- list()
  for(i in 1:length(fls)){
    # Show file progress
    message(basename(fls[i]))

    ### BEGIN from getting Text
    txt <- pdf_txt(fls[i])
    ### END

    N <- length(txt)
    result[[i]] <- txt

    # Filenames
    p <- gsub("%N%", nchar(N), "page_%0%N%d.txt")
    pages <- sprintf(p,1:N)
    pages <- file.path(dest2[i],pages)

    sapply(1:N, function(x) write_txt(pages[x], txt[x]))
  }


  # Return
  result
}