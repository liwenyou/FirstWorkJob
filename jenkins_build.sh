TIME=$(date "+%Y-%m-%d_%H:%M:%S")
WORK_SPACE=WORK_SPACE.xcworkspace
IPA_DIR=/data/env/download/download/ios/app/ipa
BUILD_DIR=$WORKSPACE/build
EXPORTPATH=$WORKSPACE/archive
IPA=Release.ipa
TEMP_NAME=${BUILD_NUMBER}_${BRANCH}_${TIME}
newIPA=$TEMP_NAME.ipa
PLIST=$EXPORTPATH/$TEMP_NAME.plist
ARCHIVEPATH=$BUILD_DIR/WORK_SPACE.xcarchive
#EXPORTOPTIONSPLIST=/Users/macmini/enterprise.plist


#chmod +x modify_project.py
#./modify_project.py
#carthage update --platform iOS --cache-builds
security unlock-keychain -p wwww /Users/liwenyou/Library/Keychains/login.keychain

DATE_ICON=$(date "+%Y/%m/%d")
TIME_ICON=$(date "+%H:%M:%S")

#ICON_PATH="${WORKSPACE}/WORK_SPACE/Images.xcassets/AppIcon.appiconset"
#convert -background '#0008' -fill white -gravity center -size 120x90  caption:"${BRANCH}\n${BUILD_NUMBER}\n${DATE_ICON}\n${TIME_ICON}" ${ICON_PATH}/icon@2x.png +swap -gravity south -composite ${ICON_PATH}/icon@2x.png
#convert -background '#0008' -fill white -gravity center -size 180x135 caption:"${BRANCH}\n${BUILD_NUMBER}\n${DATE_ICON}\n${TIME_ICON}" ${ICON_PATH}/icon@3x.png +swap -gravity south -composite ${ICON_PATH}/icon@3x.png


xcodebuild -workspace $WORK_SPACE -scheme Release -configuration Release  clean
xcodebuild -workspace $WORK_SPACE -scheme Release -configuration Release -sdk iphoneos -archivePath $ARCHIVEPATH CODE_SIGN_IDENTITY="Apple Distribution: Wenyou Leo (TARPWKMCQK)" archive
xcodebuild -exportArchive -archivePath $ARCHIVEPATH -exportPath $EXPORTPATH -exportOptionsPlist ~/enterprise.plist
cp ${WORKSPACE}/build/WORK_SPACE.xcarchive/Info.plist ${EXPORTPATH}

echo ${EXPORTPATH}

#cp $EXPORTPATH/$IPA $EXPORTPATH/$newIPA
#ssh mwteam@mt01.fengjr.inc "[ -d $IPA_DIR/$BRANCH ] && rm -fr $IPA_DIR/$BRANCH/*   || mkdir -p $IPA_DIR/$BRANCH/"
#scp $EXPORTPATH/$newIPA mwteam@mt01.fengjr.inc:$IPA_DIR/$BRANCH/
#
#
#APP_VERSION=$(/usr/libexec/PlistBuddy -c "Print :ApplicationProperties:CFBundleShortVersionString" $EXPORTPATH/Info.plist)
#
#echo "<?xml version="1.0" encoding="UTF-8"?>
#<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
#<plist version="1.0">
#<dict>
#    <key>items</key>
#    <array>
#        <dict>
#            <key>assets</key>
#            <array>
#                <dict>
#                    <key>kind</key>
#                    <string>software-package</string>
#                    <key>url</key>
#                    <string>https://mt01.fengjr.com/download/ios/app/ipa/$BRANCH/$newIPA</string>
#                </dict>
#                <dict>
#                    <key>kind</key>
#                    <string>display-image</string>
#                    <key>url</key>
#                    <string>https://mt01.fengjr.com/download/ios/app/display-image.png</string>
#                </dict>
#                <dict>
#                    <key>kind</key>
#                    <string>full-size-image</string>
#                    <key>url</key>
#                    <string>https://mt01.fengjr.com/download/ios/app/full-size-image.png</string>
#                </dict>
#            </array>
#            <key>metadata</key>
#            <dict>
#                <key>bundle-identifier</key>
#                <string>com.fengjr.mobilePrivate</string>
#                <key>bundle-version</key>
#                <string>$APP_VERSION</string>
#                <key>kind</key>
#                <string>software</string>
#                <key>title</key>
#                <string>凤凰金融</string>
#            </dict>
#        </dict>
#    </array>
#</dict>
#</plist>" > $PLIST
#
#scp $PLIST mwteam@mt01.fengjr.inc:/data/env/download/download/ios/app/ipa/$BRANCH/
