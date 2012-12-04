#import "Kiwi.h"
#import "IFQuestionBuilder.h"
#import "NSObject+Properties.h"
#import "IFStackOverflowRequest.h"
#import "AFJSONRequestOperation.h"


SPEC_BEGIN(IFQuestionBuilderSpec)

describe(@"IFQuestionBuilderSpec", ^
{
    context(@"a state the component is in", ^
    {
        __block IFQuestionBuilder *builder = nil;
        NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=20";

        beforeEach(^
        {
            builder = [[IFQuestionBuilder alloc] initWithDelegate:nil];
        });
        
        afterEach(^
        { 
        });
        
        it(@"should conform StackOverflowRequestDelegate protocol", ^
        {
            [builder shouldNotBeNil];
            [[builder should] conformToProtocol:@protocol(StackOverflowRequestDelegate)];
        });
        
        it(@"should recieve receivedJSON", ^
           {
               IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:builder urlString:questionsUrlString];
               [[request fetchQestions] start];
               [[[builder shouldEventuallyBeforeTimingOutAfter(3)] receive] receivedJSON:any()];               
           });
        
        it(@"should recieve fetchFailedWithError", ^
           {
               NSString *fakeUrl = @"asda";
               IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:builder urlString:fakeUrl];
               [[request fetchQestions] start];
               [[[builder shouldEventuallyBeforeTimingOutAfter(1)] receive] fetchFailedWithError:any()];
            });
        
    });
});

SPEC_END
