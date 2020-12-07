# var
FILE_NAME="XPS15-9560-i7-4K"

# clear 
rm -rf ./.dist

# create dir
mkdir -p .dist

# copy config && tools
cp -rf OC .dist/
cp -rf Post-install .dist/


# pack
 mv .dist $FILE_NAME
 zip -r -m $FILE_NAME-OC.zip  ./$FILE_NAME