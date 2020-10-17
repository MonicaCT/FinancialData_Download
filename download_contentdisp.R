
library(tidyverse)
library(here)
library(glue)
library(readxl)

# Costa Rica ----
# Content Disposition Attachment
url <- 
  glue("https://gee.bccr.fi.cr/indicadoreseconomicos/Cuadros/frmVerCatCuadro.aspx?CodCuadro=1317&Idioma=1&FecInicial=2001/12/31&FecFinal=2020/05/30&Filtro=0&Exportar=True")

# download using shell code
system(glue('wget --content-disposition "{url}"'))

# Note: xls file is old, Excel has problems opening it. But GS doesn't.

# All urls ----
# http://www.cmfchile.cl/portal/estadisticas/606/w3-propertyname-733.html
# https://www.superfinanciera.gov.co/inicio/informes-y-cifras/cifras/establecimientos-de-credito/informacion-periodica/mensual/evolucion-cartera-de-creditos-60950
# https://ssf.gob.sv/cartera-de-prestamos/
#   https://www.sib.gob.gt/ConsultaDinamica/?cons=26<
#   https://publicaciones.cnbs.gob.hn/boletines/_layouts/15/xlviewer.aspx?id=/boletines/Estados%20Financieros%20NIIF%20a%20partir%20de%20enero%202017/Estados%20Financieros.xlsx&Source=https%3A%2F%2Fpublicaciones%2Ecnbs%2Egob%2Ehn%2Fboletines%2FPaginas%2FEstados%2DFinancieros%2DNIIF%2D%28a%2Dpartir%2Dde%2Denero%2D2017%29%2Easpx
# https://portafolioinfo.cnbv.gob.mx/Paginas/Inicio.aspx#
# https://www.bcn.gob.ni/estadisticas/monetario_financiero/financiero/sociedades_financieras/index.php

