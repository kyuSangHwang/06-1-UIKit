//
//  ViewController.swift
//  List
//
//  Created by Jungman Bae on 5/22/24.
//

import UIKit

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) ?? UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = animals[indexPath.row].name
        config.image = animals[indexPath.row].image
        cell.contentConfiguration = config
        return cell
    }
}

