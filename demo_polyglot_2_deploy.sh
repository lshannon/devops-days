#!/bin/sh
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Write out the manifest in user friendly format
writeManifest() {
  while read line
  do
      printf "%s\n" "$line"
  done < "$1"
}

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
echo "This is running in an on-premise vSphere Cluster"
echo " "
echo "Deploying .NET Service: $CURRENT_DIR/NET_Service/SimpleRest"
cd $CURRENT_DIR/NET_Service/SimpleRest
echo "Pushing .NET Service"
echo "Manifest for deployment: "
echo " "
writeManifest $CURRENT_DIR/NET_Service/SimpleRest/manifest.yml
cf push
echo " "
echo "Deploying Spring Service: $CURRENT_DIR/Spring_Service/customer-service"
cd $CURRENT_DIR/Spring_Service/customer-service
echo "Pushing Spring/Java Service"
echo "Manifest for deployment: "
echo " "
writeManifest $CURRENT_DIR/Spring_Service/customer-service/manifest.yml
cf push
echo " "
echo "Deploying Javascript Service: $CURRENT_DIR/Javascript-UI-Service"
cd $CURRENT_DIR/Javascript-UI-Service
echo "Pushing Javascript Service"
echo "Manifest for deployment: "
echo " "
writeManifest $CURRENT_DIR/Javascript-UI-Service/manifest.yml
cf push
echo " "
