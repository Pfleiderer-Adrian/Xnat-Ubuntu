server_url="http://wombat-island.de"
rest_params="-u admin -p admin"
data_link="SampleImage.dcm"
data_name="SampleImage.dcm"
project_name="SampleProject"
subject_name="SampleSubject"
experiment_name="SampleExperiment"
scan_name="SampleScan"

chmod 777 XnatDataClient-1.7.2.jar

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"?xnat:ctSessionData/date=01/01/20"

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"/scans/"$scan_name"?xsiType=xnat:ctScanData"

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"/scans/"$scan_name"/resources/DICOM?format=DICOM"

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"/scans/"$scan_name"/resources/DICOM/files"$data_name -l $data_link
