//
//  BasePagedController.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 10.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
class BasePagedController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        let initialPage = 0
        let pageOne = UIViewController()
        let pageTwo = UIViewController()

        // add the individual viewControllers to the pageViewController
        pages.append(pageOne)
        pages.append(pageTwo)

        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isEnabled = false

        view.addSubview(pageControl)
        _ = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 5, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 20)
    }

    @objc func removeSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }

    @objc func openSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }

    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String: Any]?) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let VCIndex = pages.index(of: viewController) {
            if VCIndex != 0 { return pages[0] }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let VCIndex = pages.index(of: viewController) {
            if VCIndex < pages.count - 1 {
                let selectedVC = pages[VCIndex+1]
                return selectedVC
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if let viewControllers = pageViewController.viewControllers {
            if let VCIndex = pages.index(of: viewControllers[0]) {
                pageControl.currentPage = VCIndex
            }
        }
    }
}
