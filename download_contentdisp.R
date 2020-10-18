
library(tidyverse)
library(here)
library(glue)
library(readxl)

# Costa Rica ----
# Content Disposition Attachment
url <- 
  glue("https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?CodCuadro=1317&Idioma=1&FecInicial=2001/12/31&FecFinal=2020/05/30&Filtro=0&Exportar=True")

# download using shell code
exists_dir <- 
  list.dirs(path = here::here()) %>% 
  str_detect('data_costarica') %>% 
  sum %>% {.>0}
if(!exists_dir){system('mkdir data_costarica')}
path_data <- glue("{here::here()}/data_costarica")
system(glue('wget --content-disposition "{url}" -P {path_data}'))

# Note: xls file is old, Excel has problems opening it. But GS doesn't.

