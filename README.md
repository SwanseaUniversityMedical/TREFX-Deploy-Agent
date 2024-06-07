# TREFX Deploy Agent

Used to deploy an instance of a TREFX Agent

More details / instructions to be added here

Min

curl https://raw.githubusercontent.com/SwanseaUniversityMedical/TREFX-Deploy-Agent/main/installagent.sh   | sh


Testing

curl https://raw.githubusercontent.com/SwanseaUniversityMedical/TREFX-Deploy-Agent/main/installagent.sh -H "Pragma: no-cache" -H "Cache-Control: no-cache, no-store" | sh

envs to set are

AGENT_TYPE = is the dir name of the The deployment you want to use

export AGENT_TYPE=TREFX-Deploy-Agent

AGENT_ID = URL to settings like 

export AGENT_ID=https://cat-hdp.demo.ukserp.ac.uk/doc/GetDataJson/trefxagent/75c5c588-9842-4aae-9382-526f1eead938

```
{
  "httpsRedirect": false,
  "name": "Test Agent",
  "verTUI": "1.95.3",
  "verTAPI": "1.113.7",
  "verEUI": "1.63.8",
  "verEAPI": "1.61.6",
  "fetch_sub": "https://cat-hdp.demo.ukserp.ac.uk/doc/GetDataJson/trefxsubmission/29ebdaa0-f101-4686-8449-3558d8ff0f20",
  "scanSchedule": 1,
  "syncSchedulke": 10,
  "useProxy": true,
  "proxyUrl": "http://192.168.10.15:8080",
  "minioUrl": "192.168.70.130",
  "keycloakUrl": "auth2.ukserp.ac.uk",
  "keycloakMainRealm": "Dare-TRE",
  "keycloakMainClientUrl": "cardiff.trefx.ukserp.ac.uk",
  "keycloakEgressRealm": "Data-Egress",
  "keycloakEgressClientUrl": "egress.cardiff.trefx.ukserp.ac.uk",
  "UseTesk": true,
  "UseHutch": false,
  "UseRabbit": false,
  "TreKeyCloakSecret": "5da4W2dwgRfYb3Jfp9if7KSPQLiMZ93I",
  "EgressKeyCloakSecret": "Gci9NkcscL4RbhDlHfAL39iwNWlFefTl",
  "SubmissionKeyCloakSecret": "krDQH6jFM1piGvTRnzCC2UGFUZuTZDkJ",
  "id": 0
}
```
