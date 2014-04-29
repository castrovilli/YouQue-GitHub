//
//  UIViewController+Loader.m
//  Kitchens
//
//  Created by Mohammed Eldehairy on 3/25/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//
#import "UIViewController+Loader.h"
#import <objc/runtime.h>

static char const * const loadingViewKey = "loadingView";
@implementation UIViewController (Loader)
- (LoadingIndicatorView*)loadingView
{
    return objc_getAssociatedObject(self, loadingViewKey);
}

- (void)setLoadingView:(LoadingIndicatorView *)loadingView
{
    objc_setAssociatedObject(self, loadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void)startAnimating
{
    if(!self.loadingView)
    {
        self.loadingView = [[LoadingIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.loadingView.backgroundColor = [UIColor clearColor];
        self.loadingView.alpha = 1.0f;
    }
    [self.view addSubview:self.loadingView];
    
}
-(void)stopAnimating
{
    [self.loadingView removeFromSuperview];
}
@end
