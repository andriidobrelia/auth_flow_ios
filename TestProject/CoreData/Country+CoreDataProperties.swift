//
//  Country+CoreDataProperties.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 03.07.2022.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Countries")
    }

    @NSManaged public var name: String?
    @NSManaged public var capital: String?
    @NSManaged public var area: Int32
    @NSManaged public var population: Double
    @NSManaged public var currency: String?
    @NSManaged public var imageUrl: String?

}

extension Country : Identifiable {

}
