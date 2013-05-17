//  Created by Petr Prokop on 1/5/12.

#import "PPRatingBar.h"

//define number of stars to show (and maximum rating user can give)
#define kNumberOfStars 5

@implementation PPRatingBar

@synthesize delegate;

- (void)initWithFrame
{
    if (self)
    {
        _rating = 0.0f;
        
        _onImage = [UIImage imageNamed:@"rating_bar_small"];
        _offImage = [UIImage imageNamed:@"rating_bar_small_empty"];
        _halfImage = [UIImage imageNamed:@"rating_bar_small_half"];
        
        CGFloat spaceBetweenStars = 5;
        _imageViews = [[NSMutableArray alloc] initWithCapacity:5];
        
        for(NSInteger i=0; i<kNumberOfStars; i++)
        {
            UIImageView *iv =
            [[UIImageView alloc] initWithFrame:CGRectMake((_offImage.size.width*.5 + spaceBetweenStars)*i,
                                                          self.frame.origin.y,
                                                          _offImage.size.width*.8,
                                                          self.frame.size.height*.7)];
            iv.image = _offImage;
            [self addSubview:iv];
            [_imageViews addObject:iv];
        }
    }
}

#pragma mark - Updating UI

- (void)clean
{
    for(NSInteger i=0; i<_imageViews.count; i++)
    {
        UIImageView *star = (UIImageView *)[_imageViews objectAtIndex:i];
        star.image = _offImage;
    }
}

- (void)updateRating:(float)rating
{
    _rating = rating;
    [self clean];
    
    NSInteger i;
    
    //set every full star
    for(i=1; i<=MIN(_imageViews.count, _rating); i++)
    {
        UIImageView *star = (UIImageView *)[_imageViews objectAtIndex:i-1];
        star.image = _onImage;
    }
    
    if (i > _imageViews.count)
        return;
    
    //now add a half star if rating is appropriate
    if(_rating - i + 1 >= 0.5f)
    {
        UIImageView *star = (UIImageView *)[_imageViews objectAtIndex:i-1];
        star.image = _halfImage;
    }
}

@end
