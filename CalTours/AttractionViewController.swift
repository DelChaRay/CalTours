//
//  AttractionViewController.swift
//  CalTours
//
//  Created by Raymond Chau on 3/17/19.
//  Copyright © 2019 Egg Altar. All rights reserved.
//

import UIKit

class AttractionViewController: UIViewController {
    
    @IBOutlet weak var imgsrc: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    //var data: Attraction?
    //var currentPage = 0
    var img: UIImage?
    var titleText: String?
    var descriptionText: String?
    var numberText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        //updateData()
    }
    
    func loadData() {
        imgsrc.image = img
        titleLabel.text = titleText
        descriptionLabel.text = descriptionText
        numberLabel.text = numberText
    }
    
//    func updateData() {
//        //imgsrc.setImage(from: URL(string: (data?.imgsrc)!)!)
//        if let path = Bundle.main.path(forResource: data!.title, ofType: "jpg") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                if let image = UIImage(data: data) {
//                    imgsrc.image = image
//                }
//            } catch {
//                print("Could not load " + data!.title!)
//            }
//        }
//        titleLabel.text = data?.title
//        descriptionLabel.text = data?.description
//        numberLabel.text = String(currentPage)
//    }

}
