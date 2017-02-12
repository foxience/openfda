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

report <- dbGetQuery(con, "SELECT * FROM `report` WHERE id = '00000010-ec8e-11e6-aaaa-70b2e7692ca3'")
View(report)
patient <- dbGetQuery(con, "SELECT * FROM `patient` WHERE reportId = '00000010-ec8e-11e6-aaaa-70b2e7692ca3'")
View(patient)
reaction <- dbGetQuery(con, "SELECT * FROM `reaction` WHERE reportId = '00000010-ec8e-11e6-aaaa-70b2e7692ca3'")
View(reaction)
drug <- dbGetQuery(con, "SELECT * FROM `drug` WHERE reportId = '00000010-ec8e-11e6-aaaa-70b2e7692ca3'")
View(drug)

substanceQuery <- paste("SELECT * FROM `substance` WHERE drugId IN ('",
                        trimws(paste(drug$id, sep = "','")),
                        "')", sep = '')
substance <- dbGetQuery(con, substanceQuery)