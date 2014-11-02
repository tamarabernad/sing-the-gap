//
//  CoreDataStack.m
//  CoreDataExample
//
//  Created by Tamara Bernad on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataStack.h"

@implementation CoreDataStack

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;


+ (CoreDataStack *)coreDataStack{
    static CoreDataStack *theSigleton = nil;
    //se mantiene en memoria como variable global pero su ambito es restringido a un método
    // la declaracion solo se llamará una vez
    if(theSigleton == nil){
        theSigleton = [[CoreDataStack alloc] init];
    }
    return theSigleton;
}
+ (NSManagedObject *)fetchEntity:(NSString *)entity WithSortKey:(NSString *)sortKey Ascending:(BOOL)ascending WithPredicate:(NSPredicate *)predicate{
    
    NSManagedObjectContext *context = [[CoreDataStack coreDataStack] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entity inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    if(sortKey){
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:sortKey ascending:ascending];
        [request setSortDescriptors:@[sortDescriptor]];
    }
    
    
    if(predicate){
        [request setPredicate:predicate];
    }
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (error != nil || array == nil)
    {
        NSLog(@"CoreDataStack::ErrorFeching::Entity %@ With Predicat: %@",entity, predicate);
    }
    return [array firstObject];
}
+ (NSManagedObject *)fetchEntity:(NSString *)entity WithPredicate:(NSPredicate *)predicate{
    NSManagedObjectContext *context = [[CoreDataStack coreDataStack] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entity inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    if(predicate){
        [request setPredicate:predicate];
    }
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (error != nil || array == nil)
    {
        NSLog(@"CoreDataStack::ErrorFeching::Entity %@ With Predicat: %@",entity, predicate);
    }
    return [array firstObject];
}
+ (NSArray *)fetchEntities:(NSString *)entity WithSortKey:(NSString *)sortKey Ascending:(BOOL)ascending WithPredicate:(NSPredicate *)predicate{
    NSManagedObjectContext *context = [[CoreDataStack coreDataStack] managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entity inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    if(sortKey){
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:sortKey ascending:ascending];
        [request setSortDescriptors:@[sortDescriptor]];
    }
    if(predicate){
        [request setPredicate:predicate];
    }
    
    NSError *error;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (error != nil || array == nil)
    {
        NSLog(@"CoreDataStack::ErrorFeching::Entity %@ With Predicat: %@",entity, predicate);
    }
    return array;
}
+ (NSManagedObject*) createEntityWithName:(NSString *)entityName {
    NSManagedObjectContext *context = [[CoreDataStack coreDataStack] managedObjectContext];
    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:entityName
                                                            inManagedObjectContext:context];
    
    return entity;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)childManagedObjectContext
{
   
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    managedObjectContext.parentContext = __managedObjectContext;
    
    return managedObjectContext;
}
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)independentManagedObjectContext
{
    
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
        [managedObjectContext setMergePolicy:[[NSMergePolicy alloc] initWithMergeType:NSMergeByPropertyStoreTrumpMergePolicyType]];
        [managedObjectContext setUndoManager:nil];
    }
    return managedObjectContext;
}
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
        [__managedObjectContext setMergePolicy:[[NSMergePolicy alloc] initWithMergeType:NSMergeByPropertyStoreTrumpMergePolicyType]];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"sing_the_gap" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"sing_the_gap.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    
    
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil] error:&error])
    {
        
        
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
