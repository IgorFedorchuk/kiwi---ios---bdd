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
#import "UIImageView+AFNetworking.h"

@interface IFQuestionCell ()

@property(nonatomic, strong) IFQuestion *question;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *askerNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *askerAvatar;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spiner;

@end

@implementation IFQuestionCell

-(void)dealloc
{
    [self.askerAvatar removeObserver:self forKeyPath:@"image"];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.askerAvatar addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)configWithQuestion:(IFQuestion *)newQuestion
{
    [self.askerAvatar removeObserver:self forKeyPath:@"image"];

    self.question = newQuestion;
    self.spiner.hidden = NO;
    self.titleLabel.text = newQuestion.title;
    self.scoreLabel.text = [NSString stringWithFormat:@"score:%ld", (long)newQuestion.score ];
    self.askerNameLabel.text = newQuestion.asker.name;
    self.askerAvatar.image = nil;
    [self.askerAvatar addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:NULL];

    [self.askerAvatar setImageWithURL:newQuestion.asker.avatarURL placeholderImage:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"image"])
	{
        UIImageView *imageView = (UIImageView *)object;
        if (imageView.image)
        {
            self.spiner.hidden = YES;
        }
	}
}

@end
