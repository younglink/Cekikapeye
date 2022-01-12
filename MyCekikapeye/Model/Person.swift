//
//  Person.swift
//  MyCekikapeye
//
//  Created by Toto on 04/11/2021.
//

import UIKit
import CoreData

class Person: NSManagedObject {
    static func all() throws -> [Person]{
        let request : NSFetchRequest<Person> = self.fetchRequest()
        do {
            return try AppDelegate.viewContext.fetch(request)
        } catch let error {
            throw error
        }
    }
    
//    static var all : [Person] {
//        let request : NSFetchRequest<Person> = self.fetchRequest()
//        guard let person = try? AppDelegate.viewContext.fetch(request) else { return [] }
//        return person
//    }
    
    static var count : Int {
        guard let person = try? self.all() else {
            return 0
        }
        return person.count
//        return Person.all.count
    }
}
