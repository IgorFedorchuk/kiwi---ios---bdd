#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/Samples+Places.h"

#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWidgetViewController.h"
#import "SDKDemos/PlacesSamples/SDKDemoPhotosViewController.h"
#import "SDKDemos/PlacesSamples/SDKDemoPlacePickerViewController.h"

@implementation Samples (Places)

+ (NSArray *)placesDemos {
  return @[
    [Samples newDemo:[SDKDemoPlacePickerViewController class]
           withTitle:@"Places API Place Picker"
      andDescription:nil],
    [Samples newDemo:[SDKDemoAutocompleteWidgetViewController class]
           withTitle:@"Places API Autocomplete Widget"
      andDescription:nil],
    [Samples newDemo:[SDKDemoPhotosViewController class]
           withTitle:@"Places API Photos"
      andDescription:nil],
    ];
}

@end
