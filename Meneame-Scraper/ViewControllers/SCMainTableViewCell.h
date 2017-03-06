//
//  SCMainTableViewCell.h
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 27/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCMainTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger meneos;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger votesPositive;
@property (nonatomic, assign) NSInteger votesAnonymous;
@property (nonatomic, assign) NSInteger votesNegative;
@property (nonatomic, assign) NSInteger karma;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, strong) NSString *userImageUrl;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *sourceName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageURL;

@end
