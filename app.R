#
#   shinyBS not detected by renv (in fact) when added in dependencies only
#   this is for renv to work only
#
library(shinyBS)

# does not work
requireNamespace("shinyBS")
shinyBS:::.onAttach()

rhino::app()
