//
//  GMSIndoorBuilding.h
//  Google Maps SDK for iOS
//
//  Copyright 2013 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//


#import <Foundation/Foundation.h>

#import <GoogleMaps/GMSCompatabilityMacros.h>

GMS_ASSUME_NONNULL_BEGIN

@class GMSIndoorLevel;

/**
 * Describes a building which contains levels.
 */
@interface GMSIndoorBuilding : NSObject

/**
 * Array of GMSIndoorLevel describing the levels which make up the building.
 * The levels are in 'display order' from top to bottom.
 */
@property(nonatomic, strong, readonly) GMS_NSArrayOf(GMSIndoorLevel *) * levels;

/**
 * Index in the levels array of the default level.
 */
@property(nonatomic, assign, readonly) NSUInteger defaultLevelIndex;

/**
 * If YES, the building is entirely underground and supports being hidden.
 */
@property(nonatomic, assign, readonly, getter=isUnderground) BOOL underground;

@end

GMS_ASSUME_NONNULL_END
