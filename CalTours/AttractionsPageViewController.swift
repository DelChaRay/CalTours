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
    var attractionVCs: [AttractionViewController]?
    
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
        
        if let path = Bundle.main.path(forResource: "optimalList", ofType: "json") {
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
        
        attractionVCs = setupAttractions()
        setViewControllers([attractionVCs!.first!], direction: .forward, animated: true, completion: nil)
    }
    
    func setupAttractions() -> [AttractionViewController] {
        var attractions = [AttractionViewController]()

        var currentPage = 0
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var attractionVC: AttractionViewController!
        
        
        for attraction in attractionsData! {
            currentPage += 1
            attractionVC = sb.instantiateViewController(withIdentifier: "attraction") as? AttractionViewController
            var currentImage: UIImage?
            
            if let path = Bundle.main.path(forResource: attraction.title, ofType: "jpg") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    if let image = UIImage(data: data) {
                        currentImage = image
                    }
                } catch {
                    print("Could not load " + attraction.title!)
                }
            }
            
            attractionVC.img = currentImage
            attractionVC.titleText = attraction.title
            attractionVC.descriptionText = attraction.description
            attractionVC.numberText = String(currentPage)
            
            attractions.append(attractionVC)
        }
        
        return attractions
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = attractionVCs?.firstIndex(of: viewController as! AttractionViewController) else {return nil}
        
        let prevIndex = vcIndex - 1
        
        guard prevIndex >= 0 else {return nil}
        
        guard attractionVCs!.count > prevIndex else {return nil}

        return attractionVCs![prevIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = attractionVCs?.firstIndex(of: viewController as! AttractionViewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard attractionVCs!.count != nextIndex else {return nil}
        
        guard attractionVCs!.count > nextIndex else {return nil}
        
        return attractionVCs![nextIndex]
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
