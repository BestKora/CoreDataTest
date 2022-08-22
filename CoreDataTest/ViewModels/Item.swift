//
//  Item+helper.swift
//  TestCoreData
//
//  Created by Tatiana Kornilova on 28/01/2022.
//

import Foundation
import CoreData

extension Item {
    //----------- Syntax Sugar --------------
        var timestamp: Date {
        get { timestamp_ ?? Date()  }
        set { timestamp_ = newValue }
    }
    
    //----------- Requests --------------
    static func fetch()-> NSFetchRequest<Item>{
        let request = NSFetchRequest<Item>(entityName: "Item")
        
        request.predicate = NSPredicate.all
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp_,
                                                    ascending: true)]
        return request
    }
    
    //----------- Intents --------------
    static func delete (at offsets: IndexSet, for items:[Item]) {
        if let first = items.first, let context = first.managedObjectContext {
            offsets.map { items[$0] }.forEach(context.delete)
            context.saveContext()
        }
    }
}

