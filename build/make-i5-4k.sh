# var
FILE_NAME="XPS15-9560-i5-4K"

curDir=$(pwd)
sh $curDir/build/clear.sh

# update i5 Kexts
ls I5/Kexts |xargs -I {} rm -rf .dist/OC/Kexts/{}
ls I5/Kexts |xargs -I {} cp -rf I5/Kexts/{} .dist/OC/Kexts

# pack
 mv .dist $FILE_NAME
 zip -r -m $FILE_NAME-OC.zip  ./$FILE_NAME