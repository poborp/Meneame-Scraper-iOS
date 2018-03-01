//
//  SCCommentVO.m
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "SCCommentVO.h"

#import "SCManageModel.h"
#import "SCNewsVO.h"
#import "SCUserVO.h"

@implementation SCCommentVO

+ (instancetype)new {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:COREDATA.mainObjectContext];
    id object = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:COREDATA.mainObjectContext];
    return object;
}

+ (instancetype)objectFromSourceCode:(NSString *)sourceCode {
    
    NSString *commentOrder = [sourceCode substringFromString:@"class=\"comment-order\" rel=\"nofollow\">#" toString:@"</a>"];
    if (commentOrder.length == 0) {
        return nil;
    }
    
    SCCommentVO *comment = [SCCommentVO new];
    
//    NSString *userImageUrl = [sourceCode substringFromString:@"<img src=\"" toString:@"\""];
//    comment.userImageUrl = userImageUrl;
    
    NSString *imageSrc = imageSrc = [sourceCode substringFromString:@" data-src=\"" toString:@"\""];
    comment.userImageUrl = imageSrc.length > 0 ? [NSString stringWithFormat:@"https://mnmstatic.net/%@", imageSrc] : nil;
    
    comment.num = [commentOrder intValue];
    
    NSString *usernameClass = [sourceCode substringFromString:@"<a class=\"username\"" toString:@"</a>"];
    NSString *userUrl = [usernameClass substringFromString:@"href=\"" toString:@"\""];
    comment.userUrl = userUrl;
    
    NSString *userId = [usernameClass substringFromString:@"id=\"" toString:@"\""];
    comment.userId = userId;
    
    NSString *username = [usernameClass substringFromString:@">" toString:@"<"];
    comment.username = username;
    
    NSString *timestamp = [sourceCode substringFromString:@"<span class=\"ts showmytitle comment-date\" data-ts=\"" toString:@"\""];
    NSTimeInterval timestampTimeInterval = (NSTimeInterval)[timestamp doubleValue];
    comment.date = [NSDate dateWithTimeIntervalSince1970:timestampTimeInterval];
    
    NSString *commentClass = [sourceCode substringFromString:@"<div class=\"comment-text\"" toString:@"</div>"];
    NSString *commentId = [commentClass substringFromString:@"id=\"" toString:@"\""];
    comment.commentId = commentId;
    
    NSString *commentText = [commentClass substringFromString:@">" toString:nil];
    comment.text = commentText;
    
    return comment;
}

+ (NSArray *)allObjectsFromSourceCode:(NSString *)sourceCode {
    
    NSMutableArray *newsFound = [NSMutableArray new];
    
    NSArray *elements = [sourceCode componentsSeparatedByString:@"threader zero"];
    for (NSString *elementSourceCode in elements) {
        if (elementSourceCode != elements.firstObject) {
            SCCommentVO *element = [self objectFromSourceCode:elementSourceCode];
            if (element) {
                [newsFound addObject:element];
            }
        }
    }
    
    return newsFound;
}

+ (NSArray *)allObjectsFromArray:(NSArray *)array {
    
    NSMutableArray *objects = [NSMutableArray new];
    for (NSString *elementSourceCode in array) {
        SCCommentVO *element = [self objectFromSourceCode:elementSourceCode];
        if (element) {
            [objects addObject:element];
        }
    }
    return objects;
}

@end
