//
//  AttractionsViewController.swift
//  CalTours
//
//  Created by Raymond Chau on 3/17/19.
//  Copyright © 2019 Egg Altar. All rights reserved.
//

import UIKit

class AttractionsPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var totalPages = 0
    var currentPage = 0
    var attractionsData: [Attraction]?
    var attractionVC: AttractionViewController?
    
    struct Attractions : Codable {
        let attractions: [Attraction]
        
        enum CodingKeys: String, CodingKey {
            case attractions = "attractions"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let attractions = try? JSONDecoder().decode(Attractions.self, from: data) {
                    totalPages = attractions.attractions.count
                    attractionsData = attractions.attractions
                }
            } catch {
                // handle error
                print("Could not find default JSON data")
            }
        }
        
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        attractionVC = (sb.instantiateViewController(withIdentifier: "attraction") as! AttractionViewController)
        attractionVC!.data = attractionsData![0]
        attractionVC!.currentPage = currentPage + 1
        
        setViewControllers([attractionVC!], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let previousPage = currentPage - 1
        
        guard previousPage >= 0 else {return nil}
        
        currentPage = previousPage
        
        let sb = self.storyboard
        let attractionVC = sb!.instantiateViewController(withIdentifier: "attraction") as! AttractionViewController
        
        let src = attractionsData![currentPage]
        
        attractionVC.data = src
        attractionVC.currentPage = currentPage + 1
        
        return attractionVC
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let nextPage = currentPage + 1
        
        guard nextPage < totalPages else {return nil}
        
        currentPage = nextPage
        
        let sb = self.storyboard
        let attractionVC = sb!.instantiateViewController(withIdentifier: "attraction") as! AttractionViewController
        
        let src = attractionsData![currentPage]
        
        attractionVC.data = src
        attractionVC.currentPage = currentPage + 1
        
        return attractionVC
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
