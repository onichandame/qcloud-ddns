FROM alpine:3.9
ADD ddns.sh /ddns.sh
RUN apk add curl openssl
CMD ["watch", "-n", "60", "sh", "/ddns.sh"]
