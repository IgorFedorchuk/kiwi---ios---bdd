//
//  IFQuestion.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

@class Answer;
@class IFPerson;


@interface IFQuestion : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, strong, readonly) NSArray *answers;
@property (nonatomic, assign) NSInteger questionID;
@property (nonatomic, strong) IFPerson *asker;

- (void)addAnswer: (Answer *)answer;

@end
