#!/bin/bash

docker run -d -p 8787:8787 -e ROOT=TRUE -e USER=rstudio -e PASSWORD=rstudio -v C:\Users\jdpos\Documents\github_repos\r_course:/home/rstudio rocker/verse:4.1
