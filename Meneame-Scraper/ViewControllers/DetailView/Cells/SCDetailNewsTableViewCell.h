//
//  SCDetailNewsTableViewCell.h
//  Meneame
//
//  Created by Jacobo Rodriguez on 1/03/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCNewsVO;

@interface SCDetailNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) SCNewsVO *news;

@property (nonatomic, assign) NSInteger meneos;
@property (nonatomic, assign) NSInteger clics;
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

@property (nonatomic, strong, readonly) UIButton *commentsCountButton;

@end
