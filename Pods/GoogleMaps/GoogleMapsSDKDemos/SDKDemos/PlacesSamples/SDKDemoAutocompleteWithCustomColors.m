#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemoAutocompleteWithCustomColors.h"

#import <GoogleMaps/GoogleMaps.h>

/** Height of buttons in this controller's UI */
static const CGFloat kButtonHeight = 44.0f;

/**
 * Simple subclass of GMSAutocompleteViewController solely for the purpose of localising appearance
 * proxy changes to this part of the demo app.
 */
@interface GMSStyledAutocompleteViewController : GMSAutocompleteViewController
@end

@implementation GMSStyledAutocompleteViewController

- (instancetype)init {
  self = [super init];
  return self;
}

@end

@interface SDKDemoAutocompleteWithCustomColors () <GMSAutocompleteViewControllerDelegate>

@end

@implementation SDKDemoAutocompleteWithCustomColors {
  UIButton *_brownThemeButton;
  UIButton *_blackThemeButton;
  UIButton *_blueThemeButton;
  UIButton *_hotDogThemeButton;

  UITextView *_resultView;

  UIColor *_backgroundColor;
  UIColor *_darkBackgroundColor;
  UIColor *_primaryTextColor;
  UIColor *_highlightColor;
  UIColor *_secondaryColor;
  UIColor *_separatorColor;
  UIColor *_tintColor;
  UIColor *_searchBarTintColor;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    self.edgesForExtendedLayout = UIRectEdgeNone;

  self.view.backgroundColor = [UIColor whiteColor];

  CGFloat nextControlY = 0.0f;
  _brownThemeButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [_brownThemeButton setTitle:@"Yellow and Brown" forState:UIControlStateNormal];
  _brownThemeButton.frame = CGRectMake(0, nextControlY, self.view.bounds.size.width, kButtonHeight);
  _brownThemeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [_brownThemeButton addTarget:self
                               action:@selector(didTapButton:)
                     forControlEvents:UIControlEventTouchUpInside];
  nextControlY += kButtonHeight;

  _blackThemeButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [_blackThemeButton setTitle:@"White on Black" forState:UIControlStateNormal];
  _blackThemeButton.frame = CGRectMake(0, nextControlY, self.view.bounds.size.width, kButtonHeight);
  _blackThemeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [_blackThemeButton addTarget:self
                        action:@selector(didTapButton:)
              forControlEvents:UIControlEventTouchUpInside];
  nextControlY += kButtonHeight;

  _blueThemeButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [_blueThemeButton setTitle:@"Blue Colors" forState:UIControlStateNormal];
  _blueThemeButton.frame = CGRectMake(0, nextControlY, self.view.bounds.size.width, kButtonHeight);
  _blueThemeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [_blueThemeButton addTarget:self
                        action:@selector(didTapButton:)
              forControlEvents:UIControlEventTouchUpInside];
  nextControlY += kButtonHeight;

  _hotDogThemeButton = [UIButton buttonWithType:UIButtonTypeSystem];
  [_hotDogThemeButton setTitle:@"Hot Dog Stand" forState:UIControlStateNormal];
  _hotDogThemeButton.frame = CGRectMake(0, nextControlY, self.view.bounds.size.width,
                                        kButtonHeight);
  _hotDogThemeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [_hotDogThemeButton addTarget:self
                         action:@selector(didTapButton:)
               forControlEvents:UIControlEventTouchUpInside];
  nextControlY += kButtonHeight;

  _resultView =
      [[UITextView alloc] initWithFrame:CGRectMake(0,
                                                   nextControlY,
                                                   self.view.bounds.size.width,
                                                   self.view.bounds.size.height - nextControlY)];
  _resultView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _resultView.editable = NO;

  [self.view addSubview:_brownThemeButton];
  [self.view addSubview:_blackThemeButton];
  [self.view addSubview:_blueThemeButton];
  [self.view addSubview:_hotDogThemeButton];
  [self.view addSubview:_resultView];

  self.definesPresentationContext = YES;

}

