# var
FILE_NAME="XPS15-9560-i7-4K"

curDir=$(pwd)
sh $curDir/build/clear.sh

# pack
 mv .dist $FILE_NAME
 zip -r -m $FILE_NAME-OC.zip  ./$FILE_NAME