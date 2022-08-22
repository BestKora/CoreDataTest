//
//  ContentView.swift
//  CoreDataTest
//
//  Created by Tatiana Kornilova on 15.02.2022

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(fetchRequest: Item.fetch(), animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink(item.timestamp.formatted(date: .abbreviated, time: .shortened), value: item)
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) { Label("", systemImage: "plus")}
                }
            }
            .navigationTitle("Select an item")
            .navigationDestination(for: Item.self) { item in
                UpdateView(item: item)
            }
        }
    }

    private func addItem() {
         withAnimation {
             let newItem = Item(context: viewContext)
             newItem.timestamp = Date()
             viewContext.saveContext()
         }
     }
     
     private func deleteItems(offsets: IndexSet) {
         withAnimation {
             Item.delete(at: offsets, for: Array(items))
         }
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext =  PersistenceController(inMemory:true).viewContext
        
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        viewContext.saveContext()
        return ContentView().environment(\.managedObjectContext, viewContext)
    }
}


