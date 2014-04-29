//
//  LoadingIndicatorView.m
//  Kitchens
//
//  Created by Mohammed Eldehairy on 3/24/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "LoadingIndicatorView.h"

@implementation LoadingIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        indicator.center = CGPointMake(self.center.x, self.center.y+30);
        [indicator startAnimating];
        indicator.backgroundColor = [UIColor colorWithRed:(37.0f/255.0f) green:(37.0f/255.0f) blue:(37.0f/255.0f) alpha:0.5];
        indicator.layer.cornerRadius = 10;
        
        [self addSubview:indicator];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
