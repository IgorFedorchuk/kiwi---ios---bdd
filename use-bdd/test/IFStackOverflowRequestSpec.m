#import "Kiwi.h"
#import "IFStackOverflowRequest.h"
#import "AFNetworking.h"
#import "IFViewController.h"

//#define SpecRequests

SPEC_BEGIN(IFStackOverflowRequestSpec)

describe(@"IFStackOverflowRequestSpec", ^
{
    context(@"question request", ^
    {
        __block IFViewController *controller = nil;
        
         beforeEach(^
         {
             controller = [IFViewController mock];
         });
        
        it(@"should conform StackOverflowRequestDelegate protocol", ^
        {
             [[controller should] conformToProtocol:@protocol(StackOverflowRequestDelegate)];
        });
        
#ifdef SpecRequests
         it(@"should recieve receivedJSON", ^
         {
             NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=20";

             IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:controller urlString:questionsUrlString];
             [[request fetchQestions] start];
             [[[controller shouldEventuallyBeforeTimingOutAfter(3)] receive] receivedJSON:any()];
         });
         
         it(@"should recieve fetchFailedWithError", ^
         {
             NSString *fakeUrl = @"asda";
             IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:controller urlString:fakeUrl];
             [[request fetchQestions] start];
             [[[controller shouldEventuallyBeforeTimingOutAfter(1)] receive] fetchFailedWithError:any()];
         });
#endif
    });
});

SPEC_END
