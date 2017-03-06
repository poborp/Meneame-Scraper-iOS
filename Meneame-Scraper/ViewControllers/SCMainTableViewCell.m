//
//  SCMainTableViewCell.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 27/2/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCMainTableViewCell.h"

#import "UIImageView+AFNetworking.h"

@interface SCMainTableViewCell ()

@property (nonatomic, strong) NSString *highlightView;

@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *meneosLabel;
@property (nonatomic, strong) UILabel *votesPositiveLabel;
@property (nonatomic, strong) UILabel *votesAnonymousLabel;
@property (nonatomic, strong) UILabel *votesNegativeLabel;
@property (nonatomic, strong) UILabel *karmaLabel;
@property (nonatomic, strong) UILabel *commentsCountLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *bottomContainer;

@end

@implementation SCMainTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _newsImageView = [UIImageView new];
        _newsImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _newsImageView.backgroundColor = [UIColor appSecondaryLightColor];
        _newsImageView.layer.borderWidth = 0;
        _newsImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _newsImageView.layer.cornerRadius = 3;
        _newsImageView.contentMode = UIViewContentModeScaleAspectFill;
        _newsImageView.clipsToBounds = YES;
        [self.contentView addSubview:_newsImageView];
        
        _meneosLabel = [UILabel new];
        _meneosLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _meneosLabel.text = @"0";
        _meneosLabel.textColor = [UIColor appMainColor];
        _meneosLabel.textAlignment = NSTextAlignmentCenter;
        _meneosLabel.font = [UIFont boldSystemFontOfSize:12];
        _meneosLabel.backgroundColor = [[UIColor appSecondaryLightColor] colorWithAlphaComponent:0.8];
        [_newsImageView addSubview:_meneosLabel];
        
        _votesPositiveLabel = [UILabel new];
        _votesPositiveLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _votesPositiveLabel.numberOfLines = 1;
        _votesPositiveLabel.font = [UIFont boldSystemFontOfSize:12];
        _votesPositiveLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_votesPositiveLabel];
        
        _votesAnonymousLabel = [UILabel new];
        _votesAnonymousLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _votesAnonymousLabel.numberOfLines = 1;
        _votesAnonymousLabel.font = [UIFont boldSystemFontOfSize:12];
        _votesAnonymousLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_votesAnonymousLabel];
        
        _votesNegativeLabel = [UILabel new];
        _votesNegativeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _votesNegativeLabel.numberOfLines = 1;
        _votesNegativeLabel.font = [UIFont boldSystemFontOfSize:12];
        _votesNegativeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_votesNegativeLabel];
        
        _karmaLabel = [UILabel new];
        _karmaLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _karmaLabel.numberOfLines = 1;
        _karmaLabel.font = [UIFont boldSystemFontOfSize:12];
        _karmaLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_karmaLabel];
        
        _commentsCountLabel = [UILabel new];
        _commentsCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _commentsCountLabel.numberOfLines = 1;
        _commentsCountLabel.font = [UIFont boldSystemFontOfSize:12];
        _commentsCountLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_commentsCountLabel];
        
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 3;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        _userImageView = [UIImageView new];
        _userImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _userImageView.backgroundColor = [UIColor whiteColor];
        _userImageView.clipsToBounds = YES;
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = 10;
        _userImageView.layer.borderWidth = 1.0;
        _userImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_userImageView];
        
        _userLabel = [UILabel new];
        _userLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _userLabel.text = @"por asdasd";
        _userLabel.font = [UIFont systemFontOfSize:12];
        [_userLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_userLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_userLabel];
        
        _sourceLabel = [UILabel new];
        _sourceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _sourceLabel.text = @"a gwewfrwefwef.com";
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_sourceLabel];
        
        _contentLabel = [UILabel new];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_contentLabel];
        
        _bottomContainer = [UIView new];
        _bottomContainer.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomContainer.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_bottomContainer];
        
        [self addCustomConstraints];
    }
    return self;
}

