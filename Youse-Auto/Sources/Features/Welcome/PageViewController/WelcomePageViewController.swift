//
//  WelcomePageViewController.swift
//  Youse-Auto
//
//  Created by Michael Douglas on 11/08/18.
//  Copyright © 2018 Michael Douglas. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIPageViewController {
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    var viewModel: WelcomePageViewModel!
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.dataSource = self
//        self.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//*************************************************
// MARK: - UIPageViewControllerDataSource
//*************************************************

//extension WelcomePageViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        <#code#>
//    }
//}

//*************************************************
// MARK: - UIPageViewControllerDelegate
//*************************************************

//extension WelcomePageViewController: UIPageViewControllerDelegate {
//
//}
