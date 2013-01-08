//
//  IFQuestionTableDelegate.m
//  use-bdd
//
//  Created by Igor on 08.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//

#import "IFQuestionTableDelegate.h"

@interface IFQuestionTableDelegate()

@property(nonatomic, strong) NSMutableArray *questions;

@end


@implementation IFQuestionTableDelegate

-(id)init
{
    if (self = [super init])
    {
        self.questions = [NSMutableArray array];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
}
@end
