server_url="http://wombat-island.de"
rest_params="-u admin -p 7ed0ae023523e6d057a437e1db9f1d31"
project_name="RestApiTest"
subject_name="TestSubject"
experiment_name="TestExperiment"
dir_path="/Xnat-Ubuntu/RESTApitest/TestDaten/LCTSC-Train-S3-012/05-04-2004-NM_PET_SCAN_RADIATION-26270/1-64131"
scan_name="TestScan"

chmod 777 XnatDataClient-1.7.2.jar

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"?xnat:ctSessionData/date=01/01/20"

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"/scans/"$scan_name"?xsiType=xnat:ctScanData"

java -jar XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"/scans/"$scan_name"/resources/DICOM?format=DICOM"

cd $dir_path
for file in *.dcm
do
	java -jar ../../../../XnatDataClient-1.7.2.jar $rest_params -m PUT -r $server_url"/data/archive/projects/"$project_name"/subjects/"$subject_name"/experiments/"$experiment_name"/scans/"$scan_name"/resources/DICOM/files"$file -l $file
done