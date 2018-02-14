import Foundation

struct Todo: Codable {
    let title: String
    let dueDate: Date
    
    enum Priority: String, Codable { case low, medium, high }
    let priority: Priority
}
