//
//  SCMeneosView.m
//  Meneame
//
//  Created by Jacobo Rodriguez on 1/03/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "SCMeneosView.h"

@interface SCMeneosView ()

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UILabel *meneosCountLabel;
@property (nonatomic, strong) UILabel *meneosLabel;
@property (nonatomic, strong) UILabel *clicsLabel;

@end

@implementation SCMeneosView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        _container = [UIView new];
        _container.translatesAutoresizingMaskIntoConstraints = NO;
        _container.backgroundColor = [UIColor appSecondaryLightColor];
        _container.layer.cornerRadius = 5;
        [self addSubview:_container];
        
        _meneosCountLabel = [UILabel new];
        _meneosCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _meneosCountLabel.text = @"0";
        _meneosCountLabel.textColor = [UIColor appMainColor];
        _meneosCountLabel.textAlignment = NSTextAlignmentCenter;
        _meneosCountLabel.font = [UIFont boldSystemFontOfSize:16];
        [_container addSubview:_meneosCountLabel];
        
        _meneosLabel = [UILabel new];
        _meneosLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _meneosLabel.text = @"meneos";
        _meneosLabel.textColor = [UIColor appMainColor];
        _meneosLabel.textAlignment = NSTextAlignmentCenter;
        _meneosLabel.font = [UIFont boldSystemFontOfSize:10];
        [_container addSubview:_meneosLabel];
        
        _menealoButton = [UIButton new];
        _menealoButton.translatesAutoresizingMaskIntoConstraints = NO;
        _menealoButton.backgroundColor = [UIColor appMainColor];
        _menealoButton.layer.cornerRadius = 5;
        _menealoButton.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
        _menealoButton.layer.borderWidth = 1.0;
        [_menealoButton setTitle:@"menéalo" forState:UIControlStateNormal];
        [_menealoButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
        [_container addSubview:_menealoButton];
        
        _clicsLabel = [UILabel new];
        _clicsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _clicsLabel.text = @"0 clics";
        _clicsLabel.textColor = [UIColor appMainColor];
        _clicsLabel.textAlignment = NSTextAlignmentCenter;
        _clicsLabel.font = [UIFont boldSystemFontOfSize:10];
        [_container addSubview:_clicsLabel];
        
        [self addCustomConstraints];
    }
    
    return self;
}

- (void)addCustomConstraints {
    
    NSDictionary *metrics = @{};
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_container, _meneosCountLabel, _meneosLabel, _menealoButton, _clicsLabel);
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_container(>=60)]-10-|" options:0 metrics:metrics views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_container]|" options:0 metrics:metrics views:dictionaryView]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_meneosCountLabel]-5-|" options:0 metrics:metrics views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_meneosLabel]-5-|" options:0 metrics:metrics views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(-10)-[_menealoButton]-(-10)-|" options:0 metrics:metrics views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_clicsLabel]-5-|" options:0 metrics:metrics views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_meneosCountLabel]-(-2)-[_meneosLabel]-5-[_menealoButton(25)]-5-[_clicsLabel]-5-|" options:0 metrics:metrics views:dictionaryView]];
}

#pragma mark - Setter

- (void)setMeneosCount:(NSInteger)meneosCount {
    
    _meneosCount = meneosCount;
    
    self.meneosCountLabel.text = [NSString stringWithFormat:@"%li", (long)meneosCount];
}

- (void)setClicsCount:(NSInteger)clicsCount {
    
    _clicsCount = clicsCount;
    
    self.clicsLabel.text = [NSString stringWithFormat:@"%li %@", (long)clicsCount, clicsCount == 1 ? @"clic" : @"clics"];
}

@end
