//
//  FaceBookManager.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/17/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "ShareEntity.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MDSessionTokenCachingStrategy.h"
#define FB_USER_TOKEN_KEY @"fbUserTokenKey"
@interface FaceBookManager : NSObject
@property(nonatomic,readonly)BOOL isFacebookAvailable;
+(FaceBookManager*)sharedInstance;
-(void)Initializefacebook;
-(void)share:(ShareEntity*)entity;
-(NSString*)FullName;
-(void)showInviteFriendsDialoge;
@end
