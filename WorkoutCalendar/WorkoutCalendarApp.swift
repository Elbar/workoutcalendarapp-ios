//
//  WorkoutCalendarApp.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//

import SwiftUI

@main
struct WorkoutCalendarApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environmentObject(coordinator)
        }
    }
}
