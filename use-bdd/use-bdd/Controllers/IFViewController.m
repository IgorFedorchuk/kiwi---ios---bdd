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

NSString *questionsUrlString = @"http://api.stackoverflow.com/1.1/search?tagged=iphone&pagesize=20";


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
    IFQuestionBuilder *questionBuilder = [[IFQuestionBuilder alloc] initWithDelegate:self];
    
    IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] initWithDelegate:questionBuilder urlString:questionsUrlString];
    [[request fetchQestions] start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
