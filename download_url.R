
library(tidyverse)
library(here)
library(glue)
# library(gdata)
library(readxl)
# library(RSelenium)


# Content Disposition Attachmente
url <- 
  glue("https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?CodCuadro=1317&Idioma=1&FecInicial=2001/12/31&FecFinal=2020/06/30&Filtro=0&Exportar=True")

# download using shell code
system(glue('wget --content-disposition "{url}"'))


