# Infrastructure - PGR301

Del av eksamen i PGR301 - DevOps i skyen og demonstrere bruk av Terraform, Docker og Travis-CI

## Fremgangsmåte

1. Opprett prosjekt på Google Cloud Platform, oppdater GCP_PROJECT_ID i .tavis.yml til prosjektets id
2. Aktiver Cloud run og container registry for prosjektet
3. Opprett en service account for terraform og gi den rollene: "cloud run admin", "Container registry admin", "Servie usage admin" og "Google storage admin"
4. Last ned nøkkel for service brukeren på json format og legg den i root mappen til prosjektet med navnet "gkey.json". Krypter filen med `travis encrypt-file --pro gkey.json --add`
5. Lag en bucket i Google cloud platform for terraform state med navnet "tf-state-exam" (ved annet navn må state.tf filen endres
6. Erstatt docker image i google,tf med ønsket image
7. Fjern eksisterende krypterte vderier, og krypter følgende verdier:
    - `travis encrypt --pro TF_VAR_logz_token=<logz.io token> --add`
    - `travis encrypt --pro TF_VAR_db_username=<h2 username> --add`
    - `travis encrypt --pro TF_VAR_db_username=<h2 password> --add`
    - `travis encrypt --pro TF_VAR_statuscake_username=<statuscake username> --add`
    - `travis encrypt --pro TF_VAR_statuscake_apikey=<statuscake api key> --add`
    - `travis encrypt --pro TF_VAR_auth0_provider_client_id=<auth0 provider client id> --add`
    - `travis encrypt --pro TF_VAR_auth0_provider_client_secret=<auth0 provider client secret> --add`
    - `travis encrypt --pro TF_VAR_auth0_provider_domain=<auth0 domain> --add`
8. Push til master branch vil nå sette i gang terraform og opprettelse av infrastrukturdelen av prosjektet. 

## Auth0

Bruker Auth0 som ekstra terraform provider, slik får man tilgang til nødvendige variabler:

1. Registrer deg på auth0
2. Lag en ny applicaiton `terraform provider` av typen **Machine to Machine application** legg til "**Auth0 Management API**" som "**authorized api**" med alle tilganger.
3. Erstatt auth0_provider_domain, auth0_provider_client_id og auth0_provider_client_secret verdiene i .travis.yml med verdiene fra den nye auth0 applikasjonen

Apiet krever autentisering ved hjelp av Auth0. For å teste applikasjonen kan man få jwt token ved å logge inn på Auth0 gå inn på "APIs" > "Cloud run API" (laget ved hjelp av terraform) > "Test"-fanen. Tokenen må legges ved i "Authorization" headeren og prefixes med "Bearer".

Tanken er at man feks skal ha en separat single-page-app som lar brukeren logge inn og hente tokenen fra auth0, for så å bruke den til å autorisere kallene mot APIet.