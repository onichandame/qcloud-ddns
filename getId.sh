#!/bin/sh

domain=$DOMAIN
sId=$SECRET_ID
sKey=$SECRET_KEY
signatureMethod='HmacSHA1'
timestamp=`date +%s`
nonce=`head -200 /dev/urandom | cksum | cut -f2 -d" "`
region=bj
url="https://cns.api.qcloud.com/v2/index.php"
#获取域名解析条目ID：recordId
action='RecordList'
src=`printf "GETcns.api.qcloud.com/v2/index.php?Action=%s&Nonce=%s&Region=%s&SecretId=%s&SignatureMethod=%s&Timestamp=%s&domain=%s" $action $nonce $region $sId $signatureMethod $timestamp $domain`
echo 'src: ' $src
signature=`echo -n $src|openssl dgst -sha1 -hmac $sKey -binary |base64`
echo 'signature: ' $signature
params=`printf "Action=%s&domain=%s&Nonce=%s&Region=%s&SecretId=%s&Signature=%s&SignatureMethod=%s&Timestamp=%s" $action $domain $nonce $region $sId "$signature" $signatureMethod $timestamp `
echo 'params: ' $params
curl -G -d "$params" --data-urlencode "Signature=$signature" "$url"
