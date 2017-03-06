//
//  SCUserVO+CoreDataProperties.h
//  Meneame-Scraper
//
//  Created by Jacobo Rodriguez on 6/3/17.
//  Copyright © 2017 Jacobo Rodriguez. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "SCUserVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCUserVO (CoreDataProperties)

+ (NSFetchRequest<SCUserVO *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *bio;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, copy) NSString *webpage;
@property (nullable, nonatomic, retain) NSSet<SCCommentVO *> *comments;
@property (nullable, nonatomic, retain) NSSet<SCCommentVO *> *votes;

@end

@interface SCUserVO (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(SCCommentVO *)value;
- (void)removeCommentsObject:(SCCommentVO *)value;
- (void)addComments:(NSSet<SCCommentVO *> *)values;
- (void)removeComments:(NSSet<SCCommentVO *> *)values;

- (void)addVotesObject:(SCCommentVO *)value;
- (void)removeVotesObject:(SCCommentVO *)value;
- (void)addVotes:(NSSet<SCCommentVO *> *)values;
- (void)removeVotes:(NSSet<SCCommentVO *> *)values;

@end

NS_ASSUME_NONNULL_END
