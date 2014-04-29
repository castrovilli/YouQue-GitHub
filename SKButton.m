//
//  SKButton.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/27/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "SKButton.h"

@implementation SKButton
-(void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    if(!enabled)
    {
        self.alpha = 0.5;
    }else
    {
        self.alpha = 1.0;
    }
}
@end
