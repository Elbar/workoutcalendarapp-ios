//
//  WorkoutMetadata.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


struct WorkoutMetadata: Codable {
    let workoutKey: String
    let activityType: String
    let startDate: String
    let distance: String
    let duration: String
    let comment: String?
    
    var distanceKm: Double {
        Double(distance) ?? 0 / 1000
    }
    
    var durationMinutes: Int {
        Int(Double(duration) ?? 0) / 60
    }
    
    var formattedDistance: String {
        let km = distanceKm / 1000
        return String(format: "%.2f км", km)
    }
    
    var formattedDuration: String {
        let minutes = durationMinutes
        let hours = minutes / 60
        let mins = minutes % 60
        if hours > 0 {
            return "\(hours) ч \(mins) мин"
        }
        return "\(mins) мин"
    }
}