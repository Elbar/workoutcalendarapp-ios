//
//  DiagramData.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


struct WorkoutDiagramData: Codable {
    let data: [DataPoint]
    
    struct DataPoint: Codable, Identifiable {
        let timeNumeric: Int
        let heartRate: Int
        let speedKmh: Double
        let distanceMeters: Int
        let steps: Int
        let currentTimestamp: String
        
        var id: Int { timeNumeric }
        
        enum CodingKeys: String, CodingKey {
            case timeNumeric = "time_numeric"
            case heartRate
            case speedKmh = "speed_kmh"
            case distanceMeters
            case steps
            case currentTimestamp
        }
    }
}
