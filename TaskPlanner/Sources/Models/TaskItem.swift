import Foundation

struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
}
