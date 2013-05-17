//
//  ApiHelper.m
//  Fetch
//
//  Created by Nathan Spaun on 1/22/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "ApiHelper.h"

@implementation ApiHelper

NSString const *HTTP_PRE  =                         @"https://";
NSString const *HOST_API  =                         @"54.225.246.88";
NSString const *DOG = 								@"31795ec73f27e6b99e828c16facd43ed";
NSString const *CONNECTIVITY_EVENT = 				@"com.bestappsmarket.android.appstation.helper.APIHelper.CONN";
NSString const *PREFS_USER_IDENTIFIER_KEY = 		@"com.bestappsmarket.appid";
NSString const *PREFS_APP_CURRENT_VERSION_KEY = 	@"com.bestappsmarket.appversion.current";
NSString const *PREF_SERVER_TS = 					@"install.serverTs";
NSString const *PREF_INSTALL_DAY =                  @"install.installDay";
NSString const *PREF_INSTALL_REFERRER = 			@"install.referrer";
NSString const *PREF_NUM_DAY_OPENED =               @"install.numberofdaysopened";
NSString const *PREF_LAST_OPEN_DAY =  				@"install.lastopenappday";
NSString const *PREF_LAST_OPEN_TS =  				@"install.lastopenappts";


NSString const *SECURITY_CODE_KEY =  				@"securityCode";
NSString const *PAGE_KEY =                          @"page";
NSString const *DEVICE_KEY =                        @"ua";
NSString const *STORE_KEY =                         @"store";

NSString const *SECURITY_CODE =                     @"0";


- (ApiHelper*) init {
    return self;
}

-(void) postToUrl:(NSString *)url withParams:(NSString*) params
withCallback: (void (^)(SearchResult *))callback withPage:(int)p {
    _params = params;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *post1 = @"";
    
    NSString *keyString = APP_VER_CODE;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = PAGE_KEY;
    post1 = [NSString stringWithFormat:@"%@%@=%d&", post1, keyString,p ] ;
    
    keyString = NUM_DAYS_OPEN;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = APP_ID;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = LANG;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = COUNTRY;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = LAST_DAY_OPEN;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = USER_ID;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = INSTALL_DAY;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = TIME_STAMP;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    //keyString = SDK_VER;
    //post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString,[defaults stringForKey:keyString] ] ;
    
    keyString = SECURITY_CODE_KEY;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString, SECURITY_CODE ] ;
    
    keyString = STORE_KEY;
    post1 = [NSString stringWithFormat:@"%@%@=%@&", post1, keyString, @"APPLE" ] ;
    NSString *post;
    
    if (params) {
        post = [NSString stringWithFormat:@"%@&%@",params,post1];
    } else {
        post = post1;
    }
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSLog(post);
    NSString *urlstring = [NSString stringWithFormat:@"%@%@%@",HTTP_PRE,HOST_API,url];
    NSLog(urlstring);
    NSMutableURLRequest* request = [NSMutableURLRequest
                                    requestWithURL: [NSURL URLWithString: urlstring]];
    [request setHTTPMethod:@"POST"];
    NSError *error;
    // should check for and handle errors here
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //[request setHTTPBody:body];
    NSURLConnection *conn = [[NSURLConnection alloc]
                             initWithRequest: request delegate:self];
    
    callbackBlock = callback;
}

-(void)apiPost:(NSString*)url
{
    
}

#pragma NSUrlConnectionDelegate Methods

-(void)connection:(NSConnection*)conn didReceiveResponse:
(NSURLResponse *)response
{
    if (_receivedData == NULL) {
        _receivedData = [[NSMutableData alloc] init];
    }
    [_receivedData setLength:0];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    else
    {
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:
(NSData *)data
{
    // Append the new data to receivedData.
    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:
(NSError *)error
{
    //Naive error handling - log it!
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:
           NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:_receivedData options:kNilOptions error:&error];
    SearchResult *searchResult = [[SearchResult alloc] initWithJson:json];
    searchResult.params = _params;
    
    callbackBlock(searchResult);
}


@end
