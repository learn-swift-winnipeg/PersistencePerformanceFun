import UIKit

// MARK: - MeasuringPerformanceViewController

class MeasuringPerformanceViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var storageProviderSegmentedControl: UISegmentedControl!
    @IBOutlet var storeCountTextField: UITextField!
    @IBOutlet var storingResultsLabel: UILabel!
    
    @IBOutlet var retrievingResultsLabel: UILabel!
    
    // MARK: - Stored Properties
    
    private var storageProvider: StorageProvider = UserDefaultsStorageProvider()
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 5
        
        return numberFormatter
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        storingResultsLabel.numberOfLines = 0
        retrievingResultsLabel.numberOfLines = 0
    }
    
    // MARK: - Actions
    
    @IBAction func storageProviderChanged(_ sender: Any) {
        clearStorageAndUI()
        
        switch storageProviderSegmentedControl.selectedSegmentIndex {
        case 0: storageProvider = UserDefaultsStorageProvider()
        case 1: storageProvider = FileManagerStorageProvider()
        default: print("Unknown storage provider selected.")
        }
    }
    
    private func clearStorageAndUI() {
        do {
            let emptyTodos: [Todo] = []
            let emptyTodosData = try JSONEncoder().encode(emptyTodos)
            try storageProvider.store(data: emptyTodosData, forKey: .todos)
            let _ = try storageProvider.data(forKey: .todos)
            
            storingResultsLabel.text = "Results"
            retrievingResultsLabel.text = "Results"
        } catch {
            print(error)
        }
    }
    
    @IBAction func storeTapped(_ sender: Any) {
        guard let numberOfRecordsToStore = Int(storeCountTextField.text!) else { return }
        guard numberOfRecordsToStore >= 0 else { return }
        
        storeCountTextField.resignFirstResponder()
        
        let todo = Todo(
            title: UUID().uuidString,
            dueDate: Date(),
            priority: .high
        )

        let recordsToStore = Array(repeating: todo, count: numberOfRecordsToStore)
        
        let startTime = DispatchTime.now()
        
        let dataToStore = try! JSONEncoder().encode(recordsToStore)
        
        let encodedTime = DispatchTime.now()
        
        try! storageProvider.store(data: dataToStore, forKey: .todos)
        
        let storedTime = DispatchTime.now()
        
        let secondsToEncode = startTime.timeInterval(to: encodedTime)
        let secondsToStore = encodedTime.timeInterval(to: storedTime)
        let secondsToComplete = startTime.timeInterval(to: storedTime)
        
        let kilobytesOfData = Double(dataToStore.count) / 1000.0
        
        storingResultsLabel.text =
        """
         Records: \(numberOfRecordsToStore)
            Size: \(kilobytesOfData) KB
          Encode: \(numberFormatter.string(for: secondsToEncode)!)s
           Store: \(numberFormatter.string(for: secondsToStore)!)s
           Total: \(numberFormatter.string(for: secondsToComplete)!)s
        """
    }
    
    @IBAction func retrieveTapped(_ sender: Any) {
        storeCountTextField.resignFirstResponder()
        
        let startTime = DispatchTime.now()
        
        guard let data = try! storageProvider.data(forKey: .todos) else { return }
        
        let retrievedTime = DispatchTime.now()
        
        let records = try! JSONDecoder().decode([Todo].self, from: data)
        
        let decodedTime = DispatchTime.now()
        
        let secondsToRetrieve = startTime.timeInterval(to: retrievedTime)
        let secondsToDecode = retrievedTime.timeInterval(to: decodedTime)
        let secondsToComplete = startTime.timeInterval(to: decodedTime)
        
        let kilobytesOfData = Double(data.count) / 1000.0
        
        retrievingResultsLabel.text =
        """
         Records: \(records.count)
            Size: \(kilobytesOfData) KB
        Retrieve: \(numberFormatter.string(for: secondsToRetrieve)!)s
          Decode: \(numberFormatter.string(for: secondsToDecode)!)s
           Total: \(numberFormatter.string(for: secondsToComplete)!)s
        """
    }
}
