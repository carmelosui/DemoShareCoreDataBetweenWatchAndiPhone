//
//  MyEntity.swift
//  ShareCoreDataBetweenWatchAndiPhone
//
//  Created by Carmelo Sui on 4/15/15.
//  Copyright (c) 2015 Carmelo Sui. All rights reserved.
//

import Foundation
import CoreData

@objc(MyEntity)
public class MyEntity: NSManagedObject {

    @NSManaged public var myAttribute: NSDate

}
