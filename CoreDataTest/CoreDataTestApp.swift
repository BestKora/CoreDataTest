//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by Tatiana Kornilova on 15.02.2022.
//

import SwiftUI

@main
struct CoreDataTestApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              PersistenceController.shared.viewContext)
        }.onChange(of: scenePhase) { _ in
            PersistenceController.shared.viewContext.saveContext()
        }
    }
}
