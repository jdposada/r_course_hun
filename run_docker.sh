#!/bin/bash

docker run -d --net=host -e ROOT=TRUE -e USER=rstudio -e PASSWORD=ohdsi  --restart always -v C:\Users\jdpos\Documents\github_repos\r_course\src:/home/rstudio rocker/verse:4.2
