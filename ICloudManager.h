//
//  ICloudManager.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/15/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AD_REMOVAL_PURCHASED_ICLOUD_KEY @"AdsRemovalPurchased"
#define LOCAL_PLAYER_HIGH_SCORE_KEY @"localPlayerHighScore"
#define HIGH_SCORE_UPDATED_NOTIFICATION @"HighScoreUpdated"
@interface ICloudManager : NSObject
+(void)adsRemovalPurchased;
+(void)saveLocalPlayerHighScore:(long long)newHighScore;
+(BOOL)IsAdsRemovalPurchased;
+(long long)getLocalPlayerHighScore;
@end
