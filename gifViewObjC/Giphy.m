//
//  Giphy.m
//  gifViewObjC
//
//  Created by Taylor Smith on 10/7/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import "Giphy.h"

@implementation Giphy

+ (instancetype) giphyWithDictionary:(NSDictionary*) dictionary {
    
    Giphy *giphy = [[Giphy alloc]init];
    if (giphy) {
        
        giphy.animatedGifURL = [NSURL URLWithString:[dictionary valueForKeyPath:@"images.original.url"]];
        
        giphy.stillImageURl = [NSURL URLWithString:[dictionary valueForKeyPath:@"images.downsized_still.url"]];
    }
    
    return giphy;
}

@end
