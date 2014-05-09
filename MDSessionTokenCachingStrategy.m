//
//  MDSessionTokenCachingStrategy.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/9/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "MDSessionTokenCachingStrategy.h"

@implementation MDSessionTokenCachingStrategy
- (FBAccessTokenData *)fetchFBAccessTokenData
{
    NSMutableDictionary *tokenInformationDictionary = [NSMutableDictionary new];
    
    // Expiration date
    tokenInformationDictionary[@"com.facebook.sdk:TokenInformationExpirationDateKey"] = [NSDate dateWithTimeIntervalSinceNow: 3600];;
    
    // Refresh date
    tokenInformationDictionary[@"com.facebook.sdk:TokenInformationRefreshDateKey"] = [NSDate date];
    
    // Token key
    tokenInformationDictionary[@"com.facebook.sdk:TokenInformationTokenKey"] = self.oauthToekn;
    
    // Permissions
    tokenInformationDictionary[@"com.facebook.sdk:TokenInformationPermissionsKey"] = self.permissions;
    
    // Login key
    tokenInformationDictionary[@"com.facebook.sdk:TokenInformationLoginTypeLoginKey"] = @0;
    
    return [FBAccessTokenData createTokenFromDictionary: tokenInformationDictionary];
}
@end
