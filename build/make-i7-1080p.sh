# var
FILE_NAME="XPS15-9560-i7-1080P"

# clear 
rm -rf ./.dist

# create dir
mkdir -p .dist

# copy config && tools
cp -rf OC .dist/
cp -rf Post-install .dist/

# 
sed -i '' 's/AAPL00,override-no-connect/#AAPL00,override-no-connect/g' .dist/OC/config.plist

# pack
 mv .dist $FILE_NAME
 zip -r -m $FILE_NAME-OC.zip  $FILE_NAME