//
//  T+CoreDataProperties.swift
//  
//
//  Created by Thomas Liu on 2016/10/28.
//
//

import Foundation
import CoreData


extension T {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: "T");
    }

    @NSManaged public var t: String?

}
