//
//  TaskRowView.swift
//  Todo_hackathon
//
//  Created by Akshay Sonawane on 16/02/26.
//

import SwiftUI

struct TodoRowView: View {
    
    //MARK: -  Variables
    let task: TodoItem
    let countdownText: String
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .gray)
                .scaleEffect(task.isCompleted ? 1.2 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: task.isCompleted)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        onToggle()
                    }
                }
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .strikethrough(task.isCompleted)
                    .opacity(task.isCompleted ? 0.6 : 1)
                    .animation(.easeInOut(duration: 0.2), value: task.isCompleted)
                
                if let description = task.description,
                   !description.isEmpty {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .opacity(task.isCompleted ? 0.5 : 1)
                        .animation(.easeInOut(duration: 0.2), value: task.isCompleted)
                }
            }
            
            Spacer()
            VStack {
                Text("Expires in")
                    .font(.caption)
                    .foregroundStyle(.red.opacity(0.8))
                    .opacity(task.isCompleted ? 0.5 : 1)
                    .animation(.easeInOut(duration: 0.2), value: task.isCompleted)
                Text(countdownText)
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.red.opacity(0.8))
                    .opacity(task.isCompleted ? 0.5 : 1)
                    .animation(.easeInOut(duration: 0.2), value: task.isCompleted)
            }

        }
        .padding(.vertical, 4)
    }
}

