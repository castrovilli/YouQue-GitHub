//
//  MDPaymentTransactionObserver.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/13/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "MDPaymentTransactionObserver.h"

@implementation MDPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}
-(void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    if([_delegate respondsToSelector:@selector(transactionFinished)])
    {
        [_delegate transactionFinished];
    }
}
-(void)completeTransaction:(SKPaymentTransaction*)tansaction
{
    [ICloudManager adsRemovalPurchased];
    
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"success" andMessage:@"Enjoy YouQue Ads free !"];
    
    [alertView addButtonWithTitle:@"ok"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              
                              
                              
                          }];
    
    
    
    
    
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    
    [alertView show];
    
    
    
    if([_delegate respondsToSelector:@selector(transactionSucceeded)])
    {
        [_delegate transactionSucceeded];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PURCHASE_SUCCEEDED_NOTIFICATION object:nil];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:tansaction];
    
    
    if([_delegate respondsToSelector:@selector(transactionFinished)])
    {
        [_delegate transactionFinished];
    }
}
-(void)failedTransaction:(SKPaymentTransaction*)tansaction
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"error" andMessage:tansaction.error.localizedDescription];
    
    [alertView addButtonWithTitle:@"ok"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              
                              
                              
                          }];
    
    
    
    
    
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    
    [alertView show];
    
    if([_delegate respondsToSelector:@selector(transactionFailed)])
    {
        [_delegate transactionFailed];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:tansaction];
    
    
    if([_delegate respondsToSelector:@selector(transactionFinished)])
    {
        [_delegate transactionFinished];
    }
}
-(void)restoreTransaction:(SKPaymentTransaction*)tansaction
{
    
}
@end
