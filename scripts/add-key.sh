#!/bin/sh

security create-keychain -p $KEYCHAIN_PASSWORD ios-build.keychain
security import ./scripts/apple.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./scripts/dist.p12 -k ~/Library/Keychains/ios-build.keychain -P $KEY_PASSWORD -T /usr/bin/codesign
security list-keychain -s ~/Library/Keychains/ios-build.keychain
security unlock-keychain -p $KEYCHAIN_PASSWORD ~/Library/Keychains/ios-build.keychain

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./scripts/dist.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
