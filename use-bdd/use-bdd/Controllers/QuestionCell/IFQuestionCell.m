//
//  IFQuestionCell.m
//  use-bdd
//
//  Created by Igor on 09.01.13.
//  Copyright (c) 2013 IgorFedorchuk. All rights reserved.
//

#import "IFQuestionCell.h"
#import "IFQuestion.h"
#import "IFPerson.h"

@interface IFQuestionCell ()

@property(nonatomic, strong) IFQuestion *question;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *askerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *askerAvatar;

@end

@implementation IFQuestionCell

-(void)configWithQuestion:(IFQuestion *)newQuestion
{
    self.question = newQuestion;
    self.titleLabel.text = newQuestion.title;
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", newQuestion.score ];
    self.askerNameLabel.text = newQuestion.asker.name;
    self.askerAvatar.image = nil;
}

@end
