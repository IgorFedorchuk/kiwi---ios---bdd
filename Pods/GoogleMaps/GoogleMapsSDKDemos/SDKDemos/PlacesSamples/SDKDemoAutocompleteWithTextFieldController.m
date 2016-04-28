#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "This file requires ARC support."
#endif

#import "SDKDemos/PlacesSamples/SDKDemoAutocompleteWithTextFieldController.h"

#import <GoogleMaps/GoogleMaps.h>

static const CGFloat kTextFieldHeight = 44.0;
static const CGFloat kTextFieldInset = 5.0;

// This demo shows how to manually present a UITableViewController and supply it with autocomplete
// text from an arbitrary source, in this case a UITextField.
@interface SDKDemoAutocompleteWithTextFieldController () <UITextFieldDelegate,
    GMSAutocompleteTableDataSourceDelegate>

@end

@implementation SDKDemoAutocompleteWithTextFieldController {
  UITextField *_searchField;
  UITableViewController *_resultsController;
  GMSAutocompleteTableDataSource *_tableDataSource;
  UITextView *_resultView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  _searchField =
      [[UITextField alloc] initWithFrame:CGRectMake(kTextFieldInset,
                                                    kTextFieldInset,
                                                    self.view.bounds.size.width -
                                                        (kTextFieldInset * 2),
                                                    kTextFieldHeight - (kTextFieldInset * 2))];
  _searchField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _searchField.borderStyle = UITextBorderStyleNone;
  _searchField.backgroundColor = [UIColor whiteColor];
  _searchField.placeholder = @"Pick a place";
  _searchField.autocorrectionType = UITextAutocorrectionTypeNo;
  _searchField.keyboardType = UIKeyboardTypeDefault;
  _searchField.returnKeyType = UIReturnKeyDone;
  _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
  _searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

  [_searchField addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
  _searchField.delegate = self;

  _resultView = [[UITextView alloc] initWithFrame:[self contentRect]];
  _resultView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _resultView.editable = NO;
  _resultView.text = @"Waiting...";
  _resultView.backgroundColor = [UIColor colorWithWhite:0.95f alpha: 1.0f];

  _tableDataSource = [[GMSAutocompleteTableDataSource alloc] init];
  _tableDataSource.delegate = self;
  _resultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
  _resultsController.tableView.delegate = _tableDataSource;
  _resultsController.tableView.dataSource = _tableDataSource;

  [self.view addSubview:_searchField];
  [self.view addSubview:_resultView];
}

#pragma mark - GMSAutocompleteTableDataSourceDelegate

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
    didAutocompleteWithPlace:(GMSPlace *)place {
  [_searchField resignFirstResponder];
  NSMutableAttributedString *text =
  [[NSMutableAttributedString alloc] initWithString:[place description]];
  if (place.attributions) {
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    [text appendAttributedString:place.attributions];
  }
  _resultView.attributedText = text;
  _searchField.text = place.name;
}

- (void)tableDataSource:(GMSAutocompleteTableDataSource *)tableDataSource
    didFailAutocompleteWithError:(NSError *)error {
  [_searchField resignFirstResponder];
  _resultView.text =
      [NSString stringWithFormat:@"Autocomplete failed with error: %@", error.localizedDescription];
  _searchField.text = @"";
}

- (void)didRequestAutocompletePredictionsForTableDataSource:
    (GMSAutocompleteTableDataSource *)tableDataSource {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  [_resultsController.tableView reloadData];
}

- (void)didUpdateAutocompletePredictionsForTableDataSource:
    (GMSAutocompleteTableDataSource *)tableDataSource {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  [_resultsController.tableView reloadData];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [self addChildViewController:_resultsController];
  _resultsController.view.frame = [self contentRect];
  _resultsController.view.alpha = 0.0f;
  [self.view addSubview:_resultsController.view];
  [_resultsController.tableView reloadData];
  [self.view layoutIfNeeded];
  [UIView animateWithDuration:0.5
                   animations:^{
                     _resultsController.view.alpha = 1.0f;
                   } ];
  [_resultsController didMoveToParentViewController:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [_resultsController willMoveToParentViewController:nil];
  [UIView animateWithDuration:0.5
                   animations:^{
                     _resultsController.view.alpha = 0.0f;
                   }
                   completion:^(BOOL finished) {
                     [_resultsController.view removeFromSuperview];
                     [_resultsController removeFromParentViewController];
                   }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}

#pragma mark - Private Methods

- (void)textFieldDidChange:(UITextField *)textField {
  [_tableDataSource sourceTextHasChanged:textField.text];
}

- (CGRect)contentRect {
  return CGRectMake(0, kTextFieldHeight, self.view.bounds.size.width,
                    self.view.bounds.size.height - kTextFieldHeight);
}

@end
