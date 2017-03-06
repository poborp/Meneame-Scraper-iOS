//
//  SCManageModel.m
//  ScrAPPer
//
//  Created by Jacobo Rodriguez on 1/3/17.
//  Copyright © 2017 tBear Software. All rights reserved.
//

#import "SCManageModel.h"

static NSString * const kModelFileName = @"Meneame";
static NSString * const kDBFileName    = @"Meneame.sqlite";

@implementation SCManageModel

@synthesize mainObjectContext = _mainObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (instancetype)sharedModel {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

#pragma mark - Core Data stack

/// Returns the managed object context for the application.
/// If the context doesn't already exist, it is created and bound to the persistent store
/// coordinator for the application.
- (NSManagedObjectContext *)mainObjectContext {
    
    if (!_mainObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator) {
            _mainObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            [_mainObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _mainObjectContext;
}

/// Returns the managed object model for the application.
/// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    
    if (!_managedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kModelFileName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

/// Returns the persistent store coordinator for the application.
/// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (!_persistentStoreCoordinator) {
        
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:kDBFileName];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES,
                                  NSInferMappingModelAutomaticallyOption: @YES};
        
        NSError *error = nil;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
            /*
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             */
            DLog(@"Unresolved error %@, %@", error, error.userInfo);
            DLog(@"==> Wiping out the database");
            
            NSError *fileError = nil;
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&fileError];
            if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
                DLog(@"Unresolved error %@, %@", error, error.userInfo);
            }
        }
        
        NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionCompleteUnlessOpen forKey:NSFileProtectionKey];
        
        if (![[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:[storeURL path] error:&error]) {
            DLog(@"%@", error.localizedDescription);
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory {
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Saving methods

- (void)saveContext {
    
    [self saveContext:self.mainObjectContext];
}

- (void)saveContext:(NSManagedObjectContext *)context {
    
    NSError *error = nil;
    if (context && [context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        DLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
}

@end
