//
//  NavigationHelper.m
//  Fetch
//
//  Created by Nathan Spaun on 3/29/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "NavigationHelper.h"

@implementation NavigationHelper

+(NSArray*)switchToView:(UIViewController*)aViewController withSelfView:(UIViewController*)selfView withCurrentVC:(UIViewController*) currentViewController withPHV:(UIView*)placeholderView withselfVC:(UIViewController*) _selfVC
{
    if( aViewController == currentViewController ) return [NSArray arrayWithObjects:_selfVC,selfView, nil];
    
    aViewController.title =  selfView.title;
    
    UIView *aView= aViewController.view;
    [aViewController viewWillAppear:NO];
    if( currentViewController != nil ) {
    	[currentViewController viewWillDisappear:NO];
    	[currentViewController.view removeFromSuperview];
    }
    aView.frame = placeholderView.frame;
    [selfView.view insertSubview:aView aboveSubview:placeholderView];
    if( currentViewController != nil ) {
    	[currentViewController viewDidDisappear:NO];
    }
    [aViewController viewDidAppear:NO];
    _selfVC = currentViewController;
    currentViewController = aViewController;
    return [NSArray arrayWithObjects:currentViewController,selfView.view, nil];
}

@end
