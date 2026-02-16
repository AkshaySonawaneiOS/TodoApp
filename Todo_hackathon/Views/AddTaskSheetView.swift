import SwiftUI

struct AddTaskSheetView: View {
    
    //MARK: - State and Environment Variables
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var description: String = ""
    
    var onAdd: (String, String?) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                TextField("Task Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Task Description", text: $description)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                // Cancel Button (Left)
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                // Add Button (Right)
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd(title, description)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
