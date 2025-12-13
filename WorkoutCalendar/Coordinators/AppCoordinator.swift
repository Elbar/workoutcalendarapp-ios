//
//  AppRoute.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


import SwiftUI

enum AppRoute: Hashable {
    case workoutDetail(Workout)
}

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
