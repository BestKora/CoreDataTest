//
//  UpdateView.swift
//  TestCoreData
//
//  Created by Tatiana Kornilova on 14/02/2022.
//

import SwiftUI

struct UpdateView: View {
    @ObservedObject var item : Item
    
    var body: some View {
        VStack {
            DatePicker("",selection: $item.timestamp,  displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .labelsHidden()
                .onChange(of: item, perform: { newValue in
                    item.managedObjectContext?.saveContext()
                })
                .padding(5)
                .border(Color.cyan)
        }
    }
}


struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext =  PersistenceController(inMemory: true).viewContext
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        return UpdateView(item: newItem)
            .environment(\.managedObjectContext, viewContext)
    }
}

