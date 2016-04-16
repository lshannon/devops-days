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
#if [ $# -eq 0 ]; then
#	echo "Usage: demo_polymorphic_1.sh <organization> <space>";
#	echo "Hint: demo_polymorphic_1.sh pivot-lshannon devops-days";
#	echo "Program terminating ...";
#	exit 1;
#fi
cf api https://api.run.pez.pivotal.io
echo "Running: cf login -sso"
#cf login -o "$1" -s "$2" -sso
cf login -o pivot-lshannon -s devops-days -sso
