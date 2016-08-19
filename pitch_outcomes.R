library(RMySQL)
library(neuralnet)

sqlString <- sqlImport("./pitch_outcomes.sql")
mydb      <- dbConnect(dbDriver("MySQL"),user="bbos",password="bbos",host="localhost",dbname="gameday")
rs        <- dbSendQuery(mydb,sqlString)
df        <- fetch(rs,-1)
dbDisconnect(mydb)

m <- neuralnet(outcome~px+pz,data=df,hidden=4,linear.output=FALSE,lifesign='full',stepmax=100000)
