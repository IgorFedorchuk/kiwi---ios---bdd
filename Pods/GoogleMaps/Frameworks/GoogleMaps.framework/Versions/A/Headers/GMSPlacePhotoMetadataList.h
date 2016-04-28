//
//  GMSPlacePhotoMetadataList.h
//  Google Maps SDK for iOS
//
//  Copyright 2015 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <UIKit/UIKit.h>

#import <GoogleMaps/GMSCompatabilityMacros.h>
#import <GoogleMaps/GMSPlacePhotoMetadata.h>

GMS_ASSUME_NONNULL_BEGIN

/**
 * A list of |GMSPlacePhotoMetadata| objects.
 */
@interface GMSPlacePhotoMetadataList : NSObject

/**
 * The array of |GMSPlacePhotoMetadata| objects.
 */
@property(nonatomic, readonly, copy) GMS_NSArrayOf(GMSPlacePhotoMetadata *) * results;

@end

GMS_ASSUME_NONNULL_END
