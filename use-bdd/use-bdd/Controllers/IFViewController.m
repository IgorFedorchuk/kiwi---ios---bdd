//
//  IFViewController.m
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFViewController.h"
#import "IFNetwork.h"

@interface IFViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *spinerView;

@property (nonatomic, strong) IFQuestionTableDelegate *questionTableDelegate;
@property (nonatomic, assign) NSInteger currentPageRequest;

@end

@implementation IFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Iphone tag";
    self.questionTableDelegate = [[IFQuestionTableDelegate alloc] initWithDelegate:self];
    self.tableView.dataSource = self.questionTableDelegate;
    self.tableView.delegate = self.questionTableDelegate;
    self.currentPageRequest = 1;
    
    [self startQuestionsRequest];
    [self spinerAnimation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.questionTableDelegate = nil;
}

#pragma mark - QuestionTableDelegate

- (void)needMoreQuestions
{
    [self startQuestionsRequest];
}

#pragma mark - Private

-(void)spinerAnimation:(BOOL)animation
{
    self.spinerView.hidden = !animation;
}

-(void)startQuestionsRequest
{
    __weak typeof(self) weakSelf = self;
    [[IFNetwork sharedInstance] iphoneTagAnswerWithPage:self.currentPageRequest completion:^(BOOL success, NSArray *items) {
        if (success)
        {
            weakSelf.currentPageRequest++;
            [weakSelf spinerAnimation:NO];
            [weakSelf.questionTableDelegate addQuestions:items];
            [weakSelf.tableView reloadData];
        }
        else
        {
            [weakSelf fetchFailedWithError:nil];
        }
    }];
}

- (void)fetchFailedWithError: (NSError *)error
{
    [self spinerAnimation:NO];
    [[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Request is failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
