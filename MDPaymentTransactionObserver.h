//
//  MDPaymentTransactionObserver.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/13/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "SIAlertView.h"
#import "ICloudManager.h"
#define PURCHASE_SUCCEEDED_NOTIFICATION @"purchaseSucceededNotification"
@protocol MDPaymentTransactionObserverDelegate;
@interface MDPaymentTransactionObserver : NSObject<SKPaymentTransactionObserver>
@property(nonatomic,weak)id<MDPaymentTransactionObserverDelegate> delegate;
@end
@protocol MDPaymentTransactionObserverDelegate <NSObject>

-(void)transactionFailed;
-(void)transactionSucceeded;
-(void)transactionFinished;

@end