//
//  IFAnswerRequest.h
//  use-bdd
//
//  Created by Igor on 6/5/15.
//  Copyright (c) 2015 IgorFedorchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFNetwork.h"

@interface IFAnswerRequest : NSObject

- (instancetype)initWithPage:(NSInteger)page;
- (void)sendWithCompletion:(IFItemsRequestBlock)completion;

@end
