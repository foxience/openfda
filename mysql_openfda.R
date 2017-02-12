# Load RMySQL package
library(DBI)
library(stringr)
library(RMySQL)

# Connect to the database
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "openfda",
                 host = "foxience.org",
                 port = 3306,
                 user = "foxience",
                 password = "OXg2JHaY")

# set encoding for connection
dbGetQuery(con, 'SET NAMES utf8')

# Create the data frame properties
properties <- dbGetQuery(con, "SELECT * FROM `report` limit 10")

print(properties)
View(properties)