#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithSearchController.h"

#import <GoogleMaps/GoogleMaps.h>

@interface SDKDemoAutocompleteWithSearchController () <GMSAutocompleteResultsViewControllerDelegate>

@end


@implementation SDKDemoAutocompleteWithSearchController {
  UISearchController *_searchController;
  GMSAutocompleteResultsViewController *_acViewController;
  UITextView *_resultView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  _resultView = [[UITextView alloc] initWithFrame:self.view.bounds];
  _resultView.editable = NO;
  _resultView.text = @"Waiting...";
  [_resultView setUserInteractionEnabled:YES];
  [self.view addSubview:_resultView];

  _acViewController = [[GMSAutocompleteResultsViewController alloc] init];
  _acViewController.delegate = self;

  _searchController = [[UISearchController alloc]
                       initWithSearchResultsController:_acViewController];
  _searchController.hidesNavigationBarDuringPresentation = NO;
  _searchController.dimsBackgroundDuringPresentation = YES;

  _searchController.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;

  [_searchController.searchBar sizeToFit];
  self.navigationItem.titleView = _searchController.searchBar;
  self.definesPresentationContext = YES;

  // Work around a UISearchController bug that doesn't reposition the table view correctly when
  // rotating to landscape.
  self.edgesForExtendedLayout = UIRectEdgeAll;
  self.extendedLayoutIncludesOpaqueBars = YES;

  _searchController.searchResultsUpdater = _acViewController;
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    _searchController.modalPresentationStyle = UIModalPresentationPopover;
  } else {
    _searchController.modalPresentationStyle = UIModalPresentationFullScreen;
  }

  if ([[UIDevice currentDevice].systemVersion intValue] < 8) {
    _resultView.text = @"UISearchController not supported on this version of iOS";
  }
}

#pragma mark - GMSAutocompleteResultsViewControllerDelegate

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
  [_searchController setActive:NO];
  NSMutableAttributedString *text =
      [[NSMutableAttributedString alloc] initWithString:[place description]];
  if (place.attributions) {
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    [text appendAttributedString:place.attributions];
  }
  _resultView.attributedText = text;
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
    didFailAutocompleteWithError:(NSError *)error {
  [_searchController setActive:NO];
  _resultView.text =
      [NSString stringWithFormat:@"Autocomplete failed with error: %@", error.localizedDescription];
}

- (void)didRequestAutocompletePredictionsForResultsController:
    (GMSAutocompleteResultsViewController *)resultsController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
    (GMSAutocompleteResultsViewController *)resultsController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
