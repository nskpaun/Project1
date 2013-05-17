//
//  PhotoSet.m
//  Fetch
//
//  Created by Nathan Spaun on 3/27/13.
//  Copyright (c) 2013 BestAppsMarket.com. All rights reserved.
//

#import "PhotoSet.h"
#import "Photo.h"

@implementation PhotoSet
@synthesize title = _title;
@synthesize photos = _photos;

- (id) initWithTitle:(NSString *)title photos:(NSArray *)photos {
    if ((self = [super init])) {
        self.title = title;
        self.photos = photos;
        for(int i = 0; i < _photos.count; ++i) {
            Photo *photo = [_photos objectAtIndex:i];
            photo.photoSource = self;
            photo.index = i;
        }
    }
    return self;
}

- (void) dealloc {
    self.title = nil;
    self.photos = nil;
}

#pragma mark TTModel

- (BOOL)isLoading {
    return FALSE;
}

- (BOOL)isLoaded {
    return TRUE;
}

#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos {
    return _photos.count;
}

- (NSInteger)maxPhotoIndex {
    return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    if (photoIndex < _photos.count) {
        return [_photos objectAtIndex:photoIndex];
    } else {
        return nil;
    }
}
@end
