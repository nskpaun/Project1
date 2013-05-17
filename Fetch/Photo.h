//
//  Photo.h
//  Fetch
//
//  Created by Nathan Spaun on 3/27/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface Photo : NSObject <TTPhoto> {
    NSString *_caption;
    NSString *_urlLarge;
    NSString *_urlSmall;
    NSString *_urlThumb;
    id <TTPhotoSource> _photoSource;
    CGSize _size;
    NSInteger _index;
}

@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSString *urlLarge;
@property (nonatomic, copy) NSString *urlSmall;
@property (nonatomic, copy) NSString *urlThumb;
@property (nonatomic, retain) id <TTPhotoSource> photoSource;
@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger index;

- (id)initWithCaption:(NSString *)caption urlLarge:(NSString *)urlLarge urlSmall:(NSString *)urlSmall urlThumb:(NSString *)urlThumb size:(CGSize)size;

@end

