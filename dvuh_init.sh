#!/bin/bash

SEM=("WS2021" "SS2022")

SCHEDULER=("/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/JQMScheduler/requestMatrikelnummer/"
           "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/JQMScheduler/sendCharge/"
           "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/JQMScheduler/sendPayment/"
           "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/JQMScheduler/sendStudyData/"
           "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/JQMScheduler/requestBpk/"
           "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/JQMScheduler/sendPruefungsaktivitaeten/" )

WORKER=( "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/DVUHManagement/requestMatrikelnummer"
         "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/DVUHManagement/sendCharge"
         "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/DVUHManagement/sendPayment"
         "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/DVUHManagement/sendStudyData"
         "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/DVUHManagement/requestBpk"
         "/var/www/index.ci.php extensions/FHC-Core-DVUH/jobs/DVUHManagement/sendPruefungsaktivitaeten" )


# EXECUTE SCHEDULER
for sem in "${SEM[@]}"
    do
        for sched in "${SCHEDULER[@]}"
            do
                substr=$(echo $sched | cut -d '/' -f 8)
                echo "Processing SCHEDULER $substr->$sem ..."
                # EXECUTE PHP
                php $sched$sem
        done
done


# EXECUTE WORKER
for work in "${WORKER[@]}"
    do
        substr=$(echo $work | cut -d '/' -f 8)
        echo "Processing WORKER $substr ..."
        # EXECUTE PHP
        php $work
        for i in {10..0}; do echo -ne "Sleeping for $i sec "'\r'; sleep 1; done; echo
done
