#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/SDKDemoPhotosViewController.h"

#import "SDKDemos/PlacesSamples/SDKDemoPagingPhotoView.h"
#import "SDKDemos/SDKDemoAPIKey.h"

@implementation SDKDemoPhotosViewController {
  GMSPlacePicker *_placePicker;
  GMSPlacesClient *_placesClient;
  SDKDemoPagingPhotoView *_photoView;
  UIActivityIndicatorView *_indicatorView;
  NSMapTable *_imagesByPhoto;
}

- (instancetype)init {
  if ((self = [super init])) {
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:nil];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    _placesClient = [GMSPlacesClient sharedClient];
    _imagesByPhoto = [NSMapTable strongToStrongObjectsMapTable];
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _photoView = [[SDKDemoPagingPhotoView alloc] initWithFrame:self.view.bounds];
  _photoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:_photoView];
  _indicatorView = [[UIActivityIndicatorView alloc]
      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  _indicatorView.autoresizingMask =
      UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleTopMargin |
      UIViewAutoresizingFlexibleRightMargin |
      UIViewAutoresizingFlexibleBottomMargin;
  _indicatorView.center = _photoView.center;
  [_indicatorView startAnimating];
  [self.view addSubview:_indicatorView];
  [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
    if (place) {
      [_placesClient lookUpPhotosForPlaceID:place.placeID
                                   callback:^(GMSPlacePhotoMetadataList * photos,
                                              NSError * __nullable photoError) {
                                     if (photos != nil) {
                                       [self displayPhotoList:photos];
                                     }
                                     else {
                                       NSLog(@"Photo metadata lookup failed: %@", photoError);
                                     }
                                   }];
    } else if (error) {
      NSLog(@"Place picking failed with error: %@", error);
    } else {
      NSLog(@"Place picking cancelled.");
    }
  }];
}

#pragma mark - Private methods

// Displays a list of photos.
- (void)displayPhotoList:(GMSPlacePhotoMetadataList *)photos {
  // Create a dispatch group for photo requests. We will enter this group immediately before making
  // each photo request, and leave when the request completes. This provides a mechanism for waiting
  // for all of the photo requests to complete.
  dispatch_group_t photoRequestGroup = dispatch_group_create();
  for (GMSPlacePhotoMetadata *photo in photos.results) {
    dispatch_group_enter(photoRequestGroup);
    [_placesClient loadPlacePhoto:photo callback:^(UIImage * photoImage, NSError * error) {
      if (photoImage == nil) {
        NSLog(@"Photo request failed with error: %@", error);
      } else {
        [_imagesByPhoto setObject:photoImage forKey:photo];
      }
      dispatch_group_leave(photoRequestGroup);
    }];
  }

  // The block will be called once all photo requests have completed.
  dispatch_group_notify(photoRequestGroup, dispatch_get_main_queue(), ^{
    NSMutableArray *attributedPhotos = [NSMutableArray array];
    for (GMSPlacePhotoMetadata *photo in photos.results) {
      UIImage *image = [_imagesByPhoto objectForKey:photo];
      if (image == nil) {
        continue;
      }
      SDKDemoAttributedPhoto *attributedPhoto = [[SDKDemoAttributedPhoto alloc] init];
      attributedPhoto.image = image;
      attributedPhoto.attributions = photo.attributions;
      [attributedPhotos addObject:attributedPhoto];
    }
    _photoView.photoList = attributedPhotos;
    [_indicatorView stopAnimating];
  });
}

@end
