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
echo "Running: https://api.run.pivotal.io"
echo "This is running in an public AWS cloud"
echo " "
echo "cf api api.run.pivotal.io"
cf api api.run.pivotal.io
echo "cf login -a https://api.run.pivotal.io"
cf login -a https://api.run.pivotal.io
