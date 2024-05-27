set +x
set -e

Environment=$Environment
component=$component

#### VARIABLES - DECLARATION SECTION ######
echo "########## The Deployment details are ........################ "
echo "The Environment to Deploy is : $Environment"
echo "The service to deploy is : $component"


########## Declaring the server names by the environment ##########
DevEnvServers=("100.26.153.234")
UATUIServers=("54.167.116.236")
UATb2bServers=("100.26.153.234")

echo "##################################################################"
TargetServersList=""
echo "Debug: Starting script"
if [[ $Environment == "Dev" ]]; then
  echo "Debug: Environment is Dev"
  echo "The Target environment is : Dev"
  TargetServersList=("${DevEnvServers[@]}")
elif [[ $Environment == "UAT" ]]; then
  echo "Debug: Environment is UAT"
  if [[ $component == "ui" ]]; then
    echo "Debug: Component is ui"
    echo "The Target environment is : UATUI"
    TargetServersList=("${UATUIServers[@]}")
  elif [[ $component == "service" ]]; then
    echo "Debug: Component is service"
    echo "The Target environment is : UAT"
    TargetServersList=("${UATb2bServers[@]}")
  else
    echo "Debug: Component is unknown"
  fi
else
  echo "Debug: Environment is unknown"
fi
echo "Debug: Script ended"

#TargetServersListCount=${#TargetServersList[@]}

echo $TargetServersList
#echo "Total Count of servers to be deployed is :$TargetServersListCount "

# use for loop to read all values and indexes
for value in "${TargetServersList[@]}" ; do    #print the new array 
echo "$value" 
done   
echo "##################################################################"

########## Starting for the loop if we have to deploy to multiple servers #########
for TargetServer in "${TargetServersList[@]}" ; do

### Copying latest files to Tomcat
echo "### Starting - Copying WAR file(s) to the server : $TargetServer ###" 
scp $WORKSPACE/target/*.jar tomcat@$TargetServersList:/usr/local/tomcat/webapps/
echo "### Completed - Copying WAR file(s) to the server : $TargetServer ###" 

done
