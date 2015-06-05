//
//  IFQuestionTableDelegate.h
//  use-bdd
//
//  Created by Igor on 08.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//

@protocol QuestionTableDelegate;

@interface IFQuestionTableDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

-(instancetype)initWithDelegate:(id<QuestionTableDelegate>)delegate;
-(void)addQuestions:(NSArray *)newQuestions;

@end

@protocol QuestionTableDelegate <NSObject>

- (void)needMoreQuestions;

@end