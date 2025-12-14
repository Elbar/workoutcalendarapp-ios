//
//  WorkoutModelTests.swift
//  WorkoutCalendar
//
//  Created by Elbar on 14/12/25.
//

import XCTest
@testable import WorkoutCalendar

final class WorkoutModelTests: XCTestCase {
    
    func testWorkoutDecoding() throws {
        // Given
        let json = """
        {
            "workoutKey": "7823456789012345",
            "workoutActivityType": "Walking/Running",
            "workoutStartDate": "2025-11-25 09:30:00"
        }
        """
        let data = json.data(using: .utf8)!
        
        // When
        let workout = try JSONDecoder().decode(Workout.self, from: data)
        
        // Then
        XCTAssertEqual(workout.workoutKey, "7823456789012345")
        XCTAssertEqual(workout.workoutActivityType, .walkingRunning)
        XCTAssertEqual(workout.id, "7823456789012345")
    }
    
    func testWorkoutStartDateParsing() throws {
        // Given
        let json = """
        {
            "workoutKey": "123",
            "workoutActivityType": "Yoga",
            "workoutStartDate": "2025-11-25 09:30:00"
        }
        """
        let data = json.data(using: .utf8)!
        let workout = try JSONDecoder().decode(Workout.self, from: data)
        
        // When
        let startDate = workout.startDate
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: startDate)
        
        // Then
        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.day, 25)
        XCTAssertEqual(components.hour, 9)
        XCTAssertEqual(components.minute, 30)
    }
}
