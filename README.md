# qcloud-ddns

DDNS scripts for qcloud(tencent cloud)

# Author

[onichandame](https://github.com/onichandame)

# Goal

update DNS record automatically from the server. The record is updated every minute.

Combined with the restart policy of docker, the script keeps running as long as the docker service is active.

# Requirements

1. Container runtime(docker, podman, etc.)
2. An existing DNS record corresponding to the subdomain in this context(for example, in `www.google.com`, the DOMAIN is `google.com`, the SUBDOMAIN is `www`)
3. The ID of the record defined above. This ID can be retrieved by running `getId.sh` script with the correct env variables set(see below)
4. Active secret id and secret key that has the correct permission

# Usage

For a first-time user with a domain already purchased, do the following:

1. log in the [qcloud console](https://console.cloud.tencent.com/cns/detail/onichandame.com/records/0) for the domain management
2. create a record for this DDNS if not already done. the IP can be randomized as this script will automatically update it
3. create a sub-user with Read/Write permission of all the Web resources and get the secret ID and secret key.
4. run `getId.sh` with the `DOMAIN`, `SECRET_ID` and `SECRET_KEY` set through the env variables
5. find the id of the record of interest from the output of the previous step and write it down as `RECORD_ID`

The following steps must be run every time this container is manually started:

1. run `docker run -e RECORD_ID=<RECORD_ID> -e DOMAIN=<DOMAIN> -e SUBDOMAIN=<SUBDOMAIN> -e SECRET_ID=<SECRET_ID> -e SECRET_KEY=<SECRET_KEY> -d --restart always --name ddns onichandame/qcloud-ddns:latest`

# Credits

The script comes from [this post](https://blog.csdn.net/dragon2k/article/details/88016755).
