//
//  TopViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        countryCollectionView.dataSource = self
        countryCollectionView.delegate = self
        countryCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
//    let countries = ["Afghanistan", "Albania", "Argentina", "Bolivia", "Canada", "China"]
//    
//    let countryImages: [UIImage?] = [UIImage(named: "Afghanistan"),UIImage(named: "Albania"),UIImage(named: "Argentina"),UIImage(named: "Bolivia"),UIImage(named: "Canada"),UIImage(named: "China")]
    
    
    var capitals: [Capital] = [
        Capital(name:"Kyiv", country: "Ukraine", image: UIImage(named: "Kyiv")!, area: 839.7, population: 2962180, elevation: 179),
        Capital(name:"Rome", country: "Italy", image: UIImage(named: "Rome")!, area: 1285.2, population: 4342212, elevation: 21),
        Capital(name:"Warsaw", country: "Poland", image: UIImage(named: "Warsaw")!, area: 517.24, population: 1795569, elevation: 116),
        Capital(name:"Berlin", country: "Germany", image: UIImage(named: "Berlin")!, area: 891.7, population: 3769495, elevation: 34),
        Capital(name:"Vilnius", country: "Lithuanian", image: UIImage(named: "Vilnius")!, area: 401, population: 592389, elevation: 112),
        Capital(name:"Amsterdam", country: "Netherlands", image: UIImage(named: "Amsterdam")!, area: 219.32, population: 1558755, elevation: 2),
        Capital(name:"Kyiv", country: "Ukraine", image: UIImage(named: "Kyiv")!, area: 839.7, population: 2962180, elevation: 179),
        Capital(name:"Rome", country: "Italy", image: UIImage(named: "Rome")!, area: 1285.2, population: 4342212, elevation: 21),
        Capital(name:"Warsaw", country: "Poland", image: UIImage(named: "Warsaw")!, area: 517.24, population: 1795569, elevation: 116),
        Capital(name:"Berlin", country: "Germany", image: UIImage(named: "Berlin")!, area: 891.7, population: 3769495, elevation: 34),
        Capital(name:"Vilnius", country: "Lithuanian", image: UIImage(named: "Vilnius")!, area: 401, population: 592389, elevation: 112),
        Capital(name:"Amsterdam", country: "Netherlands", image: UIImage(named: "Amsterdam")!, area: 219.32, population: 1558755, elevation: 2)
    ]
    
    @IBOutlet var countryCollectionView: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TopCountryDetailViewController, let index =
            countryCollectionView.indexPathsForSelectedItems?.first {
            dest.capital = capitals[index.row]
        }
    }
    
}

extension TopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return capitals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as! CountryCollectionViewCell
        cell.countryLabel.text = capitals[indexPath.item].name
        cell.countryImageView.image = capitals[indexPath.item].image
            return cell
    }
}

extension TopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 20)/2
        return CGSize(width: width, height: width)
    }
}
