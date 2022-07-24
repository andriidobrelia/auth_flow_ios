//
//  Country+CoreDataClass.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 03.07.2022.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {
    
    convenience init?(context: NSManagedObjectContext, name: String, capital: String, area: Int32, currency: String, population: Double, imageUrl: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Countries", in: context) else {
            return nil
        }
        
        self.init(entity: entity, insertInto: context)
        self.name = name
        self.capital = capital
        self.area = area
        self.currency = currency
        self.population = population
        self.imageUrl = imageUrl
    }
    
}
