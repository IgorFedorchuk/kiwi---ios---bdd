//
//  IFNetwork.h
//  use-bdd
//
//  Created by Igor on 6/5/15.
//  Copyright (c) 2015 IgorFedorchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IFItemsRequestBlock)(BOOL success, NSArray *items);

@interface IFNetwork : NSObject

+ (instancetype)sharedInstance;

- (void)iphoneTagAnswerWithPage:(NSInteger)page completion:(IFItemsRequestBlock)completion;

@end
