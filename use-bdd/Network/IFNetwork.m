//
//  IFNetwork.m
//  use-bdd
//
//  Created by Igor on 6/5/15.
//  Copyright (c) 2015 IgorFedorchuk. All rights reserved.
//

#import "IFNetwork.h"
#import "SynthesizeSingleton.h"
#import "IFAnswerRequest.h"

@implementation IFNetwork
SYNTHESIZE_SINGLETON_FOR_CLASS(IFNetwork)

- (void)iphoneTagAnswerWithPage:(NSInteger)page completion:(IFItemsRequestBlock)completion
{
    IFAnswerRequest *request = [[IFAnswerRequest alloc] initWithPage:page];
    [request sendWithCompletion:completion];
}
@end
