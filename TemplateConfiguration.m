//
//  TemplateConfiguration.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 5/6/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "TemplateConfiguration.h"

@implementation TemplateConfiguration
+(TemplateConfiguration*)sharedInstance
{
    static dispatch_once_t onceToken;
    static TemplateConfiguration *tempConfig=nil;
    dispatch_once( &onceToken, ^{
        tempConfig = [[[self class] alloc] init];
    });
    return tempConfig;
}
-(id)init
{
    self = [super init];
    if(self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:
                          @"TemplateConfig" ofType:@"plist"];
        configDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return self;
}
-(NSString*)valueForKey:(NSString*)key
{
    return [configDictionary objectForKey:key];
}
@end
