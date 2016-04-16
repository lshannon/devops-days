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
cd Simple-Data-Application
echo "Pushing Application Using"
echo `less manifest.yml`
cf push
