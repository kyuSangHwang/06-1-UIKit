//
//  ViewController.swift
//  SegmentedControl
//
//  Created by Jungman Bae on 5/21/24.
//

import UIKit

extension UIColor {
    // 배경색에 어울리는 틴트 컬러를 계산하는 함수
    func appropriateTintColor() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // 밝기 계산 (RGB to Luminance)
        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        
        // 밝기가 0.5 이상이면 어두운 색 텍스트, 아니면 밝은 색 텍스트
        return luminance > 0.5 ? UIColor.black : UIColor.white
    }
}

class ViewController: UIViewController {
    let segmentedControl = UISegmentedControl(items: ["Red", "Green", "Blue"])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addAction(UIAction { [weak self] _ in
            switch self?.segmentedControl.selectedSegmentIndex {
            case 0:
                self?.view.backgroundColor = .red
            case 1:
                self?.view.backgroundColor = .green
            case 2:
                self?.view.backgroundColor = .blue
            default:
                break
            }
            let tintColor: UIColor = (self?.view.backgroundColor?.appropriateTintColor())!
            let nornalTextAttribute: [NSAttributedString.Key: Any] = [.foregroundColor: tintColor]
            self?.segmentedControl.setTitleTextAttributes(nornalTextAttribute, for: .normal)
        }, for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = .lightGray
        
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }


}

