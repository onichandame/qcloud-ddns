#!/bin/sh
recordId=$RECORD_ID
domain=$DOMAIN
subDomain=$SUBDOMAIN
sId=$SECRET_ID
sKey=$SECRET_KEY
signatureMethod='HmacSHA1'
timestamp=`date +%s`
nonce=`head -200 /dev/urandom | cksum | cut -f2 -d" "`
region=bj
url="https://cns.api.qcloud.com/v2/index.php"
#获取ip
ip=`curl "http://api.ipify.org"`
action='RecordModify'
recordType='A'
recordLine='默认'
value=$ip
timestamp=`date +%s`
nonce=`head -200 /dev/urandom | cksum | cut -f2 -d" "`

src=`printf "GETcns.api.qcloud.com/v2/index.php?Action=%s&Nonce=%s&Region=%s&SecretId=%s&SignatureMethod=%s&Timestamp=%s&domain=%s&recordId=%s&recordLine=%s&recordType=%s&subDomain=%s&value=%s" $action $nonce $region $sId $signatureMethod $timestamp $domain $recordId $recordLine $recordType $subDomain $value`

echo 'src: ' $src
signature=`echo -n $src|openssl dgst -sha1 -hmac $sKey -binary |base64`
echo 'signature: ' $signature

params=`printf "Action=%s&Nonce=%s&Region=%s&SecretId=%s&SignatureMethod=%s&Timestamp=%s&domain=%s&recordId=%s&recordLine=%s&recordType=%s&subDomain=%s&value=%s" $action $nonce $region $sId $signatureMethod $timestamp $domain $recordId $recordLine $recordType $subDomain $value`

#echo 'params: ' $params

curl -G -d "$params" --data-urlencode "Signature=$signature" "$url"
