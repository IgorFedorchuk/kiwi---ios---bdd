//
//  IFViewController.m
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFViewController.h"
#import "IFStackOverflowRequest.h"
#import "AFJSONRequestOperation.h"
#import "IFQuestionBuilder.h"

NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=2";


@interface IFViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *spinerView;

@end

@implementation IFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Iphone tag";  
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];    
    IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:self urlString:questionsUrlString];
    [[request fetchQestions] start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - StackOverflowRequestDelegate
- (void)fetchFailedWithError: (NSError *)error
{
    
}

- (void)receivedJSON: (NSDictionary *)json
{
    
}

@end
