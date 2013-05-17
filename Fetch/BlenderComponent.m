//
//  BlenderComponent.m
//  Fetch
//
//  Created by Nathan Spaun on 3/25/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "BlenderComponent.h"
#import "Fetch.h"

@implementation BlenderComponent
@synthesize buttons;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"BlenderComponentLayout" owner:self options:nil] objectAtIndex:0];
        self.frame = frame;
        self.buttons = [[NSArray alloc] init];
        for ( int i = 1; i < 7; i++ ) {
            UIButton *button = (UIButton*) [self viewWithTag:i];
            self.buttons = [self.buttons arrayByAddingObject:button];
        }
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for ( UIButton *_button in self.buttons) {
        CGPoint buttonPoint = [self convertPoint:point toView:_button];
        buttonPoint.y = buttonPoint.y-5;
        if ([_button pointInside:buttonPoint withEvent:event]) { // you may add your requirement here
            return _button;
        }
        buttonPoint.y = buttonPoint.y+19;
        if ([_button pointInside:buttonPoint withEvent:event]) { // you may add your requirement here
            return _button;
        }
    }
    return [super hitTest:point withEvent:event];
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
