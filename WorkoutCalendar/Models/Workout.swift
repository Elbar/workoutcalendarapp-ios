//
//  Workout.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//

import Foundation

struct Workout: Codable, Identifiable, Equatable {
    let workoutKey: String
    let workoutActivityType: WorkoutType
    let workoutStartDate: String
    
    var id: String { workoutKey }
    
    var startDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: workoutStartDate) ?? Date()
    }
}

enum WorkoutType: String, Codable {
    case walkingRunning = "Walking/Running"
    case yoga = "Yoga"
    case water = "Water"
    case cycling = "Cycling"
    case strength = "Strength"
    
    var emoji: String {
        switch self {
        case .walkingRunning: return "🏃"
        case .yoga: return "🧘"
        case .water: return "🏊"
        case .cycling: return "🚴"
        case .strength: return "💪"
        }
    }
    
    var displayName: String {
        switch self {
        case .walkingRunning: return "Бег/Ходьба"
        case .yoga: return "Йога"
        case .water: return "Плавание"
        case .cycling: return "Велоспорт"
        case .strength: return "Силовая"
        }
    }
}
