//
//  WorkoutTypeTests.swift
//  WorkoutCalendar
//
//  Created by Elbar on 14/12/25.
//

import XCTest
@testable import WorkoutCalendar

final class WorkoutTypeTests: XCTestCase {
    
    func testWorkoutType_Emoji() {
        XCTAssertEqual(WorkoutType.walkingRunning.emoji, "🏃")
        XCTAssertEqual(WorkoutType.yoga.emoji, "🧘")
        XCTAssertEqual(WorkoutType.water.emoji, "🏊")
        XCTAssertEqual(WorkoutType.cycling.emoji, "🚴")
        XCTAssertEqual(WorkoutType.strength.emoji, "💪")
    }
    
    func testWorkoutType_DisplayName() {
        XCTAssertEqual(WorkoutType.walkingRunning.displayName, "Бег/Ходьба")
        XCTAssertEqual(WorkoutType.yoga.displayName, "Йога")
        XCTAssertEqual(WorkoutType.water.displayName, "Плавание")
        XCTAssertEqual(WorkoutType.cycling.displayName, "Велоспорт")
        XCTAssertEqual(WorkoutType.strength.displayName, "Силовая")
    }
    
    func testWorkoutType_RawValue() {
        XCTAssertEqual(WorkoutType.walkingRunning.rawValue, "Walking/Running")
        XCTAssertEqual(WorkoutType.yoga.rawValue, "Yoga")
        XCTAssertEqual(WorkoutType.water.rawValue, "Water")
        XCTAssertEqual(WorkoutType.cycling.rawValue, "Cycling")
        XCTAssertEqual(WorkoutType.strength.rawValue, "Strength")
    }
}
