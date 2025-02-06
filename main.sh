#!/usr/bin/env bash
set -xe

URL=$1
if [ -z "$URL" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

echo -e "This script will attempt to complete all of the steps\n from beginning to end for a oneplus7t."

read -p "Press enter to continue, or control-c to exit..."

# Download the ROM archive
echo "Downloading the archive..."
[ ! -f *.zip ] && \
echo "Downloading ${URL}" && \
wget $URL >| out 2>&1

# cheap way to get the filename
archive=$(ls -Art | grep zip)

# unzip the ROM archive
echo "Unzipping the archive..."
unzip -o ${archive} -d archive_files

echo "Grabbing payload.bin and moving it to ${PWD}"
# move payload.bin to CWD 
#mv $(ls -Art | tail -n 1)/payload.bin payload.bin >| out 2>&1
mv archive_files/payload.bin payload.bin && \
rm -rf archive_files 

# Create images directory if it doesn't exist
[ ! -d images ] && \
mkdir images

# run payload dumper against payload.bin 
# and clean up
echo "dumping the payload to an images directory..."

payload-dumper-go -o ./images payload.bin && \
rm payload.bin 

# storing the images directory path as a variable
images_path=$(realpath images)

echo -e "Now we call the flashing scripts...\n\n"
read -p "Ready? Press enter to continue, or control-c to exit..."

echo -e "Flashing the first images" 
./flash-images-1.sh ${images_path} && \
echo -e "Flashing xbl" && \ 
./flash-xbl-op7t.sh ${images_path} && \
echo -e "deleting all partitions" && \  
./clear-all-partitions.sh && \
echo -e "recreating all partitions" && \  
./recreate-partitions.sh && \
echo -e "Flashing the second images" && \ 
./flash-images-2.sh ${images_path}

echo -e "Done! If you want to unlock your bootloader\n"
echo 'e "Find the next step in the README..."

