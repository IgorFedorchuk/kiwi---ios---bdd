//
//  IFAppDelegate.m
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFAppDelegate.h"

#import "IFViewController.h"

@interface IFAppDelegate()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) IFViewController *viewController;

@end

@implementation IFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPad" bundle:nil];
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
