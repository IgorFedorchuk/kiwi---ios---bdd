#import "Kiwi.h"
#import "IFViewController.h"
#import <objc/runtime.h>
#import "NSObject+Properties.h"


SPEC_BEGIN(IFViewControllerSpec)

describe(@"IFViewController", ^{
    
    context(@"a state the component is in", ^{
        __block IFViewController *viewController = nil;
        
        beforeAll(^{ // Occurs once
        });
        
        afterAll(^{ // Occurs once
        });
        
        beforeEach(^{
            
            viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPhone" bundle:nil];

            UIView *aView = viewController.view;
            aView = nil;
        });
        
        afterEach(^{ // Occurs after each enclosed "it"
        });
        
        it(@"should not be nil and conforms protocol UITableViewDataSource && UITableViewDelegate", ^{
            [viewController shouldNotBeNil];
            [[viewController should] conformToProtocol:@protocol(UITableViewDataSource)];
            [[viewController should] conformToProtocol:@protocol(UITableViewDelegate)];
        });
        
        it(@"IFViewController should has tableView", ^
        {
            UITableView *tableView = (UITableView *)[viewController valueForPropertyName:@"spinerView"];
            [tableView shouldNotBeNil];                    
        });
        
        it(@"IFViewController should has text on navBar", ^
        {
            NSString *text = viewController.navigationItem.title;
            [text shouldNotBeNil];
        });
        
        it(@"IFViewController should has SpinerView", ^
        {
            UIView *spinerView = (UIView *)[viewController valueForPropertyName:@"spinerView"];
            [spinerView shouldNotBeNil];
           
        });
        
        it(@"ISpinerView will not be hidden after viewDidAppear", ^
           {
               [viewController viewDidAppear:YES];
               UIView *spinerView = (UIView *)[viewController valueForPropertyName:@"spinerView"];
               
               [[theValue(spinerView.hidden) should] equal:theValue(NO)];
           });
        
    });
});

SPEC_END