- (void)didTapButton:(UIButton *)button {
  if (button == _brownThemeButton) {
    _backgroundColor = [UIColor colorWithRed:215.0f/255.0f
                                       green:204.0f/255.0f
                                        blue:200.0f/255.0f
                                       alpha:1.0f];
    _darkBackgroundColor = [UIColor colorWithRed:93.0f/255.0f
                                           green:64.0f/255.0f
                                            blue:55.0f/255.0f
                                           alpha:1.0f];
    _primaryTextColor = [UIColor colorWithWhite:0.33f alpha:1.0f];

    _highlightColor = [UIColor colorWithRed:255.0f/255.0f
                                      green:235.0f/255.0f
                                       blue:59.0f/255.0f
                                      alpha:1.0f];
    _secondaryColor = [UIColor colorWithWhite:114.0f/255.0f alpha: 1.0f];
    _tintColor = [UIColor colorWithRed:219/255.0f
                                 green:207/255.0f
                                  blue:28/255.0f
                                 alpha:1.0f];
    _searchBarTintColor = [UIColor yellowColor];
    _separatorColor = [UIColor colorWithWhite:182.0f/255.0f alpha:1.0f];
  } else if (button == _blueThemeButton) {
    _backgroundColor = [UIColor colorWithRed:225.0f/255.0f
                                       green:241.0f/255.0f
                                        blue:252.0f/255.0f
                                       alpha:1.0f];
    _darkBackgroundColor = [UIColor colorWithRed:187.0f/255.0f
                                           green:222.0f/255.0f
                                            blue:248.0f/255.0f
                                           alpha:1.0f];
    _primaryTextColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    _highlightColor = [UIColor colorWithRed:76.0f/255.0f
                                      green:175.0f/255.0f
                                       blue:248.0f/255.0f
                                      alpha:1.0f];
    _secondaryColor = [UIColor colorWithWhite:0.5f alpha:0.65f];
    _tintColor = [UIColor colorWithRed:0/255.0f
                                 green:142/255.0f
                                  blue:248.0f/255.0f
                                 alpha:1.0f];
    _searchBarTintColor = _tintColor;
    _separatorColor = [UIColor colorWithWhite:0.5f alpha:0.65f];
  } else if (button == _blackThemeButton) {
    _backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    _darkBackgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    _primaryTextColor = [UIColor whiteColor];
    _highlightColor = [UIColor colorWithRed:0.75f green:1.0f blue:0.75f alpha:1.0f];
    _secondaryColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
    _tintColor = [UIColor whiteColor];
    _searchBarTintColor = _tintColor;
    _separatorColor = [UIColor colorWithRed:0.5f green:0.75f blue:0.5f alpha:0.30f];
  } else if (button == _hotDogThemeButton) {
    _backgroundColor = [UIColor yellowColor];
    _darkBackgroundColor = [UIColor redColor];
    _primaryTextColor = [UIColor blackColor];
    _highlightColor = [UIColor redColor];
    _secondaryColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    _tintColor = [UIColor redColor];
    _searchBarTintColor = [UIColor whiteColor];
    _separatorColor = [UIColor redColor];
  }
  [self presentAutocompleteController];
}

