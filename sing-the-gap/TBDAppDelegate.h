//
//  TBDAppDelegate.h
//  sing-the-gap
//
//  Created by Tamara Bernad on 27/05/14.
//  Copyright (c) 2014 Tamara Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
