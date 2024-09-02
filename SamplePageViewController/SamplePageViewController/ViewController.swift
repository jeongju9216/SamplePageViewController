//
//  ViewController.swift
//  SamplePageViewController
//
//  Created by 유정주 on 8/27/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let button = UIButton()
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButton()
        setUpLabel()
    }
    
    private func setUpButton() {
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Move to Sample PageViewController", for: .normal)
        button.backgroundColor = .blue
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 500),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(showPageViewController(_:)), for: .touchUpInside)
    }
    
    private func setUpLabel() {
        label.numberOfLines = 0
        label.textColor = .black
        label.text = """
        We developed this sample project using Xcode 15.4 (15F31d).
        1. Click the blue button in the middle.
        2. Move to the last page.
        3. Drag from the top-right corner to the bottom-left corner.
        4. There is a high chance that the app will crash.
        """
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    private func showPageViewController(_ sender: UIButton) {
        let pageViewController = MyPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: [.spineLocation: NSNumber(integerLiteral: UIPageViewController.SpineLocation.mid.rawValue)])
        pageViewController.modalPresentationStyle = .fullScreen
        present(pageViewController, animated: true)
    }
}

