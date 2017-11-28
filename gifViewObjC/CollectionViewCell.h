//
//  CollectionViewCell.h
//  gifViewObjC
//
//  Created by Taylor Smith on 10/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Giphy;

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) Giphy *giphy;




@end
