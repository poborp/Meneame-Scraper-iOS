//
//  SCDetailViewController.m
//  Meneame
//
//  Created by Jacobo Rodriguez on 22/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "SCDetailViewController.h"
#import <SafariServices/SafariServices.h>

#import "SCDetailNewsTableViewCell.h"
#import "SCDetailCommentTableViewCell.h"
#import "SCScraperManager.h"

#import "SCNewsVO.h"
#import "SCCommentVO.h"

static NSString *NewsCellIdentifier = @"NewsCellIdentifier";
static NSString *CommentCellIdentifier = @"CommentCellIdentifier";

@interface SCDetailViewController () <JRHTMLTextViewDelegate>

@property (nonatomic, strong) SCNewsVO *news;

@end

@implementation SCDetailViewController

@dynamic view;

- (instancetype)initWithNews:(SCNewsVO *)news {
    
    self = [super init];
    if (self) {
        _news = news;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Comentarios";
    
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorColor = [UIColor appSecondaryColor];
    [self.tableView registerClass:[SCDetailNewsTableViewCell class] forCellReuseIdentifier:NewsCellIdentifier];
    [self.tableView registerClass:[SCDetailCommentTableViewCell class] forCellReuseIdentifier:CommentCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [SCRAPER newsDetailsWithNewsId:self.news.commentsUrl completion:^(NSArray *commentsList, NSError *error) {
        
        self.news.comments = [NSSet setWithArray:commentsList];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        return self.news.comments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SCDetailNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellIdentifier forIndexPath:indexPath];
        cell.news = self.news;
        return cell;
        
    } else {
        
        SCDetailCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier forIndexPath:indexPath];
        cell.comment = self.news.commentsSortedByDate[indexPath.row];
        cell.textView.linkDelegate = self;
        return cell;
    }
}

#pragma mark - JRHTMLTextView Delegate

- (void)htmlTextView:(JRHTMLTextView *)htmlTextView didPressLink:(NSURL *)link {
    
    if ([link.scheme isEqualToString:@"applewebdata"]) {
        
        NSInteger commentNum = [[link.absoluteString substringFromString:@"#c-" toString:nil] integerValue];
        //NSLog(@"Comment Num %li", (long)commentNum);
        if (commentNum == 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:commentNum inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        } else if (commentNum > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:commentNum-1 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    } else {
        
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:link];
        safariViewController.preferredBarTintColor = [UIColor appMainColor];
        safariViewController.preferredControlTintColor = [UIColor whiteColor];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:safariViewController];
        navigationController.navigationBarHidden = YES;
        
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }
}

@end
