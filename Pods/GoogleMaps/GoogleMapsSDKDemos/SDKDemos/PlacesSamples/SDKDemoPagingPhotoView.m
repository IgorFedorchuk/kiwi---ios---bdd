#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/SDKDemoPagingPhotoView.h"

// Class to store the image and text views that display the image and attributions.
@interface SDKDemoImageViewAndAttribution : NSObject

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) UITextView *attributionView;

@end

@implementation SDKDemoImageViewAndAttribution
@end

@implementation SDKDemoAttributedPhoto
@end

@interface SDKDemoPagingPhotoView () <UITextViewDelegate>
@end

@implementation SDKDemoPagingPhotoView {
  // An array of |SDKDemoImageViewAndAttribution| objects representing the actual views that are
  // being displayed.
  NSMutableArray *_photoImageViews;
// Whether we should update the image and attribution view frames on the next |layoutSubviews|
  // call. This should be set to YES whenever the frame is updated or the photos change.
  BOOL _imageLayoutUpdateNeeded;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    _photoImageViews = [NSMutableArray array];
    self.pagingEnabled = YES;
  }
  return self;
}

- (void)setPhotoList:(NSArray *)photoList {
  // First, remove all of the existing image and attribution subviews.
  for (SDKDemoImageViewAndAttribution *photoView in _photoImageViews) {
    [photoView.imageView removeFromSuperview];
    [photoView.attributionView removeFromSuperview];
  }
  [_photoImageViews removeAllObjects];

  // Add the new images and attributions as subviews.
  _photoList = [photoList copy];
  for (SDKDemoAttributedPhoto *photo in photoList) {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.delegate = self;
    textView.editable = NO;
    textView.attributedText = photo.attributions;
    [self addSubview:textView];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:photo.image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];

    SDKDemoImageViewAndAttribution *attributedView = [[SDKDemoImageViewAndAttribution alloc] init];
    attributedView.imageView = imageView;
    attributedView.attributionView = textView;
    [_photoImageViews addObject:attributedView];
  }
  [self updateContentSize];
  _imageLayoutUpdateNeeded = YES;
}

- (void)setFrame:(CGRect)frame {
  _imageLayoutUpdateNeeded = YES;

  // We want to make sure that we are still scrolled to the same photo when the frame changes.
  // Measure the current content offset and scroll to the same fraction along the content after the
  // frame change.
  CGFloat scrollOffsetFraction = 0;
  if (self.contentSize.width != 0) {
    scrollOffsetFraction = self.contentOffset.x / self.contentSize.width;
  }
  [super setFrame:frame];
  [self updateContentSize];
  self.contentOffset = CGPointMake(scrollOffsetFraction * self.contentSize.width, 0);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (_imageLayoutUpdateNeeded) {
    [self layoutImages];
    _imageLayoutUpdateNeeded = NO;
  }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView
    shouldInteractWithURL:(NSURL *)url
                  inRange:(NSRange)characterRange {
  // Make links clickable.
  return YES;
}

#pragma mark - Helper methods

// Update the content size of the scroll view based on the number of photos and the view's width.
// This should be called whenever the frame changes or the number of photos has changed.
- (void)updateContentSize {
  self.contentSize = CGSizeMake(_photoImageViews.count * self.frame.size.width,
                                self.frame.size.height);
}

// Updates the frames of the images and attributions.
- (void)layoutImages {
  CGFloat contentWidth = 0;
  CGFloat scrollViewWidth = self.frame.size.width;

  // Lay out the images one after the other horizontally.
  for (SDKDemoImageViewAndAttribution *attributedImageView in _photoImageViews) {
    UITextView *attributionView = attributedImageView.attributionView;
    UIImageView *imageView = attributedImageView.imageView;
    [attributionView sizeToFit];
    CGFloat attributionHeight = attributionView.frame.size.height;
    CGFloat imageHeight = self.frame.size.height - attributionHeight;

    // Put the attribution view aligned to the same left edge as the photo, in the bottom left
    // corner of the screen.
    attributionView.frame = CGRectMake(contentWidth,
                                       imageHeight,
                                       scrollViewWidth,
                                       attributionHeight);
    imageView.frame = CGRectMake(contentWidth, 0, scrollViewWidth, imageHeight);
    contentWidth += imageView.frame.size.width;
  }
}

@end
