import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = [] {
        didSet {
            saveTasks()
        }
    }
    
    private let tasksKey = "saved_tasks"
    
    init() {
        loadTasks()
    }
    
    func addTask(title: String, description: String) {
        let newTask = TaskItem(title: title, description: description)
        tasks.insert(newTask, at: 0)
    }
    
    func toggleTask(task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }
    
    private func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: tasksKey),
           let decodedTasks = try? JSONDecoder().decode([TaskItem].self, from: savedData) {
            tasks = decodedTasks
        }
    }
}
