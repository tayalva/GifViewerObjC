//
//  Giphy.h
//  gifViewObjC
//
//  Created by Taylor Smith on 10/7/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Giphy : NSObject


@property (nonatomic, strong) NSURL *stillImageURl;
@property(nonatomic, strong) NSURL *animatedGifURL;

+ (instancetype) giphyWithDictionary:(NSDictionary*) dictionary;


@end
