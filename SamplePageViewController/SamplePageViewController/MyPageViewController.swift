//
//  MyPageViewController.swift
//  SamplePageViewController
//
//  Created by 유정주 on 8/27/24.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    static let colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.orange, UIColor.white]
    
    private var pageViewController = UIPageViewController()
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
        let pageViewController = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: [.spineLocation: NSNumber(integerLiteral: UIPageViewController.SpineLocation.mid.rawValue)]
        )
        pageViewController.dataSource = self
        pageViewController.isDoubleSided = true
        pageViewController.setViewControllers([pages[0], pages[1]], direction: .forward, animated: true, completion: nil)
        
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.delegate = self
        pageViewController.view.addGestureRecognizer(panGestureRecognizer)
        
        self.pageViewController = pageViewController
        self.view.addSubview(pageViewController.view)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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

// MARK: - UIGestureRecognizerDelegate

extension MyPageViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        
        let x = panGestureRecognizer.translation(in: panGestureRecognizer.view).x
        
        if let leftPage = pageViewController.viewControllers?.first,
           let leftPageIndex = pages.firstIndex(of: leftPage) {
            if leftPageIndex == 0 {
                let isRightToLeftGesture = x < 0
                return !isRightToLeftGesture
            }
        }
        
        if let rightPage = pageViewController.viewControllers?.last,
           let index = pages.firstIndex(of: rightPage) {
            if index == pages.count - 1 {
                let isLeftToRightGesture = x > 0
                return !isLeftToRightGesture
            }
        }
        
        return false
    }
}
