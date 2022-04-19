#!/bin/bash

errorfileName="exitError"
destPath="/data/lasdiy/files/pending/"
errorfilePath="/data/lasdiy/utility/"
#mailpy="/data/lasdiy/utility"
#csvLogFileName=$filename$log



#Executing CSV Utility
log4jPropFilePath="/data/lasdiy/utility/log4j.properties"
dbPropFilePath="/data/lasdiy/utility/db.properties"
jarPath="/data/lasdiy/utility"
jarFileName="las-diy-1.0-SNAPSHOT.jar"
xmx="-Xmx8g"
javaArgs="$xmx  -Dprop.log4j=$log4jPropFilePath -Dprop.db=$dbPropFilePath -Dprop.notifyVia=email,sms -Dprop.delay=120000"
#javaArgs="$xmx  -Dprop.log4j=$log4jPropFilePath -Dprop.db=$dbPropFilePath "
utilityParam1="las_utility_cdi_mode"

fileName=$1
echo $fileName
java_execute()
{
        for files in $(ls  $destPath/$fileName | awk -F "/" '{print $NF}')
#        for files in $(ls  $destPath/LASDIY_1211202121200001.csv | awk -F "/" '{print $NF}')
        do
              echo "Current_filename:${files}"
#               java $javaArgs  -Dlog_file_name=$errorfilePath/logs/${timestamp2}/${files}.log  -jar $jarPath/$jarFileName $utilityParam1 $destPath$files
               java $javaArgs  -Dlog_file_name=$errorfilePath${files}.log  -jar $jarPath/$jarFileName $utilityParam1 $destPath$files
        status="$(echo $?)"
              if [[ ${status} -ne 0 ]] ; then
#               python ${mailpy}/mail.py "LasFiles execution Failed!" "Java execution is failed on ${filename}."
                echo "$files is error" > $errorfilePath$errorfileName
                echo echo EXIT_ERROR >> $errorfilePath$errorfileName
                echo echo ERROR IN JAR >> $errorfilePath$errorfileName
                exit
              else
                echo "$files is success"
                echo "jar run succeeded"
              fi
        done
}

java_execute
endTime=$(date "+%d/%m/%y:%H:%M:%S")
echo ${endTime}

