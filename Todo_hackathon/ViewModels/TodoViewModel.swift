//
//  TodoViewModel.swift
//  Todo_hackathon
//
//  Created by Akshay Sonawane on 15/02/26.
//
import SwiftUI
internal import Combine

// MARK: - ViewModel
class TodoViewModel: ObservableObject {
    //Published Variable to use in views
    @Published var tasks: [TodoItem] = []
    @Published var newTaskTitle: String = ""
    
    // Keys to store data
    private let taskStorageKey = "daily_tasks"
    private let dateKey = "last_saved_date"
    
    // MARK: - LifeCycle Methods
    init() {
        resetOnNewDay()
        loadTasks()
    }
    // MARK: - User Defined Methods
    // Method to add task
    func addTask(title: String, description: String?) {
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        
        let newTask = TodoItem(
            id: UUID(),
            title: trimmed,
            isCompleted: false,
            createdDate: Date(),
            description: description
        )
        tasks.append(newTask)
        saveTasks()
    }
    
    // Method to delete task
    func deleteTask(at offsets: IndexSet) {
        withAnimation {
            tasks.remove(atOffsets: offsets)
            saveTasks()
        }
    }
    
    // Method to toggle complete status
    func toggleComplete(_ task: TodoItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isCompleted.toggle()
        saveTasks()
    }
    
    // MARK: - Private Methods
    /// Method to Reset Day and Remove older data
    private func resetOnNewDay() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let savedDate = UserDefaults.standard.object(forKey: dateKey) as? Date {
            let savedDay = Calendar.current.startOfDay(for: savedDate)
            
            if today > savedDay {
                UserDefaults.standard.removeObject(forKey: taskStorageKey)
            }
        }
        UserDefaults.standard.set(today, forKey: dateKey)
    }
    
    /// Method to Save Data
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: taskStorageKey)
        }
    }
    
    /// Method to Load Data
    private func loadTasks() {
        guard let data = UserDefaults.standard.data(forKey: taskStorageKey),
              let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) else {
            tasks = []
            return
        }
        tasks = decoded
    }
}
