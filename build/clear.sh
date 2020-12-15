# clear 
rm -rf ./.dist

# create dir
mkdir -p .dist

# copy config && tools
cp -rf OC .dist/
cp -rf Post-install .dist/
cp -rf BOOT .dist/