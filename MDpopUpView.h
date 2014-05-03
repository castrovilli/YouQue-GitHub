//
//  MDpopUpView.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/9/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDpopUpView : UIView
{
    UILabel *lbl;
}
- (id)initWithFrame:(CGRect)frame withTextColor:(UIColor*)color withFontSize:(CGFloat)fontSize;
-(void)showInView:(UIView*)containerView withText:(NSString*)txt withCompletionBlock:(void (^) (void))completionBlock;
@end
