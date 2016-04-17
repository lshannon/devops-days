cf cups my-logs -l syslog-tls://logs4.papertrailapp.com:40014
cf bind-service simple-data-service my-logs
cf restart simple-data-service
