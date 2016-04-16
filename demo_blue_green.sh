# production app settings
APP_PROD_ROUTE=javascript-service
APP_PROD_NAME=javascript-service

# define app properties
APP_TEMP_ROUTE=javascript-service-new

# push the application with a manifest that binds all required services
cf push javascript-service-new -p Javascript-UI-Service-Updated -n javascript-service-new -b staticfile_buildpack -m 256M

# Run Tests on the newly deployed app check that it is okay
echo ""
curl http://javascript-service-new.cfapps.pez.pivotal.io
echo ""

# start directing traffic to the new app instance
cf map-route javascript-service-new cfapps.pez.pivotal.io -n javascript-service

# scale up the new app instance
cf scale javascript-service-new -i 2

# scale down the proi app instances
cf scale javascript-service -i 1

# stop taking traffic on the current prod instance
cf unmap-route javascript-service cfapps.pez.pivotal.io -n javascript-service

# decommission the old app
cf stop javascript-service
cf rename javascript-service javascript-service-old

# make the current app the new prod application
cf unmap-route javascript-service-new cfapps.pez.pivotal.io -n javascript-service-new
cf rename javascript-service-new javascript-service
