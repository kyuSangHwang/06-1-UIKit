//
//  ViewController.swift
//  List
//
//  Created by Jungman Bae on 5/22/24.
//

import UIKit
class CustomCell: UITableViewCell {
    let animalImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        //안에 들어가는 이미지 크기를 프레임 비율에 맞춰 넣도록 설정
        animalImageView.contentMode = .scaleAspectFit
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(animalImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            animalImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 50),
            animalImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(item: Animal) {
        animalImageView.image = item.image
        nameLabel.text = item.name
    }
}

struct Animal {
    let name: String
    let image: UIImage
}

class ViewController: UIViewController, UITableViewDataSource {
    
    let animals = [
        Animal(name: "고양이", image: UIImage(systemName: "cat")!),
        Animal(name: "강아지", image: UIImage(systemName: "dog")!),
        Animal(name: "토끼", image: UIImage(systemName: "hare")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self // 테이블뷰 내가 처리할께
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        //        var config = cell.defaultContentConfiguration()
        //        config.text = animals[indexPath.row].name
        //        config.image = animals[indexPath.row].image
        //        cell.contentConfiguration = config
        let animal: Animal = animals[indexPath.row]
        cell.configure(item: animal)
        return cell
    }
}

