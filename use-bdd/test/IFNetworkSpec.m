//
//  IFNetworkSpec.m
//  use-bdd
//
//  Created by Igor on 6/5/15.
//  Copyright (c) 2015 IgorFedorchuk. All rights reserved.
//

#import "Kiwi.h"
#import "IFNetwork.h"

SPEC_BEGIN(IFNetworkSpec)

describe(@"IFNetworkSpec", ^
{
    context(@"question request", ^
            {
                __block IFNetwork *network = nil;
                __block NSInteger questionsCount = 0;
                
                beforeEach(^
                           {
                               network = [IFNetwork new];
                           });
                
                it(@"should recieve 10 questions", ^
                   {
                       [network iphoneTagAnswerWithPage:1 completion:^(BOOL success, NSArray *items) {
                           questionsCount = items.count;
                       }];
                       
                       [[expectFutureValue(theValue(questionsCount)) shouldEventually] equal:theValue(10)];

                   });
            });
});

SPEC_END