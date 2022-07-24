//
//  CountryViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//
import Kingfisher
import UIKit

class CountryViewController: UIViewController {
    
     
    var country: Country = Country()

    override func viewDidLoad() {
        super.viewDidLoad()
        capitalNameLabel.text = country.capital
        countryNameLabel.text = country.name
        areaLabel.text = String(format: "%d", locale: Locale.current, country.area)
        currencyLabel.text = country.currency
        populationLabel.text = "\(country.population) millions"
        countryImgView.kf.setImage(with: ImageResource(downloadURL: URL(string: country.imageUrl!)!, cacheKey: country.imageUrl)
)
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet var countryImgView: UIImageView!
    
    @IBOutlet var capitalNameLabel: UILabel!
    
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var countryNameLabel: UILabel!
}
