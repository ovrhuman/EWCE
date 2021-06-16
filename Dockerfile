# rstudio has the latest version of R
#   has R, RStudio, tidyverse, devtools, tex, and publishing-related packages
FROM rocker/rstudio

# required
MAINTAINER Nathan Skene <nskene@imperial.ac.uk>, Alan Murphy <a.murphy@imperial.ac.uk>

# copy the repo contents into the docker image at `/ewce`
COPY . /ewce

RUN apt-get update &&\
    apt-get install -y --no-install-recommends\
    libxml2-dev libcurl4-openssl-dev libssl-dev\
    libssh2-1-dev

# install R package binaries for dependencies
RUN install2.r -e \
ggplot2 \
stringr \
cowplot \
ggdendro \
future \
knitr \
rmarkdown \
testthat \
data.table \
devtools


# install the package with remaining dependencies installing too
RUN R -e "devtools::install_github('nathanskene/ewce',quiet=TRUE)"