- (void)presentAutocompleteController {
  // Use UIAppearance proxies to change the appearance of UI controls in
  // GMSAutocompleteViewController. Here we use appearanceWhenContainedIn to localise changes to
  // just this part of the Demo app. This will generally not be necessary in a real application as
  // you will probably want the same theme to apply to all elements in your app.
  [[UIActivityIndicatorView appearanceWhenContainedIn:[GMSStyledAutocompleteViewController class],
      nil] setColor:_primaryTextColor];

  [[UINavigationBar appearanceWhenContainedIn:[GMSStyledAutocompleteViewController class], nil]
      setBarTintColor:_darkBackgroundColor];
  [[UINavigationBar appearanceWhenContainedIn:[GMSStyledAutocompleteViewController class], nil]
      setTintColor:_searchBarTintColor];

  // Color of typed text in search bar.
  NSDictionary *searchBarTextAttributes = @{
      NSForegroundColorAttributeName: _searchBarTintColor,
      NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]
  };
  [[UITextField appearanceWhenContainedIn:[GMSStyledAutocompleteViewController class], nil]
      setDefaultTextAttributes:searchBarTextAttributes];

  // Color of the "Search" placeholder text in search bar. For this example, we'll make it the same
  // as the bar tint color but with added transparency.
  CGFloat increasedAlpha = CGColorGetAlpha(_searchBarTintColor.CGColor) * 0.75f;
  UIColor *placeHolderColor = [_searchBarTintColor colorWithAlphaComponent:increasedAlpha];

  NSDictionary *placeholderAttributes = @{
      NSForegroundColorAttributeName: placeHolderColor,
      NSFontAttributeName : [UIFont systemFontOfSize:[UIFont systemFontSize]]
  };
  NSAttributedString *attributedPlaceholder =
      [[NSAttributedString alloc] initWithString:@"Search"
                                      attributes:placeholderAttributes];

  [[UITextField appearanceWhenContainedIn:[GMSStyledAutocompleteViewController class], nil]
      setAttributedPlaceholder:attributedPlaceholder];

  // Depending on the navigation bar background color, it might also be necessary to customise the
  // icons displayed in the search bar to something other than the default. The
  // setupSearchBarCustomIcons contains example code to do this.

  GMSAutocompleteViewController *acController = [[GMSStyledAutocompleteViewController alloc] init];
  acController.delegate = self;
  acController.tableCellBackgroundColor = _backgroundColor;
  acController.tableCellSeparatorColor = _separatorColor;
  acController.primaryTextColor = _primaryTextColor;
  acController.primaryTextHighlightColor = _highlightColor;
  acController.secondaryTextColor = _secondaryColor;
  acController.tintColor = _tintColor;

  [self presentViewController:acController animated:YES completion:nil];
}

// This method shows how to replace the "search" and "clear text" icons in the search bar with
// custom icons in the case where the default gray icons don't match a custom background.
- (void)setupSearchBarCustomIcons {
  id searchBarAppearanceProxy =
      [UISearchBar appearanceWhenContainedIn:[GMSStyledAutocompleteViewController class], nil];
  [searchBarAppearanceProxy setImage:[UIImage imageNamed:@"custom_clear_x_high"]
                    forSearchBarIcon:UISearchBarIconClear
                               state:UIControlStateHighlighted];
  [searchBarAppearanceProxy setImage:[UIImage imageNamed:@"custom_clear_x"]
                    forSearchBarIcon:UISearchBarIconClear
                               state:UIControlStateNormal];
  [searchBarAppearanceProxy setImage:[UIImage imageNamed:@"custom_search"]
                    forSearchBarIcon:UISearchBarIconSearch
                               state:UIControlStateNormal];
}

#pragma mark - GMSAutocompleteViewControllerDelegate

- (void)viewController:(GMSAutocompleteViewController *)viewController
    didAutocompleteWithPlace:(GMSPlace *)place {
  [self dismissViewControllerAnimated:YES completion:nil];
  NSMutableAttributedString *text =
      [[NSMutableAttributedString alloc] initWithString:[place description]];
  if (place.attributions) {
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    [text appendAttributedString:place.attributions];
  }
  _resultView.attributedText = text;
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
    didFailAutocompleteWithError:(NSError *)error {
  [self dismissViewControllerAnimated:YES completion:nil];
  _resultView.text = [NSString stringWithFormat:@"Autocomplete failed with error: %@", error];
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
  [self dismissViewControllerAnimated:YES completion:nil];
  _resultView.text = @"Autocomplete Cancelled.";
}

- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
