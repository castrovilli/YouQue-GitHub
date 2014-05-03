//
//  ShareEntity.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareEntity : NSObject
@property(nonatomic,retain,readonly)NSString *message;
@property(nonatomic,retain,readonly)NSString *link;
@property(nonatomic,retain,readonly)NSString *name;
@property(nonatomic,retain,readonly)NSString *sharedDescription;
-(id)initWithMessage:(NSString*)message link:(NSString*)link name:(NSString*)name description:(NSString*)description;
@end
