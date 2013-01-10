#import "Kiwi.h"
#import "IFViewController.h"
#import <objc/runtime.h>
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
        
        afterEach(^{ // Occurs after each enclosed "it"
        });
        
        it(@"should not be nil and conform StackOverflowRequestDelegate protocol", ^
        {
            [viewController shouldNotBeNil];
            [[viewController should] conformToProtocol:@protocol(StackOverflowRequestDelegate)];
            [[viewController should] conformToProtocol:@protocol(QuestionTableDelegate)];
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
        
        it(@"SpinerView will be hidden after request is finished", ^
        {
            [viewController receivedJSON:[NSDictionary dictionary]];
            UIView *spinerView = (UIView *)[viewController objectForPropertyName:@"spinerView"];
            [[theValue(spinerView.hidden) should] equal:theValue(YES)];
            
            [viewController fetchFailedWithError:[NSError mock]];
            spinerView = (UIView *)[viewController objectForPropertyName:@"spinerView"];
            [[theValue(spinerView.hidden) should] equal:theValue(YES)];
        });
        
        it(@"if request fail then currentPageRequest should not been changed", ^
        {
            NSInteger currenrPageRequest = [viewController integerValueForPropertyName:@"currentPageRequest"];
            [viewController fetchFailedWithError:[NSError mock]];
            
             NSInteger newPageRequest = [viewController integerValueForPropertyName:@"currentPageRequest"];
            [[theValue(currenrPageRequest) should] equal:theValue(newPageRequest)];
        });
        
        it(@"if request success then currentPageRequest should not been changed", ^
        {
            NSInteger currenrPageRequest = [viewController integerValueForPropertyName:@"currentPageRequest"];
            [viewController receivedJSON:[NSDictionary dictionary]];
               
            NSInteger newPageRequest = [viewController integerValueForPropertyName:@"currentPageRequest"];
            [[theValue(currenrPageRequest) should] equal:theValue(newPageRequest - 1)];
        });
        
    });
});

SPEC_END
