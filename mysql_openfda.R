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

# Query all reports from database
reports <- dbGetQuery(con, "SELECT * FROM `report` limit 10")
# View(reports)

getReport <- function (connection, reportId) {
  # Query a specific report based on report id
  report <- dbGetQuery(connection, paste0("SELECT * FROM `patient`
                       WHERE reportId = '", as.character(reportId),  "'"))
  # View(report)
  
  # Query patient info belong to a specific report
  patient <- dbGetQuery(connection, paste0("SELECT * FROM `patient`
                        WHERE reportId = '", report$id,  "'"))
  # View(patient)
  
  # Query all reactions belong to a report
  reactions <- dbGetQuery(connection, paste0("SELECT * FROM `reaction`
                          WHERE reportId = '", report$id,  "'"))
  # View(reactions)
  
  # Query all drugs belong to a report
  drugs <- dbGetQuery(connection, paste0("SELECT * FROM `drug`
                      WHERE reportId = '", report$id,  "'"))
  # View(drugs)
  
  # Query all drug substances
  substanceQuery <- paste0("SELECT * FROM `substance` WHERE drugId IN ('",
                           trimws(paste(drugs$id, sep = "','")),
                           "')")
  substances <- dbGetQuery(connection, substanceQuery)
  # View(substances)
  
  return(list(report = report,
              patient = patient,
              drugs = drugs,
              substances = substances,
              reactions = reactions))
}

#substanceIndex <- dbGetQuery(con, "SELECT substance, COUNT(substance) AS freq
#                            FROM substance
#                            GROUP BY substance
#                            HAVING freq >= 100
#                            ORDER BY freq DESC")

#reactionIndex <- dbGetQuery(con, "SELECT reactionName, COUNT(reactionName) AS freq
#                            FROM reaction
#                            GROUP BY reactionName
#                            HAVING freq >= 1000
#                            ORDER BY freq DESC")