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

@interface IFViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *spinerView;

@end

@implementation IFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Iphone tag";
    IFStackOverflowRequest *request = [[IFStackOverflowRequest alloc] init];
    [[request fetchQestions] start];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
