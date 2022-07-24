//
//  HomeViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//
import UIKit
import CoreData
import Kingfisher

class HomeViewController: UIViewController {
    
    var fetchResultController: NSFetchedResultsController<Country>?
    var refresh = UIRefreshControl()

    @IBOutlet var itemsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        
//        let context = CoreDataManager.shared.backgroundContext
//        let country = Country(context: context, name: "Italy", capital: "Rome", area: 301230, currency: "EUR‎", population: 59.55, imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/2560px-Flag_of_Italy.svg.png")
//        let country = Country(context: context, name: "Germany", capital: "Berlin", area: 357022, currency: "EUR‎", population: 83.24, imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/2560px-Flag_of_Germany.svg.png")
  
        CoreDataManager.shared.saveBackgroundContext()
        
        let fetchRequest = Country.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        let mainContext = CoreDataManager.shared.mainContext
        guard let fetchResult = try? mainContext.fetch(fetchRequest) else {
            return
        }
        
        let count = fetchResult.count
        
         fetchResultController = NSFetchedResultsController(fetchRequest:fetchRequest, managedObjectContext: mainContext, sectionNameKeyPath: nil, cacheName: nil)
        loadData()
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.addSubview(refresh)
        self.refresh.tintColor = UIColor.systemBlue
        // Do any additional setup after loading the view.
    }
    
   @objc func loadData() {
        do {
            try self.fetchResultController?.performFetch()
        } catch {
            fatalError()
        }
       refresh.endRefreshing()
    }

}


 
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "countryCell") as! CountryTableViewCell
        
        let country = self.fetchResultController?.object(at: indexPath) as! Country
        cell.countryLabel.text = country.name
        cell.capitalLabel.text = country.capital
        let image = ImageResource(downloadURL: URL(string: country.imageUrl!)!, cacheKey: country.imageUrl)
        cell.countryImg.kf.setImage(with: image)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchResultController?.sections else {
            return 0
        }
        return sections[section].numberOfObjects
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CountryViewController") as? CountryViewController
        let country = self.fetchResultController?.object(at: indexPath) as! Country
        vc?.country = country
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
