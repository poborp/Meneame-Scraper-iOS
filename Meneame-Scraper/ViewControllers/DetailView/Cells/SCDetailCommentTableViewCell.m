//
//  SCDetailCommentTableViewCell.m
//  Meneame
//
//  Created by Jacobo Rodriguez on 26/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "SCDetailCommentTableViewCell.h"
#import "SCCommentVO.h"
#import "UIImageView+AFNetworking.h"

@interface SCDetailCommentTableViewCell ()

@property (nonatomic, strong) UIImageView *userImageView;

@end

@implementation SCDetailCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _userImageView = [UIImageView new];
        _userImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _userImageView.image = [UIImage imageNamed:@"no-gravatar"];
        _userImageView.backgroundColor = [UIColor redColor];
        _userImageView.clipsToBounds = YES;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = 10;
        _userImageView.layer.borderWidth = 0.0; //1.0
        _userImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_userImageView];
        
        _numCommentLabel = [UILabel new];
        _numCommentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _numCommentLabel.text = @"0";
        _numCommentLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_numCommentLabel];
        
        _userNameLabel = [UILabel new];
        _userNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _userNameLabel.text = @"0";
        _userNameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_userNameLabel];
        
        _textView = [JRHTMLTextView new];
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_textView];
        
        [self addCustomConstraints];
    }
    
    return self;
}

- (void)addCustomConstraints {
    
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_userImageView, _numCommentLabel, _userNameLabel, _textView);

    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_userImageView(20)]-10-[_numCommentLabel]-6-[_userNameLabel]-(>=16)-|" options:0 metrics:nil views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_textView]-16-|" options:0 metrics:nil views:dictionaryView]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[_userImageView(20)]-5-[_textView]" options:0 metrics:nil views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[_numCommentLabel]-5-[_textView]" options:0 metrics:nil views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[_userNameLabel]-5-[_textView]" options:0 metrics:nil views:dictionaryView]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textView]-16-|" options:0 metrics:nil views:dictionaryView]];
}

#pragma mark - Setter

- (void)setComment:(SCCommentVO *)comment {
    
    _comment = comment;
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:comment.userImageUrl] placeholderImage:[UIImage imageNamed:@"no-gravatar"]];
    self.numCommentLabel.text = [NSString stringWithFormat:@"#%i", comment.num];
    self.userNameLabel.text = comment.username;
    
    JRHTMLString *htmlString = [JRHTMLString htmlWithContentString:comment.text];
    htmlString.hiperlinkColor = [UIColor appMainColor];
    htmlString.hiperlinkLine = NO;
    htmlString.font = [UIFont systemFontOfSize:12];
    self.textView.htmlString = htmlString;
}

@end
