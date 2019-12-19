### Functions that I pull into .Rprofile via:

### source("https://github.com/VCF/generalUtilities/raw/master/R_profile_utils.R")

makec <- function(x, quiet=FALSE, newline=TRUE) {
    ## Write out R code to represent a vector - "make c()"
    ## Used as a utility to help write tests
    fmt1 <- ifelse(is.character(x), '"%s"', '%s')
    fmt2 <- ifelse(length(x) == 1, "%s", "c(%s)")
    if (newline) fmt2 <- paste0(fmt2, "\n")
    rv <- sprintf(fmt2, paste(ifelse(is.na(x), 'NA', sprintf(fmt1, x)),
                              collapse=", "))
    if (!quiet) cat(rv)
    invisible(rv)
}

makel <- function(x, pretty=TRUE) {
    ## Write out R code to represent a list - "make list()"
    ## Used as a utility to help write tests
    bits <- vapply(names(x), function(n)
        sprintf("'%s'=%s", n, makec(x[[n]],TRUE, FALSE)), "")
    rv <- paste0("list(",
                 paste0(bits, collapse=ifelse(pretty,",\n     ", ", ")), ")\n")
    cat(rv)
    invisible(rv)
}

bacAM <- function() {
    ## There's something weird about RefClass inheritance, such that
    ## after I build the AnnotatedMatrix package, R fails to properly
    ## unload the inherited packages. So manually unload them before
    ## running buildAndCheck()
    ln <- loadedNamespaces()
    ul <- character()

    nsList     <- c("SetFisherAnalysis", "SetFisher", "AnnotatedMatrix",
                    "ParamSetI", "EventLogger")
    lastTried  <- ""
    iterations <- 0
    maxIter    <- 2 + sum(seq_len(length(nsList)))
    while (length(nsList) != 0) {
        ns <- nsList[1]
        if (lastTried == ns) {
            ## Will catch a list of only one namespace that can't be
            ## unloaded
            warning("Failed to remove ",ns, " from environment")
            break
        }
        iterations <- iterations + 1
        if (iterations > maxIter) {
            warning("Possible infinite recursion attempting to remove:\n",
                    paste(nsList, collapse=', '))
            break

        }
        lastTried <- ns
        nsList    <- nsList[-1]
        if (is.element(ns, ln)) {
            tryCatch({
                unloadNamespace(ns)
            }, error = function(e) {
                ## Try putting the namespace later in the
                ## list. Perhaps there is a following namespace that
                ## is depending on it? If so, attempting removal later
                ## should work.
                nsList <- c(nsList, ns)
            }, finally = {
                ## Note that we unloaded the namespace
                ul <- c(ul, ns)
            })
        }
    }
    if (length(ul) != 0) message("Force unloaded: ", paste(ul, collapse=', '))
    myRepository::buildAndCheck()
    
    ## If I don't do this, I get an inheritance-based hierarchy of
    ## errors on all subsequent attempts to build the package:

    ## Updating AnnotatedMatrix documentation
    ## Loading AnnotatedMatrix
    ## Error in setIs(class2, cli, extensionObject = obji, doComplete = FALSE,  : 
    ##   class “EventLogger” has no visible definition from package or environment ‘AnnotatedMatrix’
    ## Error in setIs(class2, cli, extensionObject = obji, doComplete = FALSE,  : 
    ##   class “EventLogger” has no visible definition from package or environment ‘AnnotatedMatrix’
    ## Error in setClass(Class, oldDef, where = where) : 
    ##   error in contained classes ("ParamSetI") for class “AnnotatedMatrix”; class definition removed from ‘AnnotatedMatrix’
    ## Error in setClass(Class, contains = superClasses, where = where, ...) : 
    ##   error in contained classes ("ParamSetI") for class “AnnotatedMatrix” and unable to restore previous definition from ‘AnnotatedMatrix’

}
