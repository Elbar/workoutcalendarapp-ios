//
//  MockAPIServiceTests.swift
//  WorkoutCalendar
//
//  Created by Elbar on 14/12/25.
//
//

import XCTest
@testable import WorkoutCalendar

final class MockAPIServiceTests: XCTestCase {
    
    var apiService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        apiService = MockAPIService.shared
    }
    
    func testLoadWorkouts_Count() {
        // When
        let workouts = apiService.loadWorkouts()
        
        // Then
        XCTAssertEqual(workouts.count, 9, "Should load 9 workouts")
    }
    
    func testLoadWorkouts_Types() {
        // When
        let workouts = apiService.loadWorkouts()
        
        // Then
        let types = Set(workouts.map { $0.workoutActivityType })
        XCTAssertTrue(types.contains(.walkingRunning))
        XCTAssertTrue(types.contains(.yoga))
        XCTAssertTrue(types.contains(.water))
        XCTAssertTrue(types.contains(.cycling))
        XCTAssertTrue(types.contains(.strength))
    }
    
    func testLoadMetadata_ExistingWorkout() {
        // When
        let metadata = apiService.loadMetadata(for: "7823456789012345")
        
        // Then
        XCTAssertNotNil(metadata)
        XCTAssertEqual(metadata?.workoutKey, "7823456789012345")
        XCTAssertEqual(metadata?.workoutActivityType, .walkingRunning)
    }
    
    func testLoadMetadata_NonExistingWorkout() {
        // When
        let metadata = apiService.loadMetadata(for: "invalid_key")
        
        // Then
        XCTAssertNil(metadata)
    }
    
    func testLoadDiagramData_ExistingWorkout() {
        // When
        let diagramData = apiService.loadDiagramData(for: "7823456789012345")
        
        // Then
        XCTAssertNotNil(diagramData)
        XCTAssertFalse(diagramData?.data.isEmpty ?? true)
    }
    
    func testLoadDiagramData_NonExistingWorkout() {
        // When
        let diagramData = apiService.loadDiagramData(for: "invalid_key")
        
        // Then
        XCTAssertNil(diagramData)
    }
}
