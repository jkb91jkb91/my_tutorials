# CREATE PRIVATE DNS ZONE
gcloud dns managed-zones create kuba-pl-zone \
    --dns-name="kuba.pl." \
    --description="Private DNS zone for kuba.pl" \
    --visibility="private" \
    --networks="private-vpc"



# ADDING RECORD A TO DNS ZONE
gcloud dns record-sets transaction start --zone=kuba-pl-zone

gcloud dns record-sets transaction add 10.0.0.2 \
    --name="kuba.pl." \
    --type=A \
    --ttl=300 \
    --zone=kuba-pl-zone

gcloud dns record-sets transaction execute --zone=kuba-pl-zone



