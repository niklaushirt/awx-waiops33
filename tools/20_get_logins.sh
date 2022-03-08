#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#       __________  __ ___       _____    ________            
#      / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____
#     / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/
#    / /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) 
#    \____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  
#                                              /_/            
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------------------------------------------------------------"
#  CP4WAIOPS 3.2 - Get Logins and URLs
#
#
#  ©2022 nikh@ch.ibm.com
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"


echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo ""
echo ""
echo ""
echo "   __________  __ ___       _____    ________            "
echo "  / ____/ __ \/ // / |     / /   |  /  _/ __ \____  _____"
echo " / /   / /_/ / // /| | /| / / /| |  / // / / / __ \/ ___/"
echo "/ /___/ ____/__  __/ |/ |/ / ___ |_/ // /_/ / /_/ (__  ) "
echo "\____/_/      /_/  |__/|__/_/  |_/___/\____/ .___/____/  "
echo "                                   /_/            "
echo ""
echo ""
echo ""
echo "  "
echo "  🚀 CloudPak for Watson AIOps 3.2 - Logins and URLs "
echo "  "
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "  "
echo "  "
export TEMP_PATH=~/aiops-install

# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# Do Not Edit Below
# ---------------------------------------------------------------------------------------------------------------------------------------------------"
# ---------------------------------------------------------------------------------------------------------------------------------------------------"



export WAIOPS_NAMESPACE=$(oc get po -A|grep aimanager-operator |awk '{print$1}')
export EVTMGR_NAMESPACE=$(oc get po -A|grep noi-operator |awk '{print$1}')

CLUSTER_ROUTE=$(oc get routes console -n openshift-console | tail -n 1 2>&1 ) 
CLUSTER_FQDN=$( echo $CLUSTER_ROUTE | awk '{print $2}')
CLUSTER_NAME=${CLUSTER_FQDN##*console.}






echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "🚀 CloudPak for Watson AIOps"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "    "
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 AI Manager"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    "
echo "      📥 AI Manager"
echo ""
echo "                🌏 URL:      https://$(oc get route -n $WAIOPS_NAMESPACE cpd -o jsonpath={.spec.host})"
echo "                🧑 User:     demo"
echo "                🔐 Password: P4ssw0rd!"
echo ""
echo "                🧑 User:     $(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_username}' | base64 --decode && echo)"
echo "                🔐 Password: $(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_password}' | base64 --decode)"
echo "     "
echo "     "
echo "     "       
echo "      📥 Administration hub / Common Services"
echo ""
echo "                🌏 URL:      https://$(oc get route -n ibm-common-services cp-console -o jsonpath={.spec.host})"
echo "                🧑 User:     demo"
echo "                🔐 Password: P4ssw0rd!"
echo ""
echo "                🧑 User:     $(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_username}' | base64 --decode && echo)"
echo "                🔐 Password: $(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_password}' | base64 --decode)"
echo "    "
echo "    "
echo "    "
echo "    "
    



DEMOUI_READY=$(oc get pod -n $WAIOPS_NAMESPACE | grep 'ibm-aiops-demo-ui' || true) 
if [[ $DEMOUI_READY =~ "1/1" ]]; 
then

    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 Demo UI - Details"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    appURL=$(oc get routes -n $WAIOPS_NAMESPACE cp4waiops-demo-ui  -o jsonpath="{['spec']['host']}")|| true
    appToken=$(oc get cm -n cp4waiops demo-ui-config -o jsonpath='{.data.TOKEN}')
    echo "            📥 Demo UI:"   
    echo "    " 
    echo "                🌏 URL:           http://$appURL/"
    echo "                🔐 Token:         $appToken"
    echo ""
    echo ""
TOKEN
fi




EVTMGR_READY=$(oc get pod -n $EVTMGR_NAMESPACE | grep webgui-0|| true) 
if [[ $EVTMGR_READY =~ "2/2" ]]; 
then
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 Event Manager (Netcool Operations Insight)"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    echo "      📥 Event Manager"
    echo ""
    echo "            🌏 URL:      https://$(oc get route -n $EVTMGR_NAMESPACE  evtmanager-ibm-hdm-common-ui -o jsonpath={.spec.host})"
    echo "            🧑 User:     demo"
    echo "            🔐 Password: P4ssw0rd!"
    echo ""
    echo "            🧑 User:     smadmin"
    echo "            🔐 Password: $(oc get secret -n $EVTMGR_NAMESPACE  evtmanager-was-secret -o jsonpath='{.data.WAS_PASSWORD}'| base64 --decode && echo)"
    echo ""
    echo "       ---------------------------------------------------------------------------------------------"
    echo "        EventManager/NOI WEBHOOK:"
    echo "            URL:   <PASTE HERE FOR DOCUMENTATION WHEN CREATED>"
    echo "    "
    echo "    "
    echo "    "
    echo "    "
fi




echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "🚀 Additional Components"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "    "
echo "    "
echo "    "

TURBO_READY=$(oc get ns turbonomic || true) 
if [[ $TURBO_READY =~ "Active" ]]; 
then
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 Turbonomic Dashboard "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    echo "            📥 Turbonomic Dashboard :"
    echo ""
    echo "                🌏 URL:      https://$(oc get route -n turbonomic api -o jsonpath={.spec.host})"
    echo "                🧑 User:     administrator"
    echo "                🔐 Password: As set at init step"
    echo "    "
    echo "    "
    echo "    "
    echo "    "
fi




HUMIO_READY=$(oc get ns humio-logging || true) 
if [[ $HUMIO_READY =~ "Active" ]]; 
then

    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 HUMIO "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    echo "            📥 HUMIO:"
    echo ""
    echo "                🌏 URL:      http://$(oc get route -n humio-logging humio -o jsonpath={.spec.host})"
    echo "                🧑 User:     developer"
    echo "                🔐 Password: P4ssw0rd!"
    echo "    "
    echo "    "
    echo "    "
    echo "                INTEGRATION URL:      http://$(oc get route -n humio-logging humio -o jsonpath={.spec.host})/api/v1/repositories/aiops/query"
    echo "    "
    echo "    "
    echo "    "
    echo "    "
fi





ISTIO_READY=$(oc get ns istio-system || true) 
if [[ $ISTIO_READY =~ "Active" ]]; 
then

    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 ServiceMesh/ISTIO "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    echo "            📥 ServiceMesh:"
    echo ""
    echo "                🌏 RobotShop:     http://$(oc get route -n istio-system istio-ingressgateway -o jsonpath={.spec.host})"
    echo "                🌏 Kiali:         https://$(oc get route -n istio-system kiali -o jsonpath={.spec.host})"
    echo "                🌏 Jaeger:        https://$(oc get route -n istio-system jaeger -o jsonpath={.spec.host})"
    echo "                🌏 Grafana:       https://$(oc get route -n istio-system grafana -o jsonpath={.spec.host})"
    echo "    "
    echo "    "
    echo "          In the begining all traffic is routed to ratings-test"
    echo "            You can modify the routing by executing:"
    echo "              All Traffic to test:    oc apply -n robot-shop -f ./ansible/templates/demo_apps/robotshop/istio/ratings-100-0.yaml"
    echo "              Traffic split 50-50:    oc apply -n robot-shop -f ./ansible/templates/demo_apps/robotshop/istio/ratings-50-50.yaml"
    echo "              All Traffic to prod:    oc apply -n robot-shop -f ./ansible/templates/demo_apps/robotshop/istio/ratings-0-100.yaml"
    echo "    "
    echo "    "
    echo "    "
fi


AWX_READY=$(oc get ns awx || true) 
if [[ $AWX_READY =~ "Active" ]]; 
then
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 AWX "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    echo "            📥 AWX :"
    echo ""
    echo "                🌏 URL:      https://$(oc get route -n awx awx -o jsonpath={.spec.host})"
    echo "                🧑 User:     admin"
    echo "                🔐 Password: $(oc -n awx get secret awx-admin-password -o jsonpath='{.data.password}' | base64 --decode && echo)"
    echo "    "
    echo "    "
    echo "    "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 For Runbook Integration: "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"

    DEMO_TOKEN=$(oc -n default get secret $(oc get secret -n default |grep -m1 demo-admin-token|awk '{print$1}') -o jsonpath='{.data.token}'|base64 --decode)
    DEMO_URL=$(oc status|grep -m1 "In project"|awk '{print$6}')

    echo "{"
    echo "\"my_k8s_apiurl\": \"$DEMO_URL\","
    echo "\"my_k8s_apikey\": \"$DEMO_TOKEN\""
    echo "}"
    echo "    "
fi





MIQ_READY=$(oc get ns manageiq || true) 
if [[ $MIQ_READY =~ "Active" ]]; 
then
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 ManageIQ "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    echo "            📥 ManageIQ :"
    echo ""
    echo "                🌏 URL:      https://$(oc get route -n manageiq $(oc get route -n manageiq|grep httpd|awk '{print$1}') -o jsonpath={.spec.host})"
    echo "                🧑 User:     admin"
    echo "                🔐 Password: smartvm"
    echo "    "
    echo "    "
    echo "    "
    echo "    "
fi




DEMO_READY=$(oc get ns robot-shop || true) 
if [[ $DEMO_READY =~ "Active" ]]; 
then

    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 Demo Apps - Details"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    "
    appURL=$(oc get routes -n robot-shop web  -o jsonpath="{['spec']['host']}")|| true
    echo "            📥 RobotShop:"   
    echo "    " 
    echo "                🌏 APP URL:           http://$appURL/"

    echo ""
    echo ""
    appURL=$(oc get routes -n kubetoy kubetoy  -o jsonpath="{['spec']['host']}")|| true

    echo "            📥 Kubetoy:"
    echo "    " 
    echo "                🌏 APP URL:           http://$appURL/"
    echo ""
    echo ""
    echo ""
    echo ""
fi



echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "🚀 Openshift Connection Details"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo ""
echo "  📥 Openshift Console"
echo ""
echo "            🌏 URL:      https://$(oc get route -n openshift-console console -o jsonpath={.spec.host})"
echo " "
echo " "
echo " "
echo "  📥 Openshift Command Line"
echo ""
DEMO_TOKEN=$(oc -n default get secret $(oc get secret -n default |grep -m1 demo-admin-token|awk '{print$1}') -o jsonpath='{.data.token}'|base64 --decode)
DEMO_URL=$(oc status|grep -m1 "In project"|awk '{print$6}')
echo "            🌏 URL:     $DEMO_URL"
echo "            🔐 Token:   $DEMO_TOKEN"
echo ""
echo ""
echo "            🧑 Login:   oc login --token=$DEMO_TOKEN --server=$DEMO_URL"
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""


echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "🚀 CloudPak for Watson AIOps - Technical Links"
echo "***************************************************************************************************************************************************"
echo "***************************************************************************************************************************************************"
echo "    "
echo "    "
echo "    "
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 CP4WAIOPS Vault"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    " 
echo "            📥 Vault:"
echo "    " 
echo "                🌏 URL:      https://$(oc get route -n $WAIOPS_NAMESPACE ibm-vault-deploy-vault-route -o jsonpath={.spec.host})"
echo "                🔐 Token:    $(oc get secret -n $WAIOPS_NAMESPACE ibm-vault-deploy-vault-credential -o jsonpath='{.data.token}' | base64 --decode && echo)"
echo "    "
echo "    "
echo "    "
echo "    "


echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 LDAP "
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    " 
echo "            📥 OPENLDAP:"
echo "    " 
echo "                🌏 URL:      http://$(oc get route -n default openldap-admin -o jsonpath={.spec.host})"
echo "                🧑 User:     cn=admin,dc=ibm,dc=com"
echo "                🔐 Password: P4ssw0rd!"
echo "    "
echo "    "
echo "    "
echo "    "





echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 Flink Task Manager"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
appURL=$(oc get routes -n $WAIOPS_NAMESPACE job-manager  -o jsonpath="{['spec']['host']}")
echo "    " 
echo "            📥 Flink Task Manager:"
echo "    " 
echo "                🌏 APP URL:           https://$appURL/"
echo "    "
echo "                In Chrome: if you get blocked just type "thisisunsafe" and it will continue (you don't get any visual feedback when typing!)"
echo "    "
echo "    "
echo "    "
echo "    "



echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 Spark Master"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
appURL=$(oc get routes -n $WAIOPS_NAMESPACE spark  -o jsonpath="{['spec']['host']}")
echo "    " 
echo "            📥 Spark Master:"
echo "    " 
echo "                🌏 APP URL:           https://$appURL/"
echo "    "
echo "    "
echo "    "
echo "    "
echo "    "





ELK_READY=$(oc get ns openshift-logging || true) 
if [[ $ELK_READY =~ "Active" ]]; 
then
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 ELK "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    token=$(oc sa get-token cluster-logging-operator -n openshift-logging)
    routeES=`oc get route elasticsearch -o jsonpath={.spec.host} -n openshift-logging`
    routeKIBANA=`oc get route kibana -o jsonpath={.spec.host} -n openshift-logging`
    echo "      "
    echo "            📥 ELK:"
    echo "      "
    echo "               🌏 ELK service URL             : https://$routeES/app*"
    echo "               🔐 Authentication type         : Token"
    echo "               🔐 Token                       : $token"
    echo "      "
    echo "               🌏 Kibana URL                  : https://$routeKIBANA"
    echo "               🚪 Kibana port                 : 443"
    echo "               🗺️  Mapping                     : "
    echo "{ "
    echo "  \"codec\": \"elk\","
    echo "  \"message_field\": \"message\","
    echo "  \"log_entity_types\": \"kubernetes.container_image_id, kubernetes.host, kubernetes.pod_name, kubernetes.namespace_name\","
    echo "  \"instance_id_field\": \"kubernetes.container_name\","
    echo "  \"rolling_time\": 10,"
    echo "  \"timestamp_field\": \"@timestamp\""
    echo "}"
    echo "  "
    echo ""
    echo ""
    echo ""
    echo "               🗺️  Filter                     : "
    echo ""
    echo "      {"
    echo "        \"query\": {"
    echo "          \"bool\": {"
    echo "               \"must\": {"
    echo "                  \"term\" : { \"kubernetes.namespace_name\" : \"robot-shop\" }"
    echo "               }"
    echo "              }"
    echo "          }"
    echo "      }"
    echo "  "
    echo ""
    echo ""
    echo ""

 fi






ROOK_READY=$(oc get ns rook-ceph || true) 
if [[ $ROOK_READY =~ "Active" ]]; 
then
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    🚀 Rook/Ceph Dashboard "
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
    echo "    " 
    echo "            📥 Rook/Ceph Dashboard :"
    echo "    " 
    echo "                🌏 URL:      https://dash-rook-ceph.$CLUSTER_NAME/"
    echo "                🧑 User:     admin"
    echo "                🔐 Password: $(oc -n rook-ceph get secret rook-ceph-dashboard-password -o jsonpath="{['data']['password']}" | base64 --decode)"
    echo "    "
    echo "    "
    echo "    "
    echo "    "    
fi





echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 Service Now "
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    " 
echo "            📥 Login SNOW Dev Portal (if you have to wake the dev instance):"
echo "    " 
echo "                🌏 URL:                   https://developer.servicenow.com/dev.do"
echo "                🧑 User:                  demo@mydemo.center"
echo "                🔐 Password:              P4ssw0rd!IBM"
echo ""
echo ""
echo "            📥  Login SNOW Instance::"
echo ""
echo "                🌏 URL:                   https://dev56805.service-now.com"
echo "                🧑 User ID:               abraham.lincoln             (if you followed the demo install instructions)"
echo "                🔐 Password:              P4ssw0rd!                   (if you followed the demo install instructions)"
echo "                🔐 Encrypted Password:    g4W3L7/eFsUjV0eMncBkbg==    (if you followed the demo install instructions)"
echo ""
echo ""
echo "            📥 INTEGRATION SNOW-->CP4WAIOPS:"
echo "    " 
echo "                🌏 URL:                   https://$(oc get route -n $WAIOPS_NAMESPACE cpd -o jsonpath={.spec.host})    (URL for IBM Watson AIOps connection)"
echo "                📛 Instance Name:         aimanager"
echo "                🧑 User:                  admin"
echo "                🔐 Password:              $(oc -n ibm-common-services get secret platform-auth-idp-credentials -o jsonpath='{.data.admin_password}' | base64 --decode)"
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""



echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    🚀 GRAPHQL Playground "
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
echo "    -----------------------------------------------------------------------------------------------------------------------------------------------"
apiURL=$(oc get routes -n $WAIOPS_NAMESPACE ai-platform-api -o jsonpath="{['spec']['host']}")
ZEN_API_HOST=$(oc get route -n $WAIOPS_NAMESPACE cpd -o jsonpath='{.spec.host}')
ZEN_LOGIN_URL="https://${ZEN_API_HOST}/v1/preauth/signin"
LOGIN_USER=admin
LOGIN_PASSWORD="$(oc get secret admin-user-details -n $WAIOPS_NAMESPACE -o jsonpath='{ .data.initial_admin_password }' | base64 --decode)"

ZEN_LOGIN_RESPONSE=$(
curl -k \
-H 'Content-Type: application/json' \
-XPOST \
"${ZEN_LOGIN_URL}" \
-d '{
    "username": "'"${LOGIN_USER}"'",
    "password": "'"${LOGIN_PASSWORD}"'"
}' 2> /dev/null
)


ZEN_TOKEN=$(echo "${ZEN_LOGIN_RESPONSE}" | jq -r .token)


echo "    " 
echo "            📥 Playground:"
echo "    " 
echo "                🌏 URL:                   https://$apiURL/graphql"
echo ""
echo ""
echo "    " 
echo "                🔐 HTTP HEADERS"
echo "                        {"
echo "                        \"authorization\": \"Bearer $ZEN_TOKEN\""
echo "                        }"
echo "    " 
echo "    " 
echo "    " 
echo "                📥 Example Payload"
echo "                        query {"
echo "                            getTrainingDefinitions {"
echo "                              definitionName"
echo "                              algorithmName"
echo "                              version"
echo "                              deployedVersion"
echo "                              description"
echo "                              createdBy"
echo "                              modelDeploymentDate"
echo "                            }"
echo "                          }"
echo "    " 
echo "    " 
echo "    " 
echo "                🔐 ZEN Token:             $ZEN_TOKEN"