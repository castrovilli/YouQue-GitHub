//
//  YQAppDelegate.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceBookManager.h"
#import <StoreKit/StoreKit.h>
#import <GameKit/GameKit.h>
#import "MDPaymentTransactionObserver.h"
#import "YQViewController.h"
#import "GAI.h"
@interface YQAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)YQViewController *mainViewController;
@end
