//
//  SCMainViewController.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 20/2/17.
//  Copyright (c) 2017 tBear Software. All rights reserved.
//

#import "SCMainViewController.h"
#import <SafariServices/SafariServices.h>

#import "SCScraperManager.h"

#import "SCMainTableViewCell.h"

#import "SCNewsVO.h"

#import "SCSearchBarIconView.h"
#import "SCUserIconView.h"
#import "SCNotificationsView.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface SCMainViewController ()

@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL logged;
@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) NSString *controlKey;
@property (nonatomic, assign) BOOL defaultSubs;

@property (nonatomic, strong) SCSearchBarIconView *searchBarIconView;
@property (nonatomic, strong) SCUserIconView *userView;
@property (nonatomic, strong) SCNotificationsView *notificationsView;

@end

@implementation SCMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = nil;
    self.navigationController.toolbarHidden = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"meneame-logo"] style:UIBarButtonItemStylePlain target:self action:@selector(didPressLogoBarButtonItem:)];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor appMainColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.currentPage = 1;
    
    self.refreshControl = [UIRefreshControl new];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    [self.refreshControl addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.estimatedRowHeight = 60;
    [self.tableView registerClass:[SCMainTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    _searchBarIconView = [SCSearchBarIconView new];
    [_searchBarIconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressSearchBarButtonItem:)]];
    
    _userView = [SCUserIconView new];
    [_userView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressUserBarButtonItem:)]];
    
    _notificationsView = [SCNotificationsView new];
    [_notificationsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressNotificationsBarButtonItem:)]];
    
    [self reloadData:nil];
}

#pragma mark - Setter

- (void)setLogged:(BOOL)logged {
    
    _logged = logged;
    
    if (logged) {
        
        self.userView.user = self.user;
        
        self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.notificationsView],
                                                    [[UIBarButtonItem alloc] initWithCustomView:self.userView],
                                                    [[UIBarButtonItem alloc] initWithCustomView:self.searchBarIconView],
                                                    ];
    } else {
        self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Login" style:UIBarButtonItemStylePlain target:self action:@selector(didPressLoginBarButtonItem:)]];
    }
}

#pragma mark - Data

- (void)reloadData:(UIRefreshControl *)refreshControl {
    
    [SCRAPER newsFromPage:self.currentPage completion:^(NSDictionary *data, NSError *error) {
        
        [self updateTableWithData:data];

        [self endRefreshControl:refreshControl];
    }];
}

- (void)endRefreshControl:(UIRefreshControl *)refreshControl {
    
    [self.tableView reloadData];
    
    if (refreshControl) {
        [refreshControl endRefreshing];
    }
}

- (void)updateTableWithData:(NSDictionary *)data {
    
    self.newsList = data[@"elements"];
    self.user = data[@"user"];
    self.controlKey = data[@"base_key"];
    self.defaultSubs = [data[@"subs_default"] boolValue];
    [self.tableView reloadData];
    
    if ([data[@"user"][@"user_login"] length] > 0) {
        self.logged = YES;
    } else {
        self.logged = NO;
    }
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SCNewsVO *news = self.newsList[indexPath.row];
    
    SCMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.meneos = news.meneos;
    cell.imageURL = news.imageUrl;
    cell.votesPositive = news.votesPositive;
    cell.votesAnonymous = news.votesAnonymous;
    cell.votesNegative = news.votesNegative;
    cell.karma = news.karma;
    cell.commentsCount = news.commentsCount;
    cell.title = news.title;
    cell.userImageUrl = news.userImageUrl;
    cell.userName = news.userName;
    cell.sourceName = news.soruceTitle;
    cell.content = news.content;
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SCNewsVO *news = self.newsList[indexPath.row];
    if (news.sourceUrl.length > 0) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:news.sourceUrl] entersReaderIfAvailable:YES];
        safariViewController.preferredBarTintColor = [UIColor appMainColor];
        safariViewController.preferredControlTintColor = [UIColor whiteColor];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:safariViewController];
        navigationController.navigationBarHidden = YES;
        
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    } else {
        NSLog(@"Error sourceUrl");
    }
}

#pragma mark - ScraperManager Delegate

- (void)scraperManager:(SCScraperManager *)scraperManager foundData:(NSDictionary *)data {
    
    self.newsList = data[@"elements"];
    [self.tableView reloadData];
}

#pragma mark - BarButtonItem Actions

- (void)didPressLogoBarButtonItem:(UIBarButtonItem *)barButtonItem {

    self.currentPage = 1;
    
    if (self.newsList.count > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    [self reloadData:nil];
}

- (void)didPressLoginBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Meneame" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Usuario";
        textField.text = @"";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Contraseña";
        textField.text = @"";
        textField.secureTextEntry = YES;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Iniciar Sesión" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [SCRAPER loginWithUsername:alertController.textFields[0].text password:alertController.textFields[1].text completion:^(NSDictionary *user, NSError *error) {
            
            if (!user) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login Error" message:@"User error" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                
            } else {
                
                [self reloadData:nil];
            }
        }];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)didPressSearchBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Meneame" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Buscar";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Buscar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [SCRAPER search:alertController.textFields[0].text completion:^(NSDictionary *data, NSError *error) {
            
            [self updateTableWithData:data];
        }];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil]];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (void)didPressUserBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.user[@"user_login"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:self.defaultSubs ? @"Ver todos los subs" : @"Ver solo mis subs" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SCRAPER showOnlyMySubs:!self.defaultSubs userId:self.user[@"user_id"] controlKey:self.controlKey completion:^(NSError *error) {
            [self reloadData:nil];
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [SCRAPER logoutWithcompletion:^(BOOL result, NSError *error) {
            [self reloadData:nil];
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didPressNotificationsBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    [SCRAPER notificationsWithCompletion:^(NSDictionary *notifications, NSError *error) {
        
        NSLog(@"Notifications: %@", notifications);
    }];
}

@end
