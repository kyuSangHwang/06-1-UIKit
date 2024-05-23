//
//  ViewController.swift
//  ContextMenu
//
//  Created by Jungman Bae on 5/22/24.
//

import UIKit

class ViewController: UIViewController, UIContextMenuInteractionDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let rectangle = UIView()
        rectangle.backgroundColor = .gray
        rectangle.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        view.addSubview(rectangle)
        
        let contextMenu = UIContextMenuInteraction(delegate: self)
        rectangle.addInteraction(contextMenu)
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let redAction = UIAction(title: "빨강", image: nil) { _ in
                interaction.view?.backgroundColor = .red
            }
            let purpleAction = UIAction(title: "보라", image: nil) { _ in
                interaction.view?.backgroundColor = .purple
            }
            let greenAction = UIAction(title: "녹색", image: nil) { _ in
                interaction.view?.backgroundColor = .green
            }
            let orangeAction = UIAction(title: "오렌지", image: nil) { _ in
                interaction.view?.backgroundColor = .orange
            }
            
            let colorMenu = UIMenu(title: "색상", options: .displayInline, children: [redAction, purpleAction])
            let otherMenu = UIMenu(title: "기타", options: .displayInline, children: [greenAction, orangeAction])
            
            return UIMenu(title: "", children: [colorMenu, otherMenu])
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configuration: UIContextMenuConfiguration, highlightPreviewForItemWithIdentifier identifier: any NSCopying) -> UITargetedPreview? {
        guard let view = interaction.view else { return nil }
        return UITargetedPreview(view: view)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: any UIContextMenuInteractionCommitAnimating) {
        if let view = interaction.view {
            let transition = CATransition()
            transition.type = .fade
            transition.duration = 0.3
            view.layer.add(transition, forKey: nil)
        }
    }

}

