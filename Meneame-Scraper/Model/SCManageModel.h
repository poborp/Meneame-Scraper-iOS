//
//  SCManageModel.h
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 1/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define COREDATA ([SCManageModel sharedModel])

@interface SCManageModel : NSObject

@property (nonatomic, strong, readonly) NSManagedObjectContext       *mainObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel         *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)sharedModel;

- (void)saveContext;

@end
