//
//  SCDetailViewController.m
//  Meneame
//
//  Created by Jacobo Rodriguez on 22/02/18.
//  Copyright © 2018 Jacobo Rodriguez. All rights reserved.
//

#import "SCDetailViewController.h"
#import <SafariServices/SafariServices.h>

#import "SCDetailCommentCellView.h"
#import "SCScraperManager.h"

#import "SCNewsVO.h"
#import "SCCommentVO.h"

#import "JRHTMLString.h"

static NSString *CellIdentifier = @"CellIdentifier";

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
    [self.tableView registerClass:[SCDetailCommentCellView class] forCellReuseIdentifier:CellIdentifier];
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
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.news.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCCommentVO *comment = self.news.commentsSortedByDate[indexPath.row];
    
    JRHTMLString *htmlString = [JRHTMLString htmlWithContentString:comment.text];
    htmlString.hiperlinkColor = [UIColor appMainColor];
    htmlString.hiperlinkLine = NO;
    htmlString.font = [UIFont systemFontOfSize:14];
    
    SCDetailCommentCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.numCommentLabel.text = [NSString stringWithFormat:@"#%i", comment.num];
    cell.userNameLabel.text = comment.username;
    //cell.htmlStringView.htmlString = htmlString;
    cell.textView.htmlString = htmlString;
    cell.textView.linkDelegate = self;
    
    return cell;
}

#pragma mark - JRHTMLTextView Delegate

- (void)htmlTextView:(JRHTMLTextView *)htmlTextView didPressLink:(NSURL *)link {
    
    if ([link.scheme isEqualToString:@"applewebdata"]) {
        
        NSInteger commentNum = [[link.absoluteString substringFromString:@"#c-" toString:nil] integerValue];
        //NSLog(@"Comment Num %li", (long)commentNum);
        if (commentNum > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:commentNum-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
