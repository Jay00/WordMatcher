//
//  Entity.swift
//  WordMatcher
//
//  Created by Jason Clark on 3/8/15.
//  Copyright (c) 2015 Jason Clark. All rights reserved.
//

import Foundation
import CoreData

class Entity: NSManagedObject {

    @NSManaged var theWord: String
    @NSManaged var length: NSNumber
    @NSManaged var shapeTotal: NSNumber

}
