//
//  ViewController.swift
//  SportApp
//
//  Created by Macos on 10/05/2025.
//

import UIKit


class UIPageViViewController: UIPageViewController
,UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    var arr=[UIViewController]()
    var uiPageController1=UIPageControl();
    override func viewDidLoad() {
        super.viewDidLoad()
            var v1 = self.storyboard?.instantiateViewController(identifier: "v1")
        var v2 = self.storyboard?.instantiateViewController(identifier: "v2")
        var v3 = self.storyboard?.instantiateViewController(identifier: "v3")
        var pageController=UIPageViewController()

        arr.append(v1!)
        arr.append(v2!)
        arr.append(v3!)
        delegate=self
        dataSource=self
        if let v1 = arr.first {
            setViewControllers( [v1], direction: .forward, animated: true, completion: nil)//make run open to first view
        }
        setupPageControl()

    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = arr.firstIndex(of:viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        return arr[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = arr.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1

        if nextIndex < arr.count {
            return arr[nextIndex]
        } else {
            DispatchQueue.main.async {
                self.navigateToHome()
            }
            return nil
        }
    }
    func navigateToHome() {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let mainVC = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "storyboard")
            
            if let window = windowScene?.windows.first {
                window.rootViewController = mainVC
                window.makeKeyAndVisible()
            }
        }
        
    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0;
//    }
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return arr.count;
//    }
    func setupPageControl() {
        uiPageController1=UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-75, width: view.frame.width, height: 30))
        uiPageController1.numberOfPages=arr.count
        uiPageController1.currentPage=0
        uiPageController1.tintColor=UIColor.white
        uiPageController1.pageIndicatorTintColor=UIColor.gray
        uiPageController1.currentPageIndicatorTintColor=UIColor.white
        view.addSubview(uiPageController1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        let contentPageController = pageViewController.viewControllers![0]
        self.uiPageController1.currentPage = arr.firstIndex(of: contentPageController)!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
