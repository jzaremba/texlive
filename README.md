# texlive
Docker files for building texlive image

Includes a user layer on top of the base image so that created files are not owned by root.

Build with `build.sh`.

See the example Makefile for detailed example of how to run the image.

In general:

`docker run -it --rm -e "USER=$(shell id -un)" -e "USER_ID=$(shell id -u)" -e "GROUP_ID=$(shell id -g)" -v "$(shell pwd):/opt/workdir" -v "FIGURE_PATH:/figures" texlive xelatex FILE.tex`
