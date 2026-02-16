//
//  TodoItemModel.swift
//  Todo_hackathon
//
//  Created by Akshay Sonawane on 15/02/26.
//
import SwiftUI

// MARK: - Model
struct TodoItem: Identifiable, Codable {
    let id: UUID
    let title: String
    var isCompleted: Bool
    let createdDate: Date
    let description: String?
    
    // Expiration = End of Today
    var expirationDate: Date {
        Calendar.current.date(
            bySettingHour: 23,
            minute: 59,
            second: 59,
            of: createdDate
        ) ?? createdDate
    }
}
