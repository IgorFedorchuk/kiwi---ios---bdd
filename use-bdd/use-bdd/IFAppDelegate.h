//
//  IFAppDelegate.h
//  use-bdd
//
//  Created by Igor on 26.11.12.
//  Copyright (c) 2012 IgorFedorchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IFViewController;

@interface IFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) IFViewController *viewController;

@end
