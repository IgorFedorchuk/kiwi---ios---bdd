//
//  IFQuestionTableDelegate.h
//  use-bdd
//
//  Created by Igor on 08.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//


@interface IFQuestionTableDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

-(void)addQuestions:(NSArray *)newQuestions;

@end
