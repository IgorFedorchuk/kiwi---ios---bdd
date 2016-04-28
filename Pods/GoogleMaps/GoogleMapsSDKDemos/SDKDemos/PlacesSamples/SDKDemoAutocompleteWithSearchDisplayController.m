#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithSearchDisplayController.h"

#import <GoogleMaps/GoogleMaps.h>

// The default height of a UISearchBar.
static CGFloat kSearchBarHeight = 44.0f;

@interface SDKDemoAutocompleteWithSearchDisplayController () <
    GMSAutocompleteTableDataSourceDelegate, UISearchDisplayDelegate>

@end

@implementation SDKDemoAutocompleteWithSearchDisplayController {
  UISearchBar *_searchBar;
  UISearchDisplayController *_searchDisplayController;
  GMSAutocompleteTableDataSource *_tableDataSource;
  UITextView *_resultView;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Don't overlay the status bar with the search bar when active.
  self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;

  self.view.backgroundColor = [UIColor whiteColor];

  _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             self.view.bounds.size.width,
                                                             kSearchBarHeight)];

  _tableDataSource = [[GMSAutocompleteTableDataSource alloc] init];
  _tableDataSource.delegate = self;

  _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar
                                                               contentsController:self];
  _searchDisplayController.searchResultsDataSource = _tableDataSource;
  _searchDisplayController.searchResultsDelegate = _tableDataSource;
  _searchDisplayController.delegate = self;
  _searchDisplayController.displaysSearchBarInNavigationBar = NO;

  _resultView =
      [[UITextView alloc] initWithFrame:CGRectMake(0,
                                                   kSearchBarHeight,
                                                   self.view.bounds.size.width,
                                                   self.view.bounds.size.width - kSearchBarHeight)];
  _resultView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _resultView.editable = NO;

  [self.view addSubview:_searchBar];
  [self.view addSubview:_resultView];
}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
    shouldReloadTableForSearchString:(NSString *)searchString
{
  [_tableDataSource sourceTextHasChanged:searchString];
  return NO;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
  [_tableDataSource sourceTextHasChanged:@""];
}

#pragma mark - GMSAutocompleteTableDataSourceDelegate

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
    didAutocompleteWithPlace:(GMSPlace *)place {
  NSMutableAttributedString *text =
      [[NSMutableAttributedString alloc] initWithString:[place description]];
  if (place.attributions) {
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    [text appendAttributedString:place.attributions];
  }
  _resultView.attributedText = text;
  [_searchDisplayController setActive:NO animated:YES];
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
    didFailAutocompleteWithError:(NSError *)error {
  _resultView.text =
      [NSString stringWithFormat:@"Autocomplete failed with error: %@", error.localizedDescription];
  [_searchDisplayController setActive:NO animated:YES];
}

- (void)didRequestAutocompletePredictionsForTableDataSource:
    (GMSAutocompleteTableDataSource *)tableDataSource {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  [_searchDisplayController.searchResultsTableView reloadData];
}

- (void)didUpdateAutocompletePredictionsForTableDataSource:
    (GMSAutocompleteTableDataSource *)tableDataSource {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [_searchDisplayController.searchResultsTableView reloadData];
}

@end
