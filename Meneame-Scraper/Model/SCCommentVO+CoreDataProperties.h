//
//  SCCommentVO+CoreDataProperties.h
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "SCCommentVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCCommentVO (CoreDataProperties)

+ (NSFetchRequest<SCCommentVO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *commentId;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nonatomic) int32_t num;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSDate *updated;
@property (nullable, nonatomic, retain) SCNewsVO *news;
@property (nullable, nonatomic, retain) SCCommentVO *reply;
@property (nullable, nonatomic, retain) NSSet<SCCommentVO *> *responses;
@property (nullable, nonatomic, retain) SCUserVO *user;
@property (nullable, nonatomic, retain) NSSet<SCUserVO *> *votes;

@end

@interface SCCommentVO (CoreDataGeneratedAccessors)

- (void)addResponsesObject:(SCCommentVO *)value;
- (void)removeResponsesObject:(SCCommentVO *)value;
- (void)addResponses:(NSSet<SCCommentVO *> *)values;
- (void)removeResponses:(NSSet<SCCommentVO *> *)values;

- (void)addVotesObject:(SCUserVO *)value;
- (void)removeVotesObject:(SCUserVO *)value;
- (void)addVotes:(NSSet<SCUserVO *> *)values;
- (void)removeVotes:(NSSet<SCUserVO *> *)values;

@end

NS_ASSUME_NONNULL_END
