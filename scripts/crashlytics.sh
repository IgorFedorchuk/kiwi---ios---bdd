#!/bin/sh

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_UUID.mobileprovision"
PROVISIONING_PROFILE_NAME="dist"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
ARCHIVE_PATH="$PWD/build.xcarchive"
APP_DIR="$ARCHIVE_PATH/Products/Applications"
#DSYM_DIR="$ARCHIVE_PATH/dSYMs"

echo "********************"
echo "*     Archive      *"
echo "********************"

xcodebuild -scheme "$XCODE_SCHEME" -workspace "$XCODE_WORKSPACE" -archivePath "$ARCHIVE_PATH" clean archive CODE_SIGN_IDENTITY="$DEVELOPER_NAME"

echo "********************"
echo "*    Signing     *"
echo "********************"

xcodebuild -exportArchive -exportFormat IPA -archivePath "$ARCHIVE_PATH" -exportPath "$APP_DIR/$APPNAME.ipa" -exportProvisioningProfile "$PROVISIONING_PROFILE_NAME"

#zip -r -9 "$DSYM_DIR/$APPNAME.app.dSYM.zip" "$DSYM_DIR/$APPNAME.app.dSYM"

echo "********************"
echo "*    Uploading     *"
echo "********************"

echo "$APP_DIR/$APPNAME.ipa";

./Crashlytics.framework/submit "$CRASHLYTICS_API" "$CRASHLYTICS_SECRET" -ipaPath "$APP_DIR/$APPNAME.ipa" -emails "$MAIL_LIST" -notifications YES

echo "*    Finish     *"