//
//  WorkoutDetailView.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//

import SwiftUI

struct WorkoutDetailView: View {
    let workout: Workout
    @State private var metadata: WorkoutMetadata?
    @State private var diagramData: WorkoutDiagramData?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Text(workout.workoutActivityType.emoji)
                        .font(.system(size: 60))
                    
                    VStack(alignment: .leading) {
                        Text(workout.workoutActivityType.displayName)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(formattedDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
                
                if let meta = metadata {
                    // Stats
                    VStack(spacing: 15) {
                        if meta.distanceKm > 0 {
                            StatRow(icon: "figure.walk", title: "Дистанция", value: meta.formattedDistance)
                        }
                        
                        StatRow(icon: "clock", title: "Длительность", value: meta.formattedDuration)
                        
                        if let temp = meta.avgTemp {
                            StatRow(icon: "thermometer", title: "Температура", value: "\(temp)°C")
                        }
                        
                        if let comment = meta.comment {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Комментарий", systemImage: "text.quote")
                                    .font(.headline)
                                Text(comment)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Heart Rate Chart
                    if let data = diagramData, !data.data.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("График пульса")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            HeartRateChartView(data: data.data)
                                .frame(height: 200)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadData()
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
        return formatter.string(from: workout.startDate)
    }
    
    private func loadData() {
        metadata = MockAPIService.shared.loadMetadata(for: workout.workoutKey)
        diagramData = MockAPIService.shared.loadDiagramData(for: workout.workoutKey)
    }
}

struct StatRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Label(title, systemImage: icon)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
