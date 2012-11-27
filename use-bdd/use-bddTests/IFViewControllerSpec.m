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
        
        beforeEach(^{ // Occurs before each enclosed "it"
            viewController = [[IFViewController alloc] init];
        });
        
        afterEach(^{ // Occurs after each enclosed "it"
        });
        
        it(@"should not be nil and conforms protocol UITableViewDataSource && UITableViewDelegate", ^{
            [viewController shouldNotBeNil];
            [[viewController should] conformToProtocol:@protocol(UITableViewDataSource)];
            [[viewController should] conformToProtocol:@protocol(UITableViewDelegate)];
        });
        
        it(@"IFViewController should has tableView propertie", ^{
            
                NSArray* propertyList = [viewController propertyList];
                NSString *name = nil;
            
                for (NSDictionary *propertyInfo in propertyList)
                {
                    NSString *propertyName = [propertyInfo objectForKey:@"propertyName"];
                    if([propertyName isEqualToString:@"tableView"])
                    {
                        name = propertyName;
                        break;
                    }
                }
                NSLog(@"name: %@", name);
                [name shouldNotBeNil];
        }); 
        
    });
});

SPEC_END
