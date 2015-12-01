//
//  Score+CoreDataProperties.swift
//  PicTiles
//
//  Created by Puttipong S. on 12/1/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Score {

    @NSManaged var score: NSNumber?
    @NSManaged var name: String?

}
