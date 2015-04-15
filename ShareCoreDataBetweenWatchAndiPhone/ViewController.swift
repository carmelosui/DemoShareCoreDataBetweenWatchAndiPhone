//
//  ViewController.swift
//  ShareCoreDataBetweenWatchAndiPhone
//
//  Created by Carmelo Sui on 4/15/15.
//  Copyright (c) 2015 Carmelo Sui. All rights reserved.
//

import UIKit
import CoreData
import ShareLib

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    let entityName = "MyEntity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "MyEntity")
        let sortDescriptor = NSSortDescriptor(key: "myAttribute", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        let succ = fetchedResultController.performFetch(nil)
        assert(succ, "")
    }
    
    @IBAction func addDate(sender: AnyObject) {
        let object = NSEntityDescription.insertNewObjectForEntityForName("MyEntity", inManagedObjectContext: CoreDataManager.sharedInstance.managedObjectContext) as! MyEntity
        object.myAttribute = NSDate()
        CoreDataManager.sharedInstance.saveContext()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var fetchedResultController: NSFetchedResultsController!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let object = fetchedResultController.fetchedObjects![indexPath.row] as! MyEntity
        cell.textLabel!.text = object.myAttribute.description
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.fetchedObjects!.count
    }
}

extension ViewController {
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController,
        didChangeObject anObject: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?)
    {
        switch(type) {
            
        case .Insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([newIndexPath],
                    withRowAnimation:UITableViewRowAnimation.Fade)
            }
            
        case .Delete:
            if let indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([indexPath],
                    withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
        case .Update:
            break
            
        case .Move:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController,
        didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
        atIndex sectionIndex: Int,
        forChangeType type: NSFetchedResultsChangeType)
    {
        assert(false, "shouldn't change section")
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}

