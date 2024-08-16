
import UIKit

class SegmentController: UIViewController {
    
    let items = ["Фото", "Видео"]
    
    lazy var segmentContol: UISegmentedControl = {
        let view = UISegmentedControl(items: items)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(colorChandeg), for: .valueChanged)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(segmentContol)
        navigationItem.titleView = segmentContol
        
        NSLayoutConstraint.activate([
            segmentContol.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            segmentContol.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: segmentContol.trailingAnchor, multiplier: 4),
            
        ])
        // Do any additional setup after loading the view.
    }

    @objc func colorChandeg() {
        switch segmentContol.selectedSegmentIndex {
        case 0:
            let newVC = PhotosVC()
            present(newVC, animated: true, completion: nil)
        case 1:
            let newVCc = AppViewController()
            present(newVCc, animated: true, completion: nil)
        default:
            print("Something went wrong")
        }
    }
}

