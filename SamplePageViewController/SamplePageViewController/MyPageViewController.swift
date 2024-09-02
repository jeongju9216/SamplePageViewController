//
//  MyPageViewController.swift
//  SamplePageViewController
//
//  Created by 유정주 on 8/27/24.
//

import UIKit

final class MyPageViewController: UIPageViewController {
    
    static let colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.white]
    private var pages: [UIViewController] = (0..<6).map {
        let vc = UIViewController()
        vc.view.backgroundColor = colors[$0]
        return vc
    }
    
    // call count
    private let label = UILabel()
    private var countOfViewControllerAfter = 0 {
        didSet { updateLabel() }
    }
    private var countOfViewControllerBefore = 0 {
        didSet { updateLabel() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpAttributes()
        setUpCallCountLabel()
    }
    
    private func setUpAttributes() {
        dataSource = self
        isDoubleSided = true
        setViewControllers([pages[0], pages[1]], direction: .forward, animated: true, completion: nil)
    }
    
    private func setUpCallCountLabel() {
        label.text = ""
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        updateLabel()
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func updateLabel() {
        label.text = """
        countOfViewControllerAfter: \(countOfViewControllerAfter)
        countOfViewControllerBefore: \(countOfViewControllerBefore)
        """
    }
}

// MARK: - UIPageViewControllerDataSource

extension MyPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        countOfViewControllerBefore += 1
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        countOfViewControllerAfter += 1
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        guard nextIndex < pages.count else {
            return nil
        }
        
        return pages[nextIndex]
    }
}
