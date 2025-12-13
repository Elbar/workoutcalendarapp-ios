//
//  DiagramData.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


struct DiagramData: Codable {
    let data: [DataPoint]
    
    struct DataPoint: Codable {
        let timeNumeric: Int
        let heartRate: Int
        let speedKmh: Double
        let distanceMeters: Int
        let currentTimestamp: String
        
        enum CodingKeys: String, CodingKey {
            case timeNumeric = "time_numeric"
            case heartRate
            case speedKmh = "speed_kmh"
            case distanceMeters
            case currentTimestamp
        }
    }
}