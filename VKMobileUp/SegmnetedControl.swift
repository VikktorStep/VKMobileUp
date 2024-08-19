import UIKit

class SegmentedControlView: UISegmentedControl {
    
    init() {
        super.init(items: ["Фото", "Видео"])
        selectedSegmentIndex = 0
        translatesAutoresizingMaskIntoConstraints = false
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label
        ]
        self.setTitleTextAttributes(textAttributes, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
