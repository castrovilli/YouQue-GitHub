//
//  MDpopUpView.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/9/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "MDpopUpView.h"

@implementation MDpopUpView

- (id)initWithFrame:(CGRect)frame withTextColor:(UIColor*)color withFontSize:(CGFloat)fontSize
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
        
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        lbl.textColor = color;
        lbl.font = [UIFont boldSystemFontOfSize:fontSize];
        lbl.backgroundColor = [UIColor clearColor];
        [self addSubview:lbl];
    }
    return self;
}
-(void)showInView:(UIView*)containerView withText:(NSString*)txt withCompletionBlock:(void (^) (BOOL finished))completionBlock
{
    self.alpha = 0.0;
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [containerView addSubview:self];
    lbl.text = txt;
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.8;
    
    } completion:^(BOOL finished){
    
    
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
            self.transform = CGAffineTransformMakeScale(1.4, 1.4);
            self.alpha = 0.0;
        
        } completion:completionBlock];
    }];
    
    
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
