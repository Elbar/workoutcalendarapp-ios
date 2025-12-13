//
//  CalendarView.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//
import SwiftUI

struct CalendarView: View {
    @StateObject private var viewModel = CalendarViewModel()
    @EnvironmentObject var coordinator: AppCoordinator
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack(spacing: 0) {
                // Month Navigation
                HStack {
                    Button(action: { viewModel.moveMonth(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text(viewModel.monthYearString)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button(action: { viewModel.moveMonth(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                // Weekday Headers
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        Text(day)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                // Calendar Grid
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(viewModel.getDaysInMonth().indices, id: \.self) { index in
                        if let date = viewModel.getDaysInMonth()[index] {
                            DayCell(
                                date: date,
                                isSelected: viewModel.selectedDate != nil && Calendar.current.isDate(date, inSameDayAs: viewModel.selectedDate!),
                                isToday: Calendar.current.isDateInToday(date),
                                hasWorkouts: viewModel.hasWorkouts(on: date)
                            )
                            .onTapGesture {
                                viewModel.selectedDate = date
                            }
                        } else {
                            Color.clear
                                .frame(height: 40)
                        }
                    }
                }
                .padding()
                
                Divider()
                
                // Workouts List
                if let _ = viewModel.selectedDate {
                    WorkoutListView(workouts: viewModel.workoutsForSelectedDate())
                } else {
                    Spacer()
                    Text("Выберите день")
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .navigationTitle("Календарь тренировок")
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .workoutDetail(let workout):
                    WorkoutDetailView(workout: workout)
                }
            }
        }
    }
}

struct DayCell: View {
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let hasWorkouts: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Text(Calendar.current.component(.day, from: date), format: .number)
                .font(.body)
                .foregroundColor(isSelected ? .white : (isToday ? .blue : .primary))
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(isSelected ? Color.blue : (isToday ? Color.blue.opacity(0.1) : Color.clear))
                )
            
            if hasWorkouts {
                Circle()
                    .fill(isSelected ? .white : .blue)
                    .frame(width: 5, height: 5)
            }
        }
    }
}
