PORT=19607
DATE_FORMAT="+%Y-%m-%d_%H-%M-%S"
SCANNER_DEV_ID="brother4:net1;dev0"
SCANNED_FILES_DIR=scanned_images

echo Listener starts `date $DATE_FORMAT`
RUNNING=true
while $RUNNING
do
	echo waiting for incoming messages
	INPUT=`nc -l $PORT`
	echo got message: $INPUT
	if [ "$INPUT" == 'quit' ]; then
		RUNNING=false
	fi
	if [ "$INPUT" == 'test' ]; then
		echo "test handle called"
	fi
	if [ "$INPUT" == 'scan' ]; then
		SCANNER_FILENAME=$SCANNED_FILES_DIR/image_`date $DATE_FORMAT`.png
		scanimage -d "$SCANNER_DEV_ID" --format png >$SCANNER_FILENAME
	fi
done

echo Listener finishes `date $DATE_FORMAT`

