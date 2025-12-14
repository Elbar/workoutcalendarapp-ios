//
//  WorkoutMetadataTests.swift
//  WorkoutCalendar
//
//  Created by Elbar on 14/12/25.
//
import XCTest
@testable import WorkoutCalendar


final class WorkoutMetadataTests: XCTestCase {
    
    var metadata: WorkoutMetadata!
    
    override func setUp() {
        super.setUp()
        metadata = WorkoutMetadata(
            workoutKey: "123",
            workoutActivityType: .walkingRunning,
            workoutStartDate: "2025-11-25 09:30:00",
            distance: "5230.50",
            duration: "2700.00",
            comment: "Test workout",
            avgTemp: "12.50",
            avgHumidity: "65.00"
        )
    }
    
    func testDistanceKm_Calculation() {
        // When
        let distanceKm = metadata.distanceKm
        
        // Then
        XCTAssertEqual(distanceKm, 5230.50, accuracy: 0.01)
    }
    
    func testDurationMinutes_Calculation() {
        // When
        let durationMinutes = metadata.durationMinutes
        
        // Then
        XCTAssertEqual(durationMinutes, 45) // 2700 seconds = 45 minutes
    }
    
    func testFormattedDistance() {
        // When
        let formatted = metadata.formattedDistance
        
        // Then
        XCTAssertEqual(formatted, "5.23 км")
    }
    
    func testFormattedDuration_WithHours() {
        // Given
        let metadata = WorkoutMetadata(
            workoutKey: "123",
            workoutActivityType: .cycling,
            workoutStartDate: "2025-11-23 10:00:00",
            distance: "25430.00",
            duration: "5400.00", // 90 minutes
            comment: nil,
            avgTemp: nil,
            avgHumidity: nil
        )
        
        // When
        let formatted = metadata.formattedDuration
        
        // Then
        XCTAssertEqual(formatted, "1ч 30м")
    }
    
    func testFormattedDuration_WithoutHours() {
        // When
        let formatted = metadata.formattedDuration
        
        // Then
        XCTAssertEqual(formatted, "45м")
    }
}
