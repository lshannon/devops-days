echo ' _______    ______   ________        _______                                    ';
echo '/       \  /      \ /        |      /       \                                   ';
echo '$$$$$$$  |/$$$$$$  |$$$$$$$$/       $$$$$$$  |  ______   _____  ____    ______  ';
echo '$$ |__$$ |$$ |  $$/ $$ |__          $$ |  $$ | /      \ /     \/    \  /      \ ';
echo '$$    $$/ $$ |      $$    |         $$ |  $$ |/$$$$$$  |$$$$$$ $$$$  |/$$$$$$  |';
echo '$$$$$$$/  $$ |   __ $$$$$/          $$ |  $$ |$$    $$ |$$ | $$ | $$ |$$ |  $$ |';
echo '$$ |      $$ \__/  |$$ |            $$ |__$$ |$$$$$$$$/ $$ | $$ | $$ |$$ \__$$ |';
echo '$$ |      $$    $$/ $$ |            $$    $$/ $$       |$$ | $$ | $$ |$$    $$/ ';
echo '$$/        $$$$$$/  $$/             $$$$$$$/   $$$$$$$/ $$/  $$/  $$/  $$$$$$/  ';
echo "                                                                                ";
echo " "
echo "Running: https://api.run.pez.pivotal.io"
echo "This is running in an onpremise vSphere Cluster"
echo " "
DOMAIN=cfapps.pez.pivotal.io
ORIGINAL_APP=javascript-ui
NEW_APP=javascript-ui-new
OLD_APP=javascript-ui-old

# push the application with a manifest that binds all required services
echo "Pushing the 'New' Service"
echo "cf push $NEW_APP -p Javascript-UI-Service-Updated -n $NEW_APP -b staticfile_buildpack -m 256M"
cf push $NEW_APP -p Javascript-UI-Service-Updated -n NEW_APP -b staticfile_buildpack -m 256M
echo ""

# Run Tests on the newly deployed app check that it is okay
echo "Testing the new service"
echo ""
RESPONSE=`curl -sI http://NEW_APP.$DOMAIN`
echo "$RESPONSE"
if [[ $RESPONSE != *"HTTP/1.1 200 OK"* ]]
then
  echo "Service Did Not Start Up - Stopping Upgrade...";
  cf delete $NEW_APP -f;
  echo "New Service Deleted"
  echo "Upgrade Stopping"
  exit 1;
fi
echo ""

# scale up the new app instance
echo "Scaling Up The New Application"
echo "cf scale $NEW_APP -i 2"
cf scale $NEW_APP -i 2
echo ""

# start directing traffic to the new app instance
echo "Move Traffic to new application"
echo "cf map-route $NEW_APP $DOMAIN -n $ORIGINAL_APP"
cf map-route $NEW_APP $DOMAIN -n $ORIGINAL_APP
echo ""

# scale down the proi app instances
echo "Scale Down The Old Application"
echo "cf scale javascript-ui -i 1"
cf scale $ORIGINAL_APP -i 1
echo ""

# stop taking traffic on the current prod instance
echo "Unmap the Old Application"
echo "cf unmap-route javascript-ui $DOMAIN -n javascript-ui"
cf unmap-route $ORIGINAL_APP $DOMAIN -n $ORIGINAL_APP
echo ""

# decommission the old app
echo "Stop the old application"
echo "cf stop $ORIGINAL_APP"
cf stop $ORIGINAL_APP
echo ""

# delete any version of the old app that might be lying around still
echo "Delete any old back up versions of the application"
echo "cf delete $OLD_APP -f"
cf delete $OLD_APP -f

echo "Rename the old service to a name that reflects it new status"
echo "cf rename javascript-service javascript-service-old"
cf rename $ORIGINAL_APP $ORIGINAL_APP-old
echo ""

# clean up the temp route
echo "Remove the temp route"
echo "cf unmap-route $NEW_APP $DOMAIN -n $NEW_APP"
cf unmap-route $NEW_APP $DOMAIN -n $NEW_APP
echo ""

# rename the app
echo "Rename the app"
echo "cf rename $NEW_APP $ORIGINAL_APP"
cf rename $NEW_APP $ORIGINAL_APP