- (void)addCustomConstraints {
    
    NSDictionary *metrics = @{@"imageW": @(80), @"imageH": @(60)};
    NSDictionary *dictionaryView = NSDictionaryOfVariableBindings(_newsImageView, _meneosLabel, _votesPositiveLabel, _votesAnonymousLabel, _votesNegativeLabel, _karmaLabel, _commentsCountLabel, _titleLabel, _userImageView, _userLabel, _sourceLabel, _contentLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_newsImageView(imageW)]" options:0 metrics:metrics views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-26-[_votesPositiveLabel(==_newsImageView)]" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-26-[_votesAnonymousLabel(==_newsImageView)]" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-26-[_votesNegativeLabel(==_newsImageView)]" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-26-[_karmaLabel(==_newsImageView)]" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-26-[_commentsCountLabel(==_newsImageView)]" options:0 metrics:metrics views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_newsImageView]-10-[_titleLabel]-15-|" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_newsImageView]-10-[_userImageView(20)]-5-[_userLabel]-2-[_sourceLabel]-15-|" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_newsImageView]-10-[_contentLabel]-15-|" options:0 metrics:metrics views:dictionaryView]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_newsImageView(imageH)]-15-[_votesPositiveLabel]-2-[_votesAnonymousLabel]-2-[_votesNegativeLabel]-2-[_karmaLabel]-2-[_commentsCountLabel]-(>=15)-|" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_titleLabel]-5-[_userImageView(20)]-5-[_contentLabel]-(>=15)-|" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-5-[_userLabel(==_userImageView)]" options:0 metrics:metrics views:dictionaryView]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-5-[_sourceLabel(==_userImageView)]" options:0 metrics:metrics views:dictionaryView]];
    
    [_newsImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_meneosLabel]|" options:0 metrics:metrics views:dictionaryView]];
    [_newsImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_meneosLabel(20)]|" options:0 metrics:metrics views:dictionaryView]];
}

- (void)prepareForReuse {
    
    self.newsImageView.image = nil;
    self.votesPositive = 0;
    self.votesNegative = 0;
    self.karma = 0;
    self.commentsCount = 0;
    self.titleLabel.text = @"";
    self.contentLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    
    self.backgroundColor = highlighted ? [UIColor colorWithWhite:0.3 alpha:0.1] : [UIColor whiteColor];
}

#pragma mark - Setter

- (void)setMeneos:(NSInteger)meneos {
    
    _meneos = meneos;
    
    self.meneosLabel.text = [NSString stringWithFormat:@"%li", meneos];
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setVotesPositive:(NSInteger)votesPositive {
    
    _votesPositive = votesPositive;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\uf0aa  %@", @(votesPositive)]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont awesomeFontWithSize:12], NSForegroundColorAttributeName: [UIColor appSecondaryColor]} range:NSMakeRange(0, 1)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(1, attributedString.string.length-1)];
    self.votesPositiveLabel.attributedText = attributedString;
}

- (void)setVotesAnonymous:(NSInteger)votesAnonymous {
    
    _votesAnonymous = votesAnonymous;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\uf21b  %@", @(votesAnonymous)]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont awesomeFontWithSize:12], NSForegroundColorAttributeName: [UIColor appSecondaryColor]} range:NSMakeRange(0, 1)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(1, attributedString.string.length-1)];
    self.votesAnonymousLabel.attributedText = attributedString;
}

- (void)setVotesNegative:(NSInteger)votesNegative {
    
    _votesNegative = votesNegative;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\uf0ab  %@", @(votesNegative)]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont awesomeFontWithSize:12], NSForegroundColorAttributeName: [UIColor appSecondaryColor]} range:NSMakeRange(0, 1)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(1, attributedString.string.length-1)];
    self.votesNegativeLabel.attributedText = attributedString;
}

- (void)setKarma:(NSInteger)karma {
    
    _karma = karma;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"K  %@", @(karma)]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor appSecondaryColor]} range:NSMakeRange(0, 1)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(1, attributedString.string.length-1)];
    self.karmaLabel.attributedText = attributedString;
}

- (void)setCommentsCount:(NSInteger)commentsCount {
    
    _commentsCount = commentsCount;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\uf086  %@", @(commentsCount)]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont awesomeFontWithSize:12], NSForegroundColorAttributeName: [UIColor appSecondaryColor]} range:NSMakeRange(0, 1)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(1, attributedString.string.length-1)];
    self.commentsCountLabel.attributedText = attributedString;
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    
    NSError *error = nil;
    NSDictionary *optionsDict = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:data options:optionsDict documentAttributes:nil error:&error];
    [attributedString addAttribute:NSFontAttributeName value:self.contentLabel.font range:NSMakeRange(0, attributedString.string.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.contentLabel.textColor range:NSMakeRange(0, attributedString.string.length)];
    
    self.contentLabel.attributedText = attributedString;
}

- (void)setUserImageUrl:(NSString *)userImageUrl {
    
    _userImageUrl = userImageUrl;
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:userImageUrl] placeholderImage:[UIImage imageNamed:@"no-gravatar"]];
}

- (void)setUserName:(NSString *)userName {
    
    _userName = userName;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"por %@", userName]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(0, 3)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor appMainColor]} range:NSMakeRange(3, attributedString.string.length-3)];
    self.userLabel.attributedText = attributedString;
}

- (void)setSourceName:(NSString *)sourceName {
    
    _sourceName = sourceName;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"a %@", sourceName]];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(0, 1)];
    [attributedString addAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blackColor]} range:NSMakeRange(1, attributedString.string.length-1)];
    self.sourceLabel.attributedText = attributedString;
}

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    self.newsImageView.image = image;
}

- (void)setImageURL:(NSString *)imageURL {
    
    _imageURL = imageURL;
    
    [self.newsImageView setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"image-placeholder"]];
}

@end
