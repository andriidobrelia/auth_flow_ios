//
//  TopCountryDetailViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import UIKit

class TopCountryDetailViewController: UIViewController {
    
    var capital: Capital?

    override func viewDidLoad() {
        capitalLabel.text = capital?.name
        capitalImageView.image = capital?.image
        countryLabel.text = capital?.country
        areaLabel.text = "\(capital?.area ?? 0) km2"
        populationLabel.text = String(format: "%d",locale: Locale.current, capital?.population ?? 0)
        elevationLabel.text = "\(capital?.elevation ?? 0) m"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var capitalImageView: UIImageView!
    
    @IBOutlet var areaLabel: UILabel!
    
    @IBOutlet var elevationLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var capitalLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
