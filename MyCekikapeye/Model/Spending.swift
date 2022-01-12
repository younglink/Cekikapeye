//
//  Spending.swift
//  MyCekikapeye
//
//  Created by Toto on 08/10/2021.
//

import Foundation
import CoreData

class Spending : NSManagedObject{
    static var all : [[Spending]] {
        let request : NSFetchRequest<Spending> = Spending.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "amount", ascending: true),
            NSSortDescriptor(key: "person.name", ascending: true)
        ]
        guard let spendings = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return spendings.convertedToArrayOfArray
    }
    
    static var number : Int {
        var count = 0
        for array in all {
            count += array.count
        }
        return count
    }
}

extension Array where Element == Spending {
    
    var convertedToArrayOfArray : [[Spending]] {
        var dict = [Person: [Spending]] ()
        
        for spending in self where spending.person != nil {
            dict[ spending.person!, default: [] ].append(spending)
        }
        
        var result = [[Spending]] ()
        for (_,val) in dict { result.append(val) }
        
        result.sort { (firstSpending, secondSpending) -> Bool in
            if (firstSpending[0].person?.name)! < (secondSpending[0].person?.name)! {
                return true
            } else {
                return false
            }
        }
        return result
    }
}
