//
//  CollectionViewController.m
//  gifViewObjC
//
//  Created by Taylor Smith on 10/6/17.
//  Copyright © 2017 Taylor Smith. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Giphy.h"
#import "DetailViewController.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSMutableArray *giphys;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"GifViewerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self refreshImages];
    
}

// Network call for the giphy api

-(void) refreshImages {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.giphy.com/v1/gifs/trending?api_key=lpYuf9Lkc6PWKzNhnS4lgjxV5pMcMY9G&rating=pg"];
    
    self.giphys = [NSMutableArray array];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        
        if (data != nil) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        
        // data array > images > downsized_still > url
        
        NSArray *dictionaries = [dictionary valueForKey:@"data"];
        
        for (NSDictionary *dict in dictionaries) {
            Giphy *giphy = [Giphy giphyWithDictionary:dict];
            [self.giphys addObject:giphy];
        }
        } else {
            
            NSLog(@"you have no internet stupid");
            dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Internet!"
                                                            message:@"Please check your internet connection and try again."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            });
        }
           NSLog(@"%@", self.giphys);
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
            
        });
        
    }];
    [task resume];
    
}
    
// action for alertview ok button to try the network call again upon dismissal
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        [self refreshImages];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        Giphy *giphy = self.giphys[selectedIndexPath.row];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.giphy = giphy;
}
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.giphys count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    Giphy *giphy = [self.giphys objectAtIndex:indexPath.row];
    cell.giphy = giphy;
    
    return cell;
}
// method that enables the collection view to be re-ordered

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

 
                            
    
}

// method that retains the indexPath after moving a gif to another location



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

@end
