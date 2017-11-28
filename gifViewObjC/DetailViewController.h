//
//  DetailViewController.h
//  gifViewObjC
//
//  Created by Taylor Smith on 10/7/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Giphy;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) Giphy *giphy;

@end
