//
//  ICloudManager.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/15/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "ICloudManager.h"

@implementation ICloudManager
+(void)adsRemovalPurchased
{
    NSUbiquitousKeyValueStore *storage = [NSUbiquitousKeyValueStore defaultStore];
    
    [storage setBool:YES forKey:AD_REMOVAL_PURCHASED_ICLOUD_KEY];
    
    [storage synchronize];
}
+(BOOL)IsAdsRemovalPurchased
{
    return [[NSUbiquitousKeyValueStore defaultStore] boolForKey:AD_REMOVAL_PURCHASED_ICLOUD_KEY];
}
+(void)saveLocalPlayerHighScore:(long long)newHighScore
{
    NSUbiquitousKeyValueStore *storage = [NSUbiquitousKeyValueStore defaultStore];
    
    [storage setLongLong:newHighScore forKey:LOCAL_PLAYER_HIGH_SCORE_KEY];
    
    [storage synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HIGH_SCORE_UPDATED_NOTIFICATION object:nil];
}
+(long long)getLocalPlayerHighScore
{
    return [[NSUbiquitousKeyValueStore defaultStore] longLongForKey:LOCAL_PLAYER_HIGH_SCORE_KEY];
}
@end
