//
//  HeartRateChartView.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//

import SwiftUI

struct HeartRateChartView: View {
    let data: [WorkoutDiagramData.DataPoint]
    
    var body: some View {
        GeometryReader { geometry in
            let maxHR = data.map { $0.heartRate }.max() ?? 200
            let minHR = data.map { $0.heartRate }.min() ?? 60
            let range = CGFloat(maxHR - minHR)
            
            ZStack {
                // Grid lines
                ForEach(0..<5) { i in
                    let y = geometry.size.height * CGFloat(i) / 4
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
                
                // Line chart
                Path { path in
                    guard !data.isEmpty else { return }
                    
                    let stepX = geometry.size.width / CGFloat(data.count - 1)
                    
                    for (index, point) in data.enumerated() {
                        let x = CGFloat(index) * stepX
                        let normalizedHR = CGFloat(point.heartRate - minHR) / range
                        let y = geometry.size.height * (1 - normalizedHR)
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .stroke(Color.red, lineWidth: 2)
                
                // Points
                ForEach(data.indices, id: \.self) { index in
                    let point = data[index]
                    let x = CGFloat(index) * (geometry.size.width / CGFloat(data.count - 1))
                    let normalizedHR = CGFloat(point.heartRate - minHR) / range
                    let y = geometry.size.height * (1 - normalizedHR)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 6, height: 6)
                        .position(x: x, y: y)
                }
                
                // Labels
                VStack {
                    Spacer()
                    HStack {
                        Text("\(minHR) bpm")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(maxHR) bpm")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
