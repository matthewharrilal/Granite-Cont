//
//  OnboardingPageViewController.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 8/5/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var modalViewTapClosure: ((CGRect, String?) -> Void)?
    
    var secondOnboardingController = SecondOnboardingController()
    
    var thirdOnboardingController = ThirdOnboardingController()
    
    
    var logoImageClosure: ((UIImage, UIColor, String) -> Void)?
    
    var completedOnboardingFlowClosure: (() -> Void)?
    
    lazy var orderedViewControllers: [UIViewController] = [FirstOnboardingController(), self.secondOnboardingController, self.thirdOnboardingController]
    var pageControl: UIPageControl = UIPageControl()
    
    var selectedLanguagesClosure: ((Set<String>) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.delegate = self
        self.dataSource = self 
        
        
        if let firstViewController = self.orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.view.removePageViewGesture()
        
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
//

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.orderedViewControllers.firstIndex(of: viewController) else {return nil}
        
        
        let previousIndex = viewControllerIndex - 1
        //        guard previousIndex >= 0 else {
        //            return orderedViewControllers.last // Loop the ordered view controllers
        //        }
        
        guard self.orderedViewControllers.count > previousIndex else {return nil}
        
        
        return self.orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.orderedViewControllers.firstIndex(of: viewController) else {return nil}
        
        
        let nextIndex = viewControllerIndex + 1
        
        //        guard orderedViewControllers.count != nextIndex else {
        //            return orderedViewControllers.first // Loop the ordered view controllers
        //        }
        
        guard self.orderedViewControllers.count > nextIndex else {return nil}
        
        
        return self.orderedViewControllers[nextIndex]
        
    }
    
    func configurePageControl() {
        self.pageControl.frame = .init(x: 0, y: self.view.bounds.maxY - 50, width: self.view.bounds.width, height: 50)
        self.pageControl.numberOfPages = self.orderedViewControllers.count
        
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor(hexString: "ccddfc")
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(hexString: "ccddfc")
        
        self.pageControl.transform = .init(scaleX: 2, y: 1)
        
        self.view.addSubview(self.pageControl)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let pageViewController = pageViewController.viewControllers?[0] {
            self.pageControl.currentPage = self.orderedViewControllers.firstIndex(of: pageViewController)!
        }
        
        
    }
    //
    func nextPage() {
        guard let currentViewController = self.viewControllers?.first,
            let nextViewController = self.dataSource?.pageViewController(self, viewControllerAfter: currentViewController)
            else {
                
                // Use closure to relay back to onboarding view controller
                self.completedOnboardingFlowClosure?()
                return
        }
        
        // At point in time where user is transitioning to the next page if the current view controller is language select use closure to transmit those values to the onboarding view controller and it would happen right ther
        
        
        print("Identifier for view controller \(nextViewController.restorationIdentifier)")
        self.thirdOnboardingController.modalViewTapClosure = self.modalViewTapClosure
        self.thirdOnboardingController.logoImageClosure = self.logoImageClosure
        
        self.secondOnboardingController.selectedLanguagesClosure = self.selectedLanguagesClosure
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
    
    
}
