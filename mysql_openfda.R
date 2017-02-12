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
reports <- dbGetQuery(con, "SELECT * FROM `report` limit 10")

print(reports)
View(reports)

report <- dbGetQuery(con, "SELECT * FROM `report` WHERE id='00000010-ec8e-11e6-aaaa-70b2e7692ca3'")
View(report)