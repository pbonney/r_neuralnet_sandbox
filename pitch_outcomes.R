library(RMySQL)
library(neuralnet)

sqlString <- sqlImport("./pitch_outcomes.sql")
mydb      <- dbConnect(dbDriver("MySQL"),user="bbos",password="bbos",host="localhost",dbname="gameday")
rs        <- dbSendQuery(mydb,sqlString)
df        <- fetch(rs,-1)
dbDisconnect(mydb)

# SQL query above results in dataframe df, which has three columns:
# 1. outcome: binary, 1 for a hit, 0 otherwise
# 2. px: PITCHf/x horizontal location
# 3. pz: PITCHf/x vertical location

m <- neuralnet(outcome~px+pz,
               data=df,
               hidden=4,
               linear.output=FALSE,
               lifesign='full') # useful parameter so you can monitor what's happening in training
