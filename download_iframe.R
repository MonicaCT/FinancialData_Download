
# date: 2020-10
# author: @songeo

# iframes script 
# therefore, to extract content in an iframe, you need to find the link to the iframe HTML

# libraries
library(tidyverse)
library(here)
library(glue)
library(readxl)
# web scrapping libraries
library(httr)
library(rvest)


# 0. functions ----
#' Download .xlsx files  
#'
#' @param xlsx_name name of .xlsx file from webscrapping the main webpage
#' @param data_path data path to save files, default is working directory
#'
#' @return a nice 'Done!' message
download_xlsx <- 
  function(xlsx_url, head_url, data_path = '.'){
    url_download <- 
      glue("{head_url}{xlsx_url}")
    
    message(glue("downloading {url_download}"))
    # No check certificate
    system(glue('wget --no-check-certificate --user-agent="Mozilla" "{url_download}" -P {data_path}'))
    # system(glue('wget --no-check-certificate "{url_download}"'))
    
    return('Done!')
  }


# El Salvador ----
# 1. Searching url
# iframe url searching
main_url <- "https://ssf.gob.sv/cartera-de-prestamos/"
#extract source as hown in the image above
iframe_url <-  
  html_session(main_url) %>%
  html_nodes("#advanced_iframe") %>%
  html_attr("src")
iframe_url

# onclick function searching
iframe_url %>% 
  read_html() %>% 
  html_nodes('#Mostrar2') %>% 
  html_attr('onclick')



# Onclick ----
# onclick="return Mostrar2_onclick()"
# Mostrar2_onclick()
#' The onclick-attributes are added via javascript. 
#' Because of that you need a parser that executes the JS.
#' In R you can you RSelenium for that
#' 
# function JS onclick----
# function Mostrar2_onclick() {
#   var mes = document.f0.mes2.options[document.f0.mes2.selectedIndex].value
#   var ano = document.f0.ano2.options[document.f0.ano2.selectedIndex].value
#   var pref = 	document.f0.distr.options[document.f0.distr.selectedIndex].value
#   var dir = "/descargas/balances/xls/"
#   var ext = ".xls"
#   var archivo = dir + pref + evm(mes) + evy(ano) + ext
#   caract = "toolbar=no,location=no,directories=no,status=no,menuBar=yes,scrollBars=yes,resizable=yes,left=10,top=10,"
#   window.open(archivo, "_self", caract)
# }

# 2. iterative downloading file ----
exists_dir <- 
  list.dirs(path = here::here()) %>% 
  str_detect('data_elsalvador') %>% 
  sum %>% {.>0}
if(!exists_dir){system('mkdir data_elsalvador')}

download_xlsx(xlsx_url = "descargas/balances/xls/dg_sa_0720.xls",
              head_url = "https://ssf.gob.sv/",
              data_path = 'data_elsalvador')
    

# function JS onclick----
# <!--
#   function Mostrar1_onclick() {
#     var mes = document.f0.mes1.options[document.f0.mes1.selectedIndex].value
#     var ano = document.f0.ano1.options[document.f0.ano1.selectedIndex].value
#     var pref = 	document.f0.sector.options[document.f0.sector.selectedIndex].value
#     var dir = "/descargas/balances/xls/"
#     var ext = ".xls"
#     var archivo = dir + pref + evm(mes) + evy(ano) + ext
#     
#     caract = "toolbar=no,location=no,directories=no,status=no,menuBar=yes,scrollBars=yes,resizable=yes,left=10,top=10"
#     window.open(archivo, "_self", caract)
#   }
# 
# function JS onclick----
# function Mostrar2_onclick() {
#   var mes = document.f0.mes2.options[document.f0.mes2.selectedIndex].value
#   var ano = document.f0.ano2.options[document.f0.ano2.selectedIndex].value
#   var pref = 	document.f0.distr.options[document.f0.distr.selectedIndex].value
#   var dir = "/descargas/balances/xls/"
#   var ext = ".xls"
#   var archivo = dir + pref + evm(mes) + evy(ano) + ext
#   caract = "toolbar=no,location=no,directories=no,status=no,menuBar=yes,scrollBars=yes,resizable=yes,left=10,top=10,"
#   window.open(archivo, "_self", caract)
# }
# 
# 
# 
# function evm(s)
# {
#   if(s < 10) {
#     m = "0" + s
#     return m
#   }
#   else
#     return s
# }
# 
# function evy(s)
# {
#   if(s.length > 2)
#     s = s.substr(2, 4)
#   
#   return s	
# }
# //-->
#   



{
# testing
my_url <- "https://scrapethissite.com/pages/frames/"
#extract source as hown in the image above
iframe_src <-  
  html_session(my_url) %>%
  html_node("#iframe") %>%
  html_attr("src")
#get the url to that iframe
iframe_url <- str_c("https://scrapethissite.com",iframe_src)
#extract turtle names:
turtle_names <- html_session(iframe_url) %>%
  html_nodes(".family-name") %>%
  html_text()
print(turtle_names)
}