//
//  Item+helper.swift
//  TestCoreData
//
//  Created by Tatiana Kornilova on 28/01/2022.
//

import Foundation
import CoreData

extension Item {
    
    static func delete (at offsets: IndexSet, for items:[Item]) {
        if let first = items.first, let context = first.managedObjectContext {
            offsets.map { items[$0] }.forEach(context.delete)
            try? context.save()
        }
    }
    
    //----------- Запросы --------------
    static func fetch()-> NSFetchRequest<Item>{
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp_,
                                                    ascending: false)]
        request.predicate = NSPredicate.all
        return request
    }
    
//----------- Syntax Sugar --------------
    var timestamp: Date {
        get { timestamp_ ?? Date()  }
        set { timestamp_ = newValue }
    }
}

