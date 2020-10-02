//
//  History+CoreDataProperties.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var username: String?
    @NSManaged public var qusetion: String?
    @NSManaged public var userId: UUID?
    @NSManaged public var answer: String?

}

extension History : Identifiable {

}
