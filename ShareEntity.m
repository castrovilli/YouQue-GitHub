//
//  ShareEntity.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/3/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "ShareEntity.h"

@implementation ShareEntity
-(id)initWithMessage:(NSString*)message link:(NSString*)link name:(NSString*)name description:(NSString*)description
{
    self = [super init];
    if(self)
    {
        _message = message;
        _link = link;
        _name = name;
        _sharedDescription = description;
    }
    return self;
}
@end
