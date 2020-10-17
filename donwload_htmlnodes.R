

# Colombia ----

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
  function(xlsx_url, data_path = '.'){
    url_download <- 
      glue("https://www.superfinanciera.gov.co{xlsx_url}")
    
    message(glue("downloading {url_download}"))
    # No check certificate
    system(glue('wget --no-check-certificate "{url_download}" -P {data_path}'))
    # system(glue('wget --no-check-certificate "{url_download}"'))
    
    return('Done!')
  }

# 1. main url to search ----
main_url <- "https://www.superfinanciera.gov.co/inicio/informes-y-cifras/cifras/establecimientos-de-credito/informacion-periodica/mensual/evolucion-cartera-de-creditos-60950"

# 2. searching urls to download ----
html_url <- 
  main_url %>% 
  read_html()
xlsx_urls <- 
  html_nodes(main_url %>% 
               read_html(), 
             css = "ul, a") %>% 
  html_attr('href') %>% 
  str_subset('.xlsx') %>% 
  str_subset('/ca')
xlsx_urls %>% length()


# 3. iterative downloading file
exists_dir <- 
  list.dirs(path = here::here()) %>% 
  str_detect('data_colombia') %>% 
  sum %>% {.>0}
if(!exists_dir){system('mkdir data_colombia')}
map(xlsx_urls[1],
    download_xlsx,
    data_path = glue("{here::here()}/data_colombia"))

# https://www.superfinanciera.gov.co/descargas/institucional/pubFile1048244/ca072020.xlsx

# 4. reading .xlsx file
xlsx_files <- 
  list.files("data_colombia", full.names = T)

file_path <- xlsx_files[1]
list_download <- 
  map(readxl::excel_sheets(path = glue("{here::here()}/{file_path}")), 
      function(sh){
        read_xlsx(glue("{here::here()}/{file_path}"), sheet = sh)      
        })
list_download
