#!/bin/bash

srcPath="/home/TCLFTPWebUser/"
now="$(date -d "-1 day" +"%Y%m%d")"
csv=".csv"
log=".log"
filename="RetailEWP_$now$csv"
filePath=$srcPath$filename
errorfileName="RetailEwp.error"
destPath="/data/csv/files/cdi/pending/"
errorfilePath="/data/csv/utility/"
csvLogFileName=$filename$log
mailpy="/data/csv/utility"
cpCmd="cp $filePath $destPath"

#Copying CSV file from
echo "Copying CSV File: $filename"

copy_execute()
{
            echo cpCmd="$(cp $filePath $destPath)"
              if $cpCmd ; then
                  echo "copy succeeded"

              else
                echo `echo EXIT_ERROR > $errorfilePath$errorfileName`
                echo `echo FILE NOT FOUND  >> $errorfilePath$errorfileName`

              exit
               fi
}

#Executing CSV Utility
log4jPropFilePath="/data/csv/utility/log4j.properties"
dbPropFilePath="/data/csv/utility/db.properties"
jarPath="/data/csv/utility"
jarFileName="CsvToDB-0.0.1-SNAPSHOT.jar"
xmx="-Xmx8g"
#javaArgs="$xmx -Dlog_file_name=$jarPath/$csvLogFileName -Dprop.log4j=$log4jPropFilePath -Dprop.db=$dbPropFilePath"
javaArgs="$xmx -Dlog_file_name=$jarPath/$csvLogFileName -Dprop.log4j=$log4jPropFilePath -Dprop.db=$dbPropFilePath -Dprop.notifyVia=email,sms"
utilityParam1="revamp_cdi"
#sutilityParam1="test"
utilityParam2="$destPath$filename"

#javaCmd="java $javaArgs -jar $jarPath$jarFileName $utilityParam1 $utilityParam2"

#echo $javaCmd
#$javaCmd
java_execute()
{
         
          echo javaCmd="$(java $javaArgs -jar $jarPath/$jarFileName $utilityParam1 $utilityParam2)"
           if  grep -q "EXIT_ERROR" $errorfilePath$csvLogFileName ; then
            echo `echo EXIT_ERROR > $errorfilePath$errorfileName`
            echo `echo ERROR IN JAR >> $errorfilePath$errorfileName`
           else
            echo "jar run succeeded"
          fi
}

copy_execute
java_execute
