//
//  MDSessionTokenCachingStrategy.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/9/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

@interface MDSessionTokenCachingStrategy : FBSessionTokenCachingStrategy
@property(nonatomic,retain)NSString *oauthToekn;
@property(nonatomic,retain)NSArray *permissions;
@property(nonatomic,retain)NSDate *expiry;
@property(nonatomic,retain)NSDate *refreshDate;
@end
