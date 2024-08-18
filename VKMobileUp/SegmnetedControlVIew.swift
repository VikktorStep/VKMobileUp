
import UIKit

class SegmentedControlView: UISegmentedControl {
    
    init() {
        super.init(items: ["Фото", "Видео"])
        selectedSegmentIndex = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
