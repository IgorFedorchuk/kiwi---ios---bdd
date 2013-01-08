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
            [[viewController should] conformToProtocol:@protocol(StackOverflowRequestDelegate)];
        });
        
        it(@"IFViewController should has tableView", ^
        {
            UITableView *tableView = (UITableView *)[viewController valueForPropertyName:@"tableView"];
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
        
        it(@"ISpinerView will be hidden after request is finished", ^
        {
            [viewController receivedJSON:[NSDictionary mock]];
            UIView *spinerView = (UIView *)[viewController valueForPropertyName:@"spinerView"];
            [[theValue(spinerView.hidden) should] equal:theValue(YES)];
            
            [viewController fetchFailedWithError:[NSError mock]];
            spinerView = (UIView *)[viewController valueForPropertyName:@"spinerView"];
            [[theValue(spinerView.hidden) should] equal:theValue(YES)];
        });
        
    });
});

SPEC_END
