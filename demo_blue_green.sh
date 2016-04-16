DOMAIN=cfapps.pez.pivotal.io

# push the application with a manifest that binds all required services
echo "Pushing the 'New' Service"
echo "cf push javascript-service-new -p Javascript-UI-Service-Updated -n javascript-service-new -b staticfile_buildpack -m 256M"
cf push javascript-service-new -p Javascript-UI-Service-Updated -n javascript-service-new -b staticfile_buildpack -m 256M
echo ""

# Run Tests on the newly deployed app check that it is okay
echo "Testing the new service"
echo ""
curl http://javascript-service-new.$DOMAIN
echo ""

# start directing traffic to the new app instance
echo "Move Traffic to new application"
echo "cf map-route javascript-service-new $DOMAIN -n javascript-service"
cf map-route javascript-service-new $DOMAIN -n javascript-service
echo ""

# scale up the new app instance
echo "Scaling Up The New Application"
echo "cf scale javascript-service-new -i 2"
cf scale javascript-service-new -i 2
echo ""

# scale down the proi app instances
echo "Scale Down The Old Application"
echo "cf scale javascript-service -i 1"
cf scale javascript-service -i 1
echo ""

# stop taking traffic on the current prod instance
echo "Unmap the Old Application"
echo "cf unmap-route javascript-service $DOMAIN -n javascript-service"
cf unmap-route javascript-service $DOMAIN -n javascript-service
echo ""

# decommission the old app
echo "Stop the old application"
echo "cf stop javascript-service"
cf stop javascript-service
echo ""

echo "Rename the old service to a name that reflects it new status"
echo "cf rename javascript-service javascript-service-old"
cf rename javascript-service javascript-service-old
echo ""

# clean up the temp route
echo "Remove the temp route"
echo "cf unmap-route javascript-service-new $DOMAIN -n javascript-service-new"
cf unmap-route javascript-service-new $DOMAIN -n javascript-service-new
echo ""

# rename the app
echo "Rename the app"
echo "cf rename javascript-service-new javascript-service"
cf rename javascript-service-new javascript-service
