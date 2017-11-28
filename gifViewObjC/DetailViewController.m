//
//  DetailViewController.m
//  gifViewObjC
//
//  Created by Taylor Smith on 10/7/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import "DetailViewController.h"
#import "Giphy.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( self.giphy ) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL: self.giphy.animatedGifURL];
        [self.webView loadRequest:request];
      
    }
    
    
    [self setupGestures];
}

// sets up gestures for swiping the gif to the right to exit back to to the main view, or tap to have it shrink into itself, heading back to the main view as well

- (void)setupGestures {
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    dismiss.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:dismiss];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDismiss)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
    
}

// shrinks view into the center upon dismissal

-(void)dismiss {
    [UIView animateWithDuration:0.75 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.view.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

// swipes view to the right

-(void) swipeToDismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
        
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
