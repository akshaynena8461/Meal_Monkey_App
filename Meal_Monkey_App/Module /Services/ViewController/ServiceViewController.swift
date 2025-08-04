//
//  ServiceViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class ServiceViewController: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    var arrService:[String] = ["Find food you love vector","Delivery vector" , "Live tracking vector"]

    @IBOutlet weak var collectionIntro: UICollectionView!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTItle1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTItle1.text = "Find Food You Love"
        lblTitle2.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
        
        EditStyle.setborder(textfields: [btnNext])

        collectionIntro.register(UINib(nibName: "ServiceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
    }
    @IBAction func btnNextClick(_ sender: Any) {
    }
}

