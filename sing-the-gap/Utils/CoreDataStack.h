//
//  CoreDataStack.h
//  CoreDataExample
//
//  Created by Tamara Bernad on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataStack : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSManagedObjectContext *)childManagedObjectContext;
- (NSManagedObjectContext *)independentManagedObjectContext;
+ (CoreDataStack *)coreDataStack;

+ (NSManagedObject *)fetchEntity:(NSString *)entity WithSortKey:(NSString *)sortKey Ascending:(BOOL)ascending WithPredicate:(NSPredicate *)predicate;
+ (NSManagedObject *)fetchEntity:(NSString *)entity WithPredicate:(NSPredicate *)predicate;
+ (NSArray *)fetchEntities:(NSString *)entity WithSortKey:(NSString *)sortKey Ascending:(BOOL)ascending WithPredicate:(NSPredicate *)predicate;
+ (NSManagedObject*) createEntityWithName:(NSString *)entityName;
@end
