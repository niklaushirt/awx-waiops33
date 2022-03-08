#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# DO NOT MODIFY BELOW
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


#------------------------------------------------------------------------------------------------------------------------------------
#  Prepare Inception Logs
#------------------------------------------------------------------------------------------------------------------------------------
echo "   "
echo "   "
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"
echo "     🚀  Preparing Log Data"
echo "   ----------------------------------------------------------------------------------------------------------------------------------------"

for actFile in $(ls -1 $WORKING_DIR_LOGS | grep "json"); 
do 

#------------------------------------------------------------------------------------------------------------------------------------
#  Prepare the Data
#------------------------------------------------------------------------------------------------------------------------------------

      echo "      -------------------------------------------------------------------------------------------------------------------------------------"
      echo "        🛠️  Preparing Data for file $actFile"
      echo "      -------------------------------------------------------------------------------------------------------------------------------------"


      #------------------------------------------------------------------------------------------------------------------------------------
      #  Create file and structure in /tmp
      #------------------------------------------------------------------------------------------------------------------------------------
      mkdir /tmp/training-files-logs/  >/tmp/demo.log 2>&1  || true
      rm /tmp/training-files-logs/x*  >/tmp/demo.log 2>&1  || true
      rm /tmp/training-files-logs/timestampedErrorFile.json  >/tmp/demo.log 2>&1  || true
      rm /tmp/training-files-logs/timestampedErrorFile.json-e  >/tmp/demo.log 2>&1  || true
      rm /tmp/training-files-logs/logs-robotshop-kafka.json >/tmp/demo.log 2>&1  || true
      cp $WORKING_DIR_LOGS/$actFile /tmp/training-files-logs/timestampedErrorFile.json
      cd /tmp/training-files-logs/

      export my_timestamp=$(date $DATE_FORMAT_LOGS)
      #echo "DATE:"$my_timestamp"72000"
      sed -i -e "s/MY_TIMESTAMP/$my_timestamp/g" timestampedErrorFile.json

      #------------------------------------------------------------------------------------------------------------------------------------
      #  Split the files in 1500 line chunks for kafkacat
      #------------------------------------------------------------------------------------------------------------------------------------
      echo "          🔨 Splitting"
      split -l 1500 ./timestampedErrorFile.json  >/tmp/demo.log 2>&1  || true
      export NUM_FILES=$(ls | wc -l)
      rm $actFile >/tmp/demo.log 2>&1  || true
      rm timestampedErrorFileRSA.json-e >/tmp/demo.log 2>&1  || true
      rm timestampedErrorFileRSA.json >/tmp/demo.log 2>&1  || true
      #cat xaa
      cd -   >/tmp/demo.log 2>&1  || true
      echo " "
      echo "          ✅ OK"

done


