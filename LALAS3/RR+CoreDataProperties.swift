//
//  RR+CoreDataProperties.swift
//  
//
//  Created by Thomas Liu on 16/9/20.
//
//

import Foundation
import CoreData


extension RR {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RR> {
        return NSFetchRequest<RR>(entityName: "RR");
    }

    @NSManaged public var id: Int32

}
