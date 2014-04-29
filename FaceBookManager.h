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
@interface FaceBookManager : NSObject
@property(nonatomic,readonly)BOOL isFacebookAvailable;
+(FaceBookManager*)sharedInstance;
-(void)Initializefacebook;
-(void)shareScore:(int)score level:(int)maxLevel;
@end
