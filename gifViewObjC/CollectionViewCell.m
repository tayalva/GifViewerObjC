//
//  CollectionViewCell.m
//  gifViewObjC
//
//  Created by Taylor Smith on 10/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Giphy.h"

@implementation CollectionViewCell

-(void) setGiphy:(Giphy *)giphy {
    
    _giphy = giphy;
    
    [self downloadImageWithURL:giphy.stillImageURl];
}


// networking call to fetch trending gif images

-(void)downloadImageWithURL: (NSURL*)url{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60 ];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           self.imageView.image = image;
        });
        

  }];
    
    [task resume];
}
@end
