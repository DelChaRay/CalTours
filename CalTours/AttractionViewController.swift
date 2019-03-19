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
    
    var data: Attraction?
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
    }
    
    func updateData() {
        //imgsrc.setImage(from: URL(string: (data?.imgsrc)!)!)
        if let path = Bundle.main.path(forResource: data!.title, ofType: "jpg") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let image = UIImage(data: data) {
                    imgsrc.image = image
                }
            } catch {
                print("Could not load " + data!.title!)
            }
        }
        titleLabel.text = data?.title
        descriptionLabel.text = data?.description
        numberLabel.text = String(currentPage)
    }

}

extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            }.resume()
    }
}
