//
//  UIViewController+Loader.h
//  Kitchens
//
//  Created by Mohammed Eldehairy on 3/25/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingIndicatorView.h"
@interface UIViewController (Loader)
@property (retain,nonatomic) LoadingIndicatorView *loadingView;
-(void)startAnimating;
-(void)stopAnimating;
@end
