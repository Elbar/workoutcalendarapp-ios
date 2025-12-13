//
//  WorkoutCalendarApp.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//

import SwiftUI

@main
struct WorkoutCalendarApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
