//
//  SCUserIconView.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 2/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCUserIconView.h"

#import "UIImageView+AFNetworking.h"

@interface SCUserIconView ()

//@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SCUserIconView

- (instancetype)init {
    
    self = [super initWithFrame:CGRectMake(0, 0, 40, 30)];
    if (self) {
        
        //_nameLabel = [UILabel new];
        //_nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        //_nameLabel.text = @"";
        //_nameLabel.textColor = [UIColor whiteColor];
        //_nameLabel.font = [UIFont boldSystemFontOfSize:12];
        //[self addSubview:_nameLabel];
        
        _imageView = [UIImageView new];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.userInteractionEnabled = NO;
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.clipsToBounds = YES;
        _imageView.layer.borderWidth = 0; //1
        _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imageView.layer.cornerRadius = self.frame.size.height/2.0;
        [self addSubview:_imageView];
        
        [self addCustomConstraints];
    }
    return self;
}

- (void)addCustomConstraints {
    
    //NSDictionary *metrics = @{};
    //NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_nameLabel, _imageView);
    //
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nameLabel]-10-[_imageView(30)]-5-|" options:0 metrics:metrics views:dictionaryView]];
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_nameLabel]|" options:0 metrics:metrics views:dictionaryView]];
    //[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView(30)]|" options:0 metrics:metrics views:dictionaryView]];
    
    NSDictionary *metrics = @{};
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_imageView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_imageView(30)]-5-|" options:0 metrics:metrics views:dictionaryView]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView(30)]|" options:0 metrics:metrics views:dictionaryView]];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.layer.cornerRadius = self.frame.size.height/2.0;
}

#pragma mark - Setter

- (void)setUser:(NSDictionary *)user {
    
    _user = user;
    
    //self.nameLabel.text = user[@"user_login"];
    [self.imageView setImageWithURL:[NSURL URLWithString:user[@"user_image"]] placeholderImage:nil];
}

#pragma mark - Getter

- (UIBarButtonItem *)barButtonItem {
    
    return [[UIBarButtonItem alloc] initWithCustomView:self];
}

@end
