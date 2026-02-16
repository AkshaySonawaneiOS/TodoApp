//
//  TodoView.swift
//  Todo_hackathon
//
//  Created by Akshay Sonawane on 15/02/26.
//
import SwiftUI

struct TodoView: View {
    
    //MARK: - State Variables
    @StateObject private var viewModel = TodoViewModel()
    @State private var currentDate = Date()
    @State private var showAddTaskSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.tasks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.gray.opacity(0.3))
                        
                        Text("No Tasks for Today")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Tap + to add a new task")
                            .font(.caption)
                            .foregroundColor(.secondary.opacity(0.7))
                    }
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity.combined(with: .scale))
                    
                } else {
                    VStack {
                        List {
                            ForEach(viewModel.tasks) { task in
                                TodoRowView(
                                    task: task,
                                    countdownText: timeToExpire(to: task.expirationDate),
                                    onToggle: {
                                        viewModel.toggleComplete(task)
                                    }
                                )
                            }
                            .onDelete(perform: viewModel.deleteTask)
                        }
                        .listStyle(.plain)
                    }
                }
                // Floating Add Button
                VStack {
                    Spacer()
                    
                    Button {
                        showAddTaskSheet = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Today's Tasks")
            .sheet(isPresented: $showAddTaskSheet) {
                AddTaskSheetView { title, description in
                    viewModel.addTask(title: title, description: description)
                }
            }
        }
    }
    //MARK: - User Defined Methods
    private func timeToExpire(to date: Date) -> String {
        let remaining = Int(date.timeIntervalSince(currentDate))
        if remaining <= 0 { return "0:00" }
        
        let hours = remaining / 3600
        let minutes = (remaining % 3600) / 60
        
        return String(format: "%d:%02d", hours, minutes)
    }
}

#Preview {
    TodoView()
}
