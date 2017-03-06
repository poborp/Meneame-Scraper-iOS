//
//  SCNotificationsView.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 2/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCNotificationsView.h"

@interface SCNotificationsView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation SCNotificationsView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, 50, 30)];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.userInteractionEnabled = NO;
        _imageView.image = [UIImage imageNamed:@"notifications-icon"];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _countLabel = [UILabel new];
        _countLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _countLabel.backgroundColor = [UIColor whiteColor];
        _countLabel.alpha = 1.0;
        _countLabel.clipsToBounds = YES;
        _countLabel.layer.cornerRadius = 19.0/2.0;
        _countLabel.layer.borderWidth = 0;
        _countLabel.text = @"0";
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.textColor = [UIColor appMainColor];
        _countLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:_countLabel];
        
        [self addCustomConstraints];
    }
    return self;
}

- (void)addCustomConstraints {
    
    NSDictionary *metrics = @{};
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_imageView, _countLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]|" options:0 metrics:metrics views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_countLabel(28)]-2-|" options:0 metrics:metrics views:dictionaryView]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_imageView]-2-|" options:0 metrics:metrics views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_countLabel(19)]" options:0 metrics:metrics views:dictionaryView]];
}

#pragma mark - Setter

- (void)setNotificationsCount:(NSInteger)notificationsCount {
    
    _notificationsCount = notificationsCount;
    
    self.countLabel.text = [NSString stringWithFormat:@"%li", notificationsCount];
}

@end
