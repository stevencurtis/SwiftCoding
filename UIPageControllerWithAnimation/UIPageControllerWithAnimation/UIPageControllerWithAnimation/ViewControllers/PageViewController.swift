//
//  PageViewController.swift
//  UIPageControllerWithAnimation
//
//  Created by Steven Curtis on 28/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var leftPageScroll: Int?
    var currentPageScroll: Int?
    var rightPageScroll: Int?
    
    var orderedViewControllers: [UIViewController] = {
        return []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(scrollview : UIScrollView? = nil, viewControllers: [UIViewController]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        setup(scrollview: scrollview)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(scrollview : UIScrollView? = nil, viewControllers: [UIViewController]? = nil) {
        var scrollview = scrollview
        if scrollview == nil { scrollview = view.subviews.filter { $0 is UIScrollView }.first as? UIScrollView }
        dataSource = self
        delegate = self
        scrollview!.delegate = self

        if viewControllers == nil {
            createPages()
        }
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
    }
    
    func createPages() {
        if let experiment = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            experiment.setupVC(title: "Experiment", mainText: "In this App you must say the color of a word but not the name of the word. \nFor accuracy enable the microphone on the next screen.", imageName: "phone1", bgColor: color2, fgColor: color1)
            orderedViewControllers.append(experiment)
        }
        
        if let learn = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            learn.setupVC(title: "Learn", mainText: "Use your device microphone to say the color displayed", imageName: "phone2", bgColor: color1, fgColor: color2)
            orderedViewControllers.append(learn)
            
        }
        if let fun = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            fun.setupVC(title: "Fun", mainText: "This should be a fun exercise rather than seen as a test", imageName: "phone3", bgColor: color2, fgColor: color1)
            orderedViewControllers.append(fun)
        }
        
        if let exit = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            exit.setupVC(title: "OK", mainText: "Get ready to start!", imageName: "phone4", bgColor: color1, fgColor: color2)
            orderedViewControllers.append(exit)
        }
        
    }
    
    // computed property for current index
    var currentIndex:Int {
        get {
            if let first = self.viewControllers?.first {
                return orderedViewControllers.firstIndex(of: first)!
            }
            return 0
        }
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return orderedViewControllers.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return currentIndex
    }
    
    // UIPageViewController restricts the size of the view controller so as to not extend beneath the UIPageControl
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews{
            if view is UIScrollView{
                view.frame = UIScreen.main.bounds
            }
            else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
                view.frame.origin.y = self.view.frame.size.height - 150
            }
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerCurrentIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerCurrentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerCurrentIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerCurrentIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop back to the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    // Programatically can move to the next page
    func goNextPage() {
        let cur = self.viewControllers![0]
        let p = self.pageViewController(self, viewControllerAfter: cur)
        self.setViewControllers([p!], direction: .forward, animated: true, completion: nil)
    }
    
    func setVarsForScroll(){
        leftPageScroll = mod((currentIndex - 1), orderedViewControllers.count)
        currentPageScroll = currentIndex
        rightPageScroll = mod((currentIndex + 1), orderedViewControllers.count)
    }
}

extension PageViewController: UIPageViewControllerDelegate {}

extension PageViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        setVarsForScroll()
    }
    
    func mod(_ a: Int, _ n: Int) -> Int {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        
        guard let currentPageScroll = currentPageScroll else {return}
        
        if percentageHorizontalOffset < 0.5 {
            // coming from the left
            guard let leftPageScroll = leftPageScroll else {return}
            if let prevvc = orderedViewControllers[ leftPageScroll ] as? InstructionsViewController {
                if let _ = prevvc.imageView {
                prevvc.imageView.transform = CGAffineTransform(scaleX: (1 - percentageHorizontalOffset), y: (1 - percentageHorizontalOffset))
            }
            }
        }
        
        if percentageHorizontalOffset > 0.5 {
            guard let rightPageScroll = rightPageScroll else {return}
            if let prevvc = orderedViewControllers[ currentPageScroll ] as? InstructionsViewController, let _ = prevvc.imageView {
                prevvc.imageView.transform =  CGAffineTransform(scaleX: abs(0.75-percentageHorizontalOffset)/0.25, y: abs(0.75-percentageHorizontalOffset)/0.25)
            }
            
            if let nextvc = orderedViewControllers[ rightPageScroll ] as? InstructionsViewController, let _ = nextvc.imageView {
                nextvc.imageView.transform = CGAffineTransform(scaleX: percentageHorizontalOffset, y: percentageHorizontalOffset)
            }
        }
    }
    
    
}
