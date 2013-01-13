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

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *askerNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *askerAvatar;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spiner;

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
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", newQuestion.score ];
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
