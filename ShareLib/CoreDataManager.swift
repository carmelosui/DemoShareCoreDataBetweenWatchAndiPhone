//
//  CoreDataManager.swift
//  PomodoroWatch
//
//  Created by Carmelo Sui on 4/10/15.
//  Copyright (c) 2015 Carmelo Sui. All rights reserved.
//

import CoreData

public class CoreDataManager: NSObject {
    public static let sharedInstance = CoreDataManager()
    
    let shareGroupName = "group.com.carmelosui.demowatchcoredata"
    
    func sharedContainerDirectoryURL() -> NSURL {
        return NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(shareGroupName)!
    }
    
    func libBundle() -> NSBundle {
        return NSBundle(forClass: self.dynamicType)
    }
    
    //MARM: path configurations
    private lazy var sqliteFileURL: NSURL = {
        let containerURL = self.sharedContainerDirectoryURL()
        let sqliteURL = containerURL.URLByAppendingPathComponent("coredatatest.sqlite")
        return sqliteURL
    }()
    
    //MARK: Core Data Stack
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = self.libBundle().URLForResource("Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let containerURL = self.sharedContainerDirectoryURL()
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.sqliteFileURL, options: nil, error: &error) == nil {
            abort()
        }
        
        return coordinator
        }()
    
    public lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext () {
        let moc = self.managedObjectContext
        var error: NSError? = nil
        if moc.hasChanges && !moc.save(&error) {
            abort()
        }
    }
}
