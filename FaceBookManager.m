//
//  FaceBookManager.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/17/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "FaceBookManager.h"
@interface FaceBookManager()
{
    BOOL isFacebookAvailable;
    
    BOOL sharePermissionGranted;
    
    
}
@property(nonatomic,retain)FBSession *fbSession;
@property(nonatomic,retain)ACAccountStore *accountStore;
@property(nonatomic,retain)ACAccount *facebookAccount;
@end
@implementation FaceBookManager
+(FaceBookManager*)sharedInstance
{
    static dispatch_once_t onceToken;
    static FaceBookManager *FBManager=nil;
    dispatch_once( &onceToken, ^{
        FBManager = [[[self class] alloc] init];
    });
    return FBManager;
}
-(id)init
{
    self  = [super init];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountChanged:) name:ACAccountStoreDidChangeNotification object:nil];
    }
    return self;
}
-(void)showInviteFriendsDialoge
{
    
    
    
    [FBWebDialogs
     presentRequestsDialogModallyWithSession:self.fbSession
     message:@"checkout this cool iOS Game"
     title:@"YouQue"
     parameters:nil
     handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or sending the request.
             NSLog(@"Error sending request.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled request.");
             } else {
                 // Handle the send request callback
                 /*NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 if (![urlParams valueForKey:@"request"]) {
                     // User clicked the Cancel button
                     NSLog(@"User canceled request.");
                 } else {
                     // User clicked the Send button
                     NSString *requestID = [urlParams valueForKey:@"request"];
                     NSLog(@"Request ID: %@", requestID);
                 }*/
             }
         }
     }];
    
    
}
-(BOOL)isFacebookAvailable
{
    return isFacebookAvailable;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ACAccountStoreDidChangeNotification object:nil];
}
-(void)shareScore:(int)score level:(int)maxLevel
{
   


}
-(void)share:(ShareEntity *)entity
{
    NSString *key = @"1483381315209223";
    
    
    // Specify the permissions required
    NSArray *permissions = @[@"publish_stream"];
    
    // Specify the audience
    NSDictionary *facebookOptions ;
    facebookOptions = @{ACFacebookAppIdKey : key,
                        ACFacebookAudienceKey :  ACFacebookAudienceFriends,
                        ACFacebookPermissionsKey : permissions};
    
    // Specify the Account Type
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    
    // Perform the permission request
    [self.accountStore requestAccessToAccountsWithType:accountType options:facebookOptions completion:^(BOOL granted, NSError *error) {
        if (granted)
        {
            // _writeAccessGranted = YES;
            NSArray *array = [self.accountStore accountsWithAccountType:accountType];
            _facebookAccount = [array lastObject];
            
            NSLog(@"Write permissions granted.");
            [self shareAfterSharePermissionGranted:entity];
        }
        
        if (error) {
            if (error.code == 6) {
                NSLog(@"Error: There is no Facebook account setup.");
            } else
            {
                NSLog(@"Error: %@", [error localizedDescription]);
            }
        }
    }];
}
-(void)shareAfterSharePermissionGranted:(ShareEntity*)entity
{
    
    SLRequest *postToMyWall = ({
        // Create an NSURL pointing the correct open graph end point
        NSURL *postURL        = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
        
        // Create the post details
        NSString *link        = @"https://itunes.apple.com/eg/app/youque/id721318647?mt=8";
        NSString *message     = entity.message;
       // NSString *picture     = @"http://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/150px-Apple_logo_black.svg.png";
        NSString *name        = entity.name;
        NSString *caption     = @"classic 7x7 game";
        NSString *description = entity.sharedDescription;
        
        // Create a dictionary of post elements
        NSDictionary *postDict = @{
                                   @"link": link,
                                   @"message" : message,
                                   @"name" : name,
                                   @"caption" : caption,
                                   @"description" : description
                                   };
        
        
        postToMyWall = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                          requestMethod:SLRequestMethodPOST
                                                    URL:postURL
                                             parameters:postDict];
        
        // Set the account
        [postToMyWall setAccount:self.facebookAccount];
        
        [postToMyWall performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
            // Check for errors, output in alertview
            NSLog(@"Status Code: %li", (long)[urlResponse statusCode]);
            NSLog(@"Response Data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
            
            if (error)
            {
                NSLog(@"Error message: %@", [error localizedDescription]);
                //[self showAlertViewWithString:[error localizedDescription]];
            }
            
            if ([urlResponse statusCode] == 200) {
               // NSString *successMessage = @"The post has been made successfully.";
                //[self showAlertViewWithString:successMessage];
            }
            
            if ([urlResponse statusCode] == 400) {
                NSLog(@"The OAuth token has expired. Renewing Access Token.");
                //[_localInstance renewFacebookCredentials];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self hideHud];
            });
        }];
        
        postToMyWall;
    });

}
-(NSString*)FullName
{
    return self.facebookAccount.userFullName;
}
-(void)Initializefacebook
{
    self.accountStore = [[ACAccountStore alloc]init];
    ACAccountType *FBaccountType= [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSString *key = @"1483381315209223";
    NSDictionary *dictFB = [NSDictionary dictionaryWithObjectsAndKeys:key,ACFacebookAppIdKey,@[@"email"],ACFacebookPermissionsKey, nil];
    
    [self.accountStore requestAccessToAccountsWithType:FBaccountType options:dictFB completion:
     ^(BOOL granted, NSError *e) {
         if (granted)
         {
             NSArray *accounts = [self.accountStore accountsWithAccountType:FBaccountType];
             //it will always be the last object with single sign on
             self.facebookAccount = [accounts lastObject];
             
             
             ACAccountCredential *facebookCredential = [self.facebookAccount credential];
             NSString *accessToken = [facebookCredential oauthToken];
             NSLog(@"Facebook Access Token: %@", accessToken);
             
             
             NSLog(@"facebook account =%@",self.facebookAccount);
             
             MDSessionTokenCachingStrategy *sessionCache = [[MDSessionTokenCachingStrategy alloc] init];
             sessionCache.oauthToekn = self.facebookAccount.credential.oauthToken;
             sessionCache.permissions = @[@"email"];
             
             _fbSession = [[FBSession alloc] initWithAppID:@"1483381315209223" permissions:@[@"email"]  defaultAudience:FBSessionDefaultAudienceFriends urlSchemeSuffix:nil tokenCacheStrategy:sessionCache];
             
             isFacebookAvailable = 1;
         } else
         {
             //Fail gracefully...
             NSLog(@"error getting permission yupeeeeeee %@",e);
             sleep(10);
             NSLog(@"awake from sleep");
             isFacebookAvailable = 0;
             
         }
     }];
    
    
    
}

/*-(void)checkfacebookstatus
{
    if (isFacebookAvailable == 0)
    {
        [self checkFacebook];
        isFacebookAvailable = 1;
    }
    else
    {
        printf("Get out from our game");
    }
}*/


/*-(void)get
{
    
    NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:requestURL parameters:nil];
    request.account = self.facebookAccount;
    
    [request performRequestWithHandler:^(NSData *data, NSHTTPURLResponse *response, NSError *error) {
        
        if(!error)
        {
            
            NSDictionary *list =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSLog(@"Dictionary contains: %@", list );
            
            
            
            
            self.globalmailID   = [NSString stringWithFormat:@"%@",[list objectForKey:@"email"]];
            NSLog(@"global mail ID : %@",globalmailID);
            
            
            fbname = [NSString stringWithFormat:@"%@",[list objectForKey:@"name"]];
            NSLog(@"faceboooookkkk name %@",fbname);
            
            
            
            
            if([list objectForKey:@"error"]!=nil)
            {
                [self attemptRenewCredentials];
            }
            dispatch_async(dispatch_get_main_queue(),^{
                
            });
        }
        else
        {
            //handle error gracefully
            NSLog(@"error from get%@",error);
            //attempt to revalidate credentials
        }
        
    }];
    
    self.accountStore = [[ACAccountStore alloc]init];
    ACAccountType *FBaccountType= [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    NSString *key = @"451805654875339";
    NSDictionary *dictFB = [NSDictionary dictionaryWithObjectsAndKeys:key,ACFacebookAppIdKey,@[@"friends_videos"],ACFacebookPermissionsKey, nil];
    
    
    [self.accountStore requestAccessToAccountsWithType:FBaccountType options:dictFB completion:
     ^(BOOL granted, NSError *e) {}];
    
}*/




-(void)accountChanged:(NSNotification *)notification
{
    [self attemptRenewCredentials];
}

-(void)attemptRenewCredentials
{
    [self.accountStore renewCredentialsForAccount:(ACAccount *)self.facebookAccount completion:^(ACAccountCredentialRenewResult renewResult, NSError *error){
        if(!error)
        {
            switch (renewResult) {
                case ACAccountCredentialRenewResultRenewed:
                    NSLog(@"Good to go");
                   // [self get];
                    break;
                case ACAccountCredentialRenewResultRejected:
                    NSLog(@"User declined permission");
                    break;
                case ACAccountCredentialRenewResultFailed:
                    NSLog(@"non-user-initiated cancel, you may attempt to retry");
                    break;
                default:
                    break;
            }
            
        }
        else{
            //handle error gracefully
            NSLog(@"error from renew credentials%@",error);
        }
    }];
}
@end
