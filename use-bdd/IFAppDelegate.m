//
//  IFAppDelegate.m
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import "IFAppDelegate.h"
#import "IFViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface IFAppDelegate()

@end

@implementation IFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Fabric with:@[CrashlyticsKit]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    IFViewController *viewController = [[IFViewController alloc] initWithNibName:@"IFViewController_iPhone" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
