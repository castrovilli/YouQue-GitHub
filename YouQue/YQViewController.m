//
//  YQViewController.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "YQViewController.h"
#import "YQMyScene.h"

@implementation YQViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    
     self.screenName = @"Game View";
    
    
    
    paymentObserver = [[MDPaymentTransactionObserver alloc] init];
    paymentObserver.delegate = self;
    [[SKPaymentQueue defaultQueue] addTransactionObserver:paymentObserver];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    FromRighttransition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:0.3];
    FromLefttransition = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.3];
    
    
    MainMenuScene = [YQMainMenu sceneWithSize:skView.bounds.size];
    MainMenuScene.scaleMode = SKSceneScaleModeAspectFill;
    MainMenuScene.viewController = self;
    
    gameScene = [YQMyScene sceneWithSize:skView.bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    gameScene.viewController = self;
    // Present the scene.
    
    currentScene curr = [self lastScene];
    if(curr == currentSceneGame)
    {
        GameEntity *ResumedGame = [PersistentStore getLastGame];
        if(!ResumedGame.graph)
        {
            [self presentMenuSceneAnimated:NO];
        }else
        {
            [self resumeGameAnimated:NO withGame:ResumedGame];
        }
        
        
    }else
    {
        [self presentMenuSceneAnimated:NO];
    }
    
    
    
    
    
    
    
    
    UIImage *buttonImage = [[UIImage imageNamed:[[TemplateConfiguration sharedInstance] valueForKey:MAIN_MENU_BUTTON_NORMAL_IMAGE_KEY]]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:[[TemplateConfiguration sharedInstance] valueForKey:MAIN_MENU_BUTTON_HIGHLIGHTED_IMAGE_KEY]]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    
    [howToBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [howToBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [newBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [newBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [highScoreBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [highScoreBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [ResumBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [ResumBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    
    [removeAdsBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [removeAdsBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [inviteFriendsBtn setBackgroundImage:buttonImage forState:UIControlStateNormal]
    ;
    [inviteFriendsBtn setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];

    if(![self adRemovalPurchased])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAds) name:PURCHASE_SUCCEEDED_NOTIFICATION object:nil];
        
        [self loadNewAd];
    }
    
    
    BOOL loadedBefore = [[NSUserDefaults standardUserDefaults] boolForKey:APP_LOADED_BEFORE_KEY];
    
    if(!loadedBefore)
    {
        [self howToAction:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:APP_LOADED_BEFORE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)inviteFriendsAction:(id)sender
{
    [[FaceBookManager sharedInstance] showInviteFriendsDialoge];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PURCHASE_SUCCEEDED_NOTIFICATION object:nil];
}

- (void) showBannerWithMessage:(NSString*)msg withTitle:(NSString*)title
{
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.view
                                                        style:ALAlertBannerStyleFailure
                                                     position:ALAlertBannerPositionTop
                                                        title:title
                                                     subtitle:msg];
    [banner show];
    //[TSMessage showNotificationInViewController:self title:title subtitle:msg type:TSMessageNotificationTypeError];
}
- (void) showNormalBannerWithMessage:(NSString*)msg withTitle:(NSString*)title
{
    ALAlertBanner *banner = [ALAlertBanner alertBannerForView:self.view
                                                        style:ALAlertBannerStyleSuccess
                                                     position:ALAlertBannerPositionTop
                                                        title:title
                                                     subtitle:msg];
    [banner show];
    //[TSMessage showNotificationInViewController:self title:title subtitle:msg type:TSMessageNotificationTypeSuccess];
}
-(currentScene)lastScene
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"lastScene"];
}
-(void)setLastScene:(currentScene)lastScene
{
    _currentSceneType = lastScene;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    BOOL adRemovalPurchased = [self adRemovalPurchased];
    
    if(adRemovalPurchased)
    {
        removeAdsBtn.hidden = YES;
        removeAdsBtn.enabled = NO;
    }else
    {
        removeAdsBtn.hidden = NO;
        removeAdsBtn.enabled = YES;
    }
    
    
    [self updateResumeBtnEnabled];
}
-(void)updateResumeBtnEnabled
{
    GameEntity *ResumedGame = [PersistentStore getLastGame];
    if(!ResumedGame)
    {
        ResumBtn.enabled = NO;
    }else
    {
        ResumBtn.enabled = YES;
    }
}
-(void)transactionFinished
{
    
}
-(void)transactionSucceeded
{
    [self stopAnimating];
    
    removeAdsBtn.hidden = YES;
    removeAdsBtn.enabled = NO;
}
-(void)transactionFailed
{
    [self stopAnimating];
}
-(BOOL)adRemovalPurchased
{
    return [ICloudManager IsAdsRemovalPurchased];
}
-(void)loadNewAd
{
    
    
    /*if (bannerView_ == nil) {
        bannerView_ = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                 withView:self.view withDelegate:nil];
        [self.view addSubview:bannerView_];
    }*/
    
    bannerView_ = [[RevMobAds session] bannerView];
    bannerView_.frame = CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50);
    
    if([self hasFourInchDisplay])
    {
        [self.view addSubview:bannerView_];
        
    }else
    {
        [menuView addSubview:bannerView_];
    }
    
    
    bannerView_.delegate = self;
    [bannerView_ loadAd];
}
-(void)revmobAdDidReceive
{

}
-(void)revmobAdDidFailWithError:(NSError *)error
{
    [bannerView_ loadAd];
}
-(void)revmobUserClickedInTheAd
{
    
}
-(void)revmobUserClosedTheAd
{
    
}
-(void)installDidReceive
{
    
}
-(void)installDidFail
{
    
}
-(void)removeAds
{
    [bannerView_ removeFromSuperview];
}
- (BOOL)hasFourInchDisplay {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}
-(IBAction)newGame:(id)sender
{
    GameEntity *ResumedGame = [PersistentStore getLastGame];
    if(!ResumedGame.graph)
    {
        [self newGameAnimated:YES];
        return;
    }
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Warning" andMessage:@"Last Game will be lost"];
    
    [alertView addButtonWithTitle:@"Continue"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                              
                              
                              [self newGameAnimated:YES];
                              
                              
                          }];
    
    [alertView addButtonWithTitle:@"Canel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              
                              
                              
                          }];
    
    
    
    
    alertView.transitionStyle = SIAlertViewTransitionStyleFade;
    
    [alertView show];
    
}
-(void)newGameAnimated:(BOOL)animated
{
    [self setLastScene:currentSceneGame];
    
    gameScene.IsResumedGame = NO;
    
    
    if(!animated)
    {
        [((SKView*) self.view) presentScene:gameScene];
         [gameScene ReloadNewGame];
        menuView.alpha = 0.0;
        return;
    }
    
    [((SKView*) self.view) presentScene:gameScene transition:FromRighttransition];
    
    [gameScene ReloadNewGame];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.alpha = 0.0;
        
    } completion:nil];
}
-(void)GameCenterAction:(id)sender
{
    if((floorf([[UIDevice currentDevice] systemVersion].floatValue))>=6)
    {
        GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
        if (gameCenterController != nil)
        {
            gameCenterController.gameCenterDelegate = self;
            [self presentViewController: gameCenterController animated: YES completion:nil];
        }
    }else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gamecenter:"]];
        
    }
}
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)resumeGame:(id)sender
{
   
    GameEntity *ResumedGame = [PersistentStore getLastGame];
    if(!ResumedGame.graph)
    {
        return;
    }
    [self resumeGameAnimated:YES withGame:ResumedGame];
}
-(void)resumeGameAnimated:(BOOL)animated withGame:(GameEntity*)ResumedGame
{
    
     [self setLastScene:currentSceneGame];
    
   // currentSceneType = currentSceneGame;
    
    if(!animated)
    {
        [((SKView*) self.view) presentScene:gameScene];
        [gameScene reloadGame:ResumedGame];
        menuView.alpha = 0.0;
        return;
    }
    
    [((SKView*) self.view) presentScene:gameScene transition:FromRighttransition];
    [gameScene reloadGame:ResumedGame];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        menuView.alpha = 0.0;
        
    } completion:nil];
    
}
-(void)howToAction:(id)sender
{
    // basic
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Game Objective";
    
    
    
    page1.desc = @"The objective is to clear out rows of 4 or more fruits of the same type either vertically ,horizontally ,or diagonally to gain points.";
    page1.descColor = [UIColor whiteColor];
    page1.descPositionY = 180;
    
    if([UIScreen mainScreen].bounds.size.height == 568)
    {
        UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 280, 280)];
        icon1.image = [UIImage imageNamed:@"objective.png"];
        page1.titleIconView = icon1;
        page1.titleFont = [UIFont boldSystemFontOfSize:22];
        page1.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
        page1.descPositionY = 180;
        page1.titlePositionY = 220;
    }else
    {
        UIImageView *icon1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 240, 240)];
        icon1.image = [UIImage imageNamed:@"objective.png"];
        page1.titleIconView = icon1;
        page1.titleIconPositionY -= 20;
        page1.titleFont = [UIFont boldSystemFontOfSize:20];
        page1.descFont = [UIFont fontWithName:@"Georgia-Italic" size:16];
        page1.descPositionY = 150;
        page1.titlePositionY = 190;
    }
    
    

    
    // custom
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Moving fruits";
    
    
    
    
    
    page2.desc = @"To move a fruit around , select it until it jiggles,Then select an unoccupied place ,Or you can simply drag it around the board ,The catch is that the path must be clear , And fruits can't move diagonally.";
    
    
    page2.descColor = [UIColor whiteColor];
    
    if([UIScreen mainScreen].bounds.size.height == 568)
    {
        UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 280, 280)];
        icon2.image = [UIImage imageNamed:@"movingcells.png"];
        page2.titleIconView = icon2;
        page2.titleFont = [UIFont boldSystemFontOfSize:22];
        page2.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
        page2.descPositionY = 200;
        page2.titlePositionY = 225;
    }else
    {
        UIImageView *icon2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 240, 240)];
        icon2.image = [UIImage imageNamed:@"movingcells.png"];
        page2.titleIconView = icon2;
        page2.titleIconPositionY -= 20;
        page2.titleFont = [UIFont boldSystemFontOfSize:20];
        page2.descFont = [UIFont fontWithName:@"Georgia-Italic" size:16];
        page2.descPositionY = 170;
        page2.titlePositionY = 195;
    }
    
    
    // custom view from nib
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Moving fruits";
    
     
    
    
    page3.desc = @"Every time you move a fruit , new fruits are added , And the ones to be added next are shown at the top, Except when your move completes rows of 4 or more fruits of the same type, no new ones are added .";
    page3.descColor = [UIColor whiteColor];
    
    
    
    
    
    if([UIScreen mainScreen].bounds.size.height == 568)
    {
        UIImageView *icon3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 280, 280)];
        icon3.contentMode = UIViewContentModeScaleAspectFit;
        icon3.image = [UIImage imageNamed:@"new cells.png"];
        page3.titleIconView = icon3;
        page3.titleFont = [UIFont boldSystemFontOfSize:22];
        page3.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
        page3.descPositionY = 200;
        page3.titlePositionY = 220;
    }else
    {
        UIImageView *icon3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 240, 240)];
        icon3.image = [UIImage imageNamed:@"new cells.png"];
        icon3.contentMode = UIViewContentModeScaleAspectFit;
        page3.titleIconView = icon3;
        page3.titleIconPositionY -= 20;
        page3.titleFont = [UIFont boldSystemFontOfSize:20];
        page3.descFont = [UIFont fontWithName:@"Georgia-Italic" size:16];
        page3.descPositionY = 170;
        page3.titlePositionY = 190;
    }
    
    
    EAIntroPage *page4 = [EAIntroPage page];
    
    
    UIImageView *icon4 = [[UIImageView alloc] initWithFrame:CGRectMake(20, -20, 280, 280)];
    icon4.contentMode = UIViewContentModeScaleAspectFit;
    icon4.image = [UIImage imageNamed:@"undo tut.png"];
    page4.titleIconView = icon4;
    
    page4.title = @"Undo";
    page4.desc = @"You can undo any move by pressing the undo button at the top right corner .";
    page4.descColor = [UIColor whiteColor];
    
    
    
    if([UIScreen mainScreen].bounds.size.height == 568)
    {
        page4.titleFont = [UIFont boldSystemFontOfSize:22];
        page4.descFont = [UIFont fontWithName:@"Georgia-Italic" size:18];
        page4.descPositionY = 200;
        page4.titlePositionY = 220;
    }else
    {
        page4.titleFont = [UIFont boldSystemFontOfSize:20];
        page4.descFont = [UIFont fontWithName:@"Georgia-Italic" size:16];
        page4.descPositionY = 170;
        page4.titlePositionY = 190;
    }
    
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    intro.bgImage = [UIImage imageNamed:@"tutorialBackground.png"];
    [intro showInView:self.view animateDuration:0.2];
}
-(void)quitGameScene
{
    [self presentMenuSceneAnimated:YES];
}
-(void)presentMenuSceneAnimated:(BOOL)animated
{
    [self setLastScene:currentSceneMenu];
    [self updateResumeBtnEnabled];
    
    
    if(!animated)
    {
        [((SKView*) self.view) presentScene:MainMenuScene];
        menuView.alpha = 1.0;
        return;
    }
    [((SKView*) self.view) presentScene:MainMenuScene transition:FromLefttransition];
    
    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
        
        menuView.alpha = 1.0;
        
    } completion:nil];
}
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)RemoveAdsAction:(id)sender
{
    [self validateProductIdentifiers];
}


-(void)purchase
{
    if(self.appStoreProducts.count == 0 )
    {
        return;
    }
    SKProduct *product = [self.appStoreProducts objectAtIndex:0];
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    payment.quantity = 1;
    
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

//************************************************************************************************************
//************************************************************************************************************



//******************************** Validate And retrieve Product Info From App Store*********************************
//************************************************************************************************************
- (void)validateProductIdentifiers
{
    [self startAnimating];
    NSArray *Ids = [NSArray arrayWithObject:PRODUCT_ID];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:Ids]];
    productsRequest.delegate = self;
    [productsRequest start];
}
- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    self.appStoreProducts = response.products;
    
    BOOL productValid = YES;
    
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        if([invalidIdentifier isEqualToString:PRODUCT_ID])
        {
            productValid = NO;
        }
    }
    
    if(productValid)
    {
        [self purchase];
    }
    
}
//************************************************************************************************************
//************************************************************************************************************





@end
