//
//  WorkoutMetadata.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


struct WorkoutMetadata: Codable {
    let workoutKey: String
    let workoutActivityType: WorkoutType
    let workoutStartDate: String
    let distance: String
    let duration: String
    let comment: String?
    let avgTemp: String?
    let avgHumidity: String?
    
    enum CodingKeys: String, CodingKey {
        case workoutKey, workoutActivityType, workoutStartDate
        case distance, duration, comment
        case avgTemp = "avg_temp"
        case avgHumidity = "avg_humidity"
    }
    
    var distanceKm: Double {
        Double(distance) ?? 0.0
    }
    
    var durationMinutes: Int {
        let seconds = Double(duration) ?? 0
        return Int(seconds / 60)
    }
    
    var formattedDistance: String {
        String(format: "%.2f км", distanceKm / 1000)
    }
    
    var formattedDuration: String {
        let hours = durationMinutes / 60
        let mins = durationMinutes % 60
        return hours > 0 ? "\(hours)ч \(mins)м" : "\(mins)м"
    }
}

