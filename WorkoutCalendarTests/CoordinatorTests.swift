//
//  CoordinatorTests.swift
//  WorkoutCalendar
//
//  Created by Elbar on 14/12/25.
//

import XCTest
@testable import WorkoutCalendar

@MainActor
final class CoordinatorTests: XCTestCase {
    
    var coordinator: AppCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = AppCoordinator()
    }
    
    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Then
        XCTAssertEqual(coordinator.path.count, 0, "Path should be empty initially")
    }
    
    func testNavigate() {
        // Given
        let workout = Workout(
            workoutKey: "123",
            workoutActivityType: .yoga,
            workoutStartDate: "2025-11-25 18:00:00"
        )
        
        // When
        coordinator.navigate(to: .workoutDetail(workout))
        
        // Then
        XCTAssertEqual(coordinator.path.count, 1, "Path should have 1 item")
    }
    
    func testPop() {
        // Given
        let workout = Workout(
            workoutKey: "123",
            workoutActivityType: .yoga,
            workoutStartDate: "2025-11-25 18:00:00"
        )
        coordinator.navigate(to: .workoutDetail(workout))
        
        // When
        coordinator.pop()
        
        // Then
        XCTAssertEqual(coordinator.path.count, 0, "Path should be empty after pop")
    }
    
    func testPopToRoot() {
        // Given
        let workout1 = Workout(workoutKey: "1", workoutActivityType: .yoga, workoutStartDate: "2025-11-25 18:00:00")
        let workout2 = Workout(workoutKey: "2", workoutActivityType: .cycling, workoutStartDate: "2025-11-23 10:00:00")
        
        coordinator.navigate(to: .workoutDetail(workout1))
        coordinator.navigate(to: .workoutDetail(workout2))
        
        // When
        coordinator.popToRoot()
        
        // Then
        XCTAssertEqual(coordinator.path.count, 0, "Path should be empty after popToRoot")
    }
}
