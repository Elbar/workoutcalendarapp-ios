//
//  WorkoutListView.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//
import SwiftUI

struct WorkoutListView: View {
    let workouts: [Workout]
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ScrollView {
            if workouts.isEmpty {
                Text("Нет тренировок")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(workouts) { workout in
                        WorkoutRowView(workout: workout)
                            .onTapGesture {
                                coordinator.navigate(to: .workoutDetail(workout))
                            }
                    }
                }
                .padding()
            }
        }
    }
}

struct WorkoutRowView: View {
    let workout: Workout
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: workout.startDate)
    }
    
    var body: some View {
        HStack(spacing: 15) {
            Text(workout.workoutActivityType.emoji)
                .font(.system(size: 40))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(workout.workoutActivityType.displayName)
                    .font(.headline)
                
                Text(timeString)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
