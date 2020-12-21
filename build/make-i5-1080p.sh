# var
FILE_NAME="XPS15-9560-i5-1080P"

curDir=$(pwd)
sh $curDir/build/clear.sh

# 
# sed -i '' 's/AAPL00,override-no-connect/#AAPL00,override-no-connect/g' .dist/OC/config.plist

# update i5 Kexts
ls I5/Kexts |xargs -I {} rm -rf .dist/OC/Kexts/{}
ls I5/Kexts |xargs -I {} cp -rf I5/Kexts/{} .dist/OC/Kexts

# pack
 mv .dist $FILE_NAME
 zip -r -m $FILE_NAME-OC.zip  $FILE_NAME