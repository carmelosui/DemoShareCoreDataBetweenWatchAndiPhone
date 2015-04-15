//
//  InterfaceController.swift
//  ShareCoreDataBetweenWatchAndiPhone WatchKit Extension
//
//  Created by Carmelo Sui on 4/15/15.
//  Copyright (c) 2015 Carmelo Sui. All rights reserved.
//

import WatchKit
import Foundation
import CoreData
import ShareLib

class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        configureTable()
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBOutlet weak var table: WKInterfaceTable!
    
    var fetchedResultController: NSFetchedResultsController!
    
    func configureTable() {
        let fetchRequest = NSFetchRequest(entityName: "MyEntity")
        let sortDescriptor = NSSortDescriptor(key: "myAttribute", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        let fetchSucc = fetchedResultController.performFetch(nil)
        assert(fetchSucc, "")
        
        table.setNumberOfRows(fetchedResultController.fetchedObjects!.count, withRowType: "TableRowControllerIdentifier")
        for var index = 0; index < table.numberOfRows; ++index {
            let row = table.rowControllerAtIndex(index) as! TableRowController
            let object = fetchedResultController.fetchedObjects![index] as! MyEntity
            row.dateLabel.setText(object.myAttribute.description)
        }
    }
}
