#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWidgetViewController.h"

#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithCustomColors.h"
#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithSearchController.h"
#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithSearchDisplayController.h"
#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithTextFieldController.h"
#import <GoogleMaps/GoogleMaps.h>

// row indexes for the menu table.
enum {
  // Full-screen presented widget.
  kPresented = 0,
  // Full-screen pushed-onto-navcontroller widget.
  kPushed = 1,
  // Implementation using UISearchController (iOS 8+).
  kSearchController = 2,
  // Implementation using UISearchDisplayController.
  kSearchDisplayController = 3,
  // Implementation using a UITextField for text entry.
  kTextField = 4,
  // Full-screen presented widget with custom colors
  kCustomColors = 5
};

// Demo of the various ways in which GMSAutocompleteViewController can be used to provide an
// autocomplete widget.
@interface SDKDemoAutocompleteWidgetViewController () <GMSAutocompleteViewControllerDelegate>

@end

@implementation SDKDemoAutocompleteWidgetViewController {
  UITableView *_menuTable;
  UITextView *_resultView;
  NSArray *_tableCellNames;
  GMSAutocompleteViewController *_acController;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  _tableCellNames = @[ @"Present Full-Screen",
                       @"Push Full-Screen",
                       @"UISearchController",
                       @"UISearchDisplayController",
                       @"UITextField",
                       @"Custom Colors"];

  self.view.backgroundColor = [UIColor whiteColor];

  // Calculate the table height so that all rows are displayed.
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:@"Cell"];
  CGFloat tableHeight = _tableCellNames.count * cell.frame.size.height;

  _menuTable = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             self.view.bounds.size.width,
                                                             tableHeight)];
  _menuTable.delegate = self;
  _menuTable.dataSource = self;
  _menuTable.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:_menuTable];

  _resultView =
      [[UITextView alloc] initWithFrame:CGRectMake(0,
                                                   tableHeight,
                                                   self.view.bounds.size.width,
                                                   self.view.bounds.size.height - tableHeight)];
  _resultView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _resultView.editable = NO;
  [self.view addSubview:_resultView];

  _acController = [[GMSAutocompleteViewController alloc] init];
  _acController.delegate = self;
}

#pragma mark - GMSAutocompleteViewControllerDelegate

- (void)viewController:(GMSAutocompleteViewController *)viewController
    didAutocompleteWithPlace:(GMSPlace *)place {
  [self dismissFullScreenAutocompleteWidget];
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
  [self dismissFullScreenAutocompleteWidget];
  _resultView.text = [NSString stringWithFormat:@"Autocomplete failed with error: %@", error];
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
  [self dismissFullScreenAutocompleteWidget];
  _resultView.text = @"Autocomplete Cancelled.";
}

- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"Cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  cell.textLabel.text = _tableCellNames[indexPath.row];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _tableCellNames.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.row) {
    case kPresented: {
      [self presentViewController:_acController animated:YES completion:nil];
      // Work around an iOS bug where the main event loop sometimes doesn't wake up to process the
      // presentation of the view controller (http://openradar.appspot.com/19563577).
      dispatch_async(dispatch_get_main_queue(), ^{});
      break;
    }
    case kPushed: {
      GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
      acController.delegate = self;
      [self.navigationController pushViewController:acController animated:YES];
      break;
    }
    case kSearchController:
      [self.navigationController
          pushViewController:[[SDKDemoAutocompleteWithSearchController alloc] init]
                    animated:YES];
      break;
    case kSearchDisplayController:
      [self.navigationController
          pushViewController:[[SDKDemoAutocompleteWithSearchDisplayController alloc] init]
                    animated:YES];
      break;
    case kTextField:
      [self.navigationController
          pushViewController:[[SDKDemoAutocompleteWithTextFieldController alloc] init]
                    animated:YES];
      break;
    case kCustomColors: {
      [self.navigationController
          pushViewController:[[SDKDemoAutocompleteWithCustomColors alloc] init]
                    animated:YES];
      break;
    }
  }
}

#pragma mark - Private Methods

/**
 * Helper method to dismiss the GMSAutocompleteViewController in both the presented and pushed
 * cases.
 */
- (void)dismissFullScreenAutocompleteWidget {
  if (self.presentedViewController) {
    [self dismissViewControllerAnimated:YES completion:nil];
  } else if ([self.navigationController.topViewController
      isKindOfClass:[GMSAutocompleteViewController class]]) {
    [self.navigationController popToViewController:self animated:YES];
  }
}

@end
