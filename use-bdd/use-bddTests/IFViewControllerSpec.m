#import "Kiwi.h"
#import "IFViewController.h"
#import "NSObject+Properties.h"

SPEC_BEGIN(IFViewControllerSpec)

describe(@"IFViewController", ^{
    
    context(@"a state the component is in", ^
    {   
        __block IFViewController *viewController = nil;
        
        beforeAll(^{ // Occurs once
        });
        
        afterAll(^{ // Occurs once
        });
        
        beforeEach(^{
            
            viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPhone" bundle:nil];

            UIView *aView = viewController.view; // lazy load
            aView = nil;
        });
        
        afterEach(^
        {
            viewController = nil;
        });
        
        it(@"IFViewController should has tableView", ^
        {
            UITableView *tableView = (UITableView *)[viewController objectForPropertyName:@"tableView"];
            [tableView shouldNotBeNil];
            id dataSource = tableView.dataSource;
            [dataSource shouldNotBeNil];
            
            id delegate = tableView.delegate;
            [delegate shouldNotBeNil];
        });
        
        it(@"IFViewController should has text on navBar", ^
        {
            NSString *text = viewController.navigationItem.title;
            [text shouldNotBeNil];
        });
        
        it(@"IFViewController should has SpinerView", ^
        {
            UIView *spinerView = (UIView *)[viewController objectForPropertyName:@"spinerView"];
            [spinerView shouldNotBeNil];
        });
    });
});

SPEC_END
