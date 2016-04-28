//
//  GMSPlacePhotoMetadata.h
//  Google Maps SDK for iOS
//
//  Copyright 2015 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <UIKit/UIKit.h>

#import <GoogleMaps/GMSCompatabilityMacros.h>

GMS_ASSUME_NONNULL_BEGIN

/**
 * The metadata corresponding to a single photo associated with a place.
 */
@interface GMSPlacePhotoMetadata : NSObject

/**
 * The data provider attribution string for this photo.
 *
 * These are provided as a NSAttributedString, which may contain hyperlinks to the website of each
 * provider.
 *
 * In general, these must be shown to the user if data from this GMSPlacePhotoMetadata is shown, as
 * described in the Places API Terms of Service.
 */
@property(nonatomic, readonly, copy) NSAttributedString* GMS_NULLABLE_PTR attributions;

/**
 * The maximum pixel size in which this photo is available.
 */
@property(nonatomic, readonly, assign) CGSize maxSize;

@end

GMS_ASSUME_NONNULL_END
