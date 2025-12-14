//
//  CalendarViewModelTests.swift
//  WorkoutCalendar
//
//  Created by Elbar on 14/12/25.
//

import XCTest
@testable import WorkoutCalendar

@MainActor
final class CalendarViewModelTests: XCTestCase {
    
    var viewModel: CalendarViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CalendarViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Test Load Workouts
    
    func testLoadWorkouts() {
        // When
        viewModel.loadWorkouts()
        
        // Then
        XCTAssertFalse(viewModel.workouts.isEmpty, "Workouts should be loaded")
        XCTAssertEqual(viewModel.workouts.count, 9, "Should load 9 workouts")
    }
    
    // MARK: - Test Filtering by Date
    
    func testWorkoutsForSelectedDate_WithWorkouts() {
        // Given
        viewModel.loadWorkouts()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        viewModel.selectedDate = dateFormatter.date(from: "2025-12-12")
        
        // When
        let filteredWorkouts = viewModel.workoutsForSelectedDate()
        
        // Then
        XCTAssertEqual(filteredWorkouts.count, 2, "Should have 2 workouts on 2025-12-12")
        XCTAssertTrue(filteredWorkouts.contains { $0.workoutActivityType == .water })
        XCTAssertTrue(filteredWorkouts.contains { $0.workoutActivityType == .yoga })
    }
    
    func testWorkoutsForSelectedDate_NoWorkouts() {
        // Given
        viewModel.loadWorkouts()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        viewModel.selectedDate = dateFormatter.date(from: "2025-12-09")
        
        // When
        let filteredWorkouts = viewModel.workoutsForSelectedDate()
        
        // Then
        XCTAssertTrue(filteredWorkouts.isEmpty, "Should have no workouts on 2025-12-09")
    }
    
    func testWorkoutsForSelectedDate_NoSelectedDate() {
        // Given
        viewModel.loadWorkouts()
        viewModel.selectedDate = nil
        
        // When
        let filteredWorkouts = viewModel.workoutsForSelectedDate()
        
        // Then
        XCTAssertTrue(filteredWorkouts.isEmpty, "Should return empty array when no date selected")
    }
    
    // MARK: - Test Has Workouts
    
    func testHasWorkouts_True() {
        // Given
        viewModel.loadWorkouts()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "2025-12-12")!
        
        // When
        let hasWorkouts = viewModel.hasWorkouts(on: date)
        
        // Then
        XCTAssertTrue(hasWorkouts, "Should have workouts on 2025-12-12")
    }
    
    func testHasWorkouts_False() {
        // Given
        viewModel.loadWorkouts()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: "2025-11-26")!
        
        // When
        let hasWorkouts = viewModel.hasWorkouts(on: date)
        
        // Then
        XCTAssertFalse(hasWorkouts, "Should not have workouts on 2025-11-26")
    }
    
    // MARK: - Test Month Navigation
    
    func testMoveMonth_Forward() {
        // Given
        let calendar = Calendar.current
        let initialMonth = viewModel.currentMonth
        
        // When
        viewModel.moveMonth(by: 1)
        
        // Then
        let monthDifference = calendar.dateComponents([.month], from: initialMonth, to: viewModel.currentMonth).month
        XCTAssertEqual(monthDifference, 1, "Should move forward by 1 month")
    }
    
    func testMoveMonth_Backward() {
        // Given
        let calendar = Calendar.current
        let initialMonth = viewModel.currentMonth
        
        // When
        viewModel.moveMonth(by: -1)
        
        // Then
        let monthDifference = calendar.dateComponents([.month], from: initialMonth, to: viewModel.currentMonth).month
        XCTAssertEqual(monthDifference, -1, "Should move backward by 1 month")
    }
    
    func testMoveMonth_MultipleMonths() {
        // Given
        let calendar = Calendar.current
        let initialMonth = viewModel.currentMonth
        
        // When
        viewModel.moveMonth(by: 3)
        
        // Then
        let monthDifference = calendar.dateComponents([.month], from: initialMonth, to: viewModel.currentMonth).month
        XCTAssertEqual(monthDifference, 3, "Should move forward by 3 months")
    }
    
    // MARK: - Test Month Year String Formatting
    
    func testMonthYearString_Format() {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        viewModel.currentMonth = dateFormatter.date(from: "2025-11-15")!
        
        // When
        let monthYearString = viewModel.monthYearString
        
        // Then
        XCTAssertTrue(monthYearString.lowercased().contains("ноябрь"), "Should contain 'ноябрь'")
        XCTAssertTrue(monthYearString.contains("2025"), "Should contain '2025'")
    }
    
    // MARK: - Test Days in Month
    
    func testGetDaysInMonth_Count() {
        // Given
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        viewModel.currentMonth = dateFormatter.date(from: "2025-11-15")!
        
        // When
        let days = viewModel.getDaysInMonth()
        
        // Then
        XCTAssertFalse(days.isEmpty, "Should return days")
        // November 2025 has 30 days, but array includes days from surrounding weeks
        let nonNilDays = days.compactMap { $0 }
        XCTAssertEqual(nonNilDays.count, 30, "November should have 30 days")
    }
}
