//
//  CalendarViewModel.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


import SwiftUI

@MainActor
class CalendarViewModel: ObservableObject {
    @Published var currentMonth: Date = Date()
    @Published var selectedDate: Date?
    @Published var workouts: [Workout] = []
    
    private let apiService = MockAPIService.shared
    private let calendar = Calendar.current
    
    init() {
        loadWorkouts()
    }
    
    func loadWorkouts() {
        workouts = apiService.loadWorkouts()
    }
    
    func workoutsForSelectedDate() -> [Workout] {
        guard let selected = selectedDate else { return [] }
        return workouts.filter { calendar.isDate($0.startDate, inSameDayAs: selected) }
    }
    
    func hasWorkouts(on date: Date) -> Bool {
        workouts.contains { calendar.isDate($0.startDate, inSameDayAs: date) }
    }
    
    func moveMonth(by offset: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: offset, to: currentMonth) {
            currentMonth = newMonth
        }
    }
    
    func getDaysInMonth() -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }
        
        var days: [Date?] = []
        let monthEnd = monthInterval.end
        var currentDate = monthFirstWeek.start
        
        while currentDate < monthEnd {
            if calendar.isDate(currentDate, equalTo: currentMonth, toGranularity: .month) {
                days.append(currentDate)
            } else {
                days.append(nil)
            }
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return days
    }
    
    var monthYearString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: currentMonth).capitalized
    }
}
