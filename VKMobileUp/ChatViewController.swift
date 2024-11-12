import UIKit

class ChatViewController: UIViewController {
    private let tableView = UITableView()
    
    private var cells: [CellToShow] = [
        CellToShow(type: .imageCell, data: "https://google.com/randomImage1"),
        CellToShow(type: .textCell, data: "Some text message")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    private func setupTableView() {
        tableView.register(TextMessageCell.self, forCellReuseIdentifier: CellType.textCell.rawValue)
        tableView.register(ImageMessageCell.self, forCellReuseIdentifier: CellType.imageCell.rawValue)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func onTapped(cell: CellToShow, index: Int) {
        print("Нажата ячейка с индексом \(index), тип: \(cell.type)")
    }
}
// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = cells[indexPath.row]
        
        switch cellData.type {
        case .textCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.textCell.rawValue, for: indexPath) as? TextMessageCell else {
                return UITableViewCell()
            }
            cell.configure(text: cellData.data)
            return cell

        case .imageCell:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellType.imageCell.rawValue, for: indexPath) as? ImageMessageCell else {
                return UITableViewCell()
            }
            cell.configure(imageUrl: URL(string: cellData.data))
            return cell
        }
    }
}
// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = cells[indexPath.row]
        onTapped(cell: cellData, index: indexPath.row)
    }
}

// MARK: - Модели

enum CellType: String {
    case textCell
    case imageCell
}

struct CellToShow {
    let type: CellType
    let data: String
}

// MARK: - Кастомные ячейки

class TextMessageCell: UITableViewCell {
    private let messageLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func configure(text: String) {
        messageLabel.text = text
    }
}

class ImageMessageCell: UITableViewCell {
    private let messageImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageImageView)
        
        NSLayoutConstraint.activate([
            messageImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            messageImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            messageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        messageImageView.contentMode = .scaleAspectFit
    }

    func configure(imageUrl: URL?) {
        guard let url = imageUrl else {
            messageImageView.image = UIImage(systemName: "photo")
            return
        }

        // Показываем плейсхолдер
        messageImageView.image = UIImage(systemName: "photo")

        // Асинхронная загрузка изображения
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.messageImageView.image = UIImage(systemName: "photo")
                }
                return
            }

            DispatchQueue.main.async {
                self.messageImageView.image = image
            }
        }.resume()
    }
}
