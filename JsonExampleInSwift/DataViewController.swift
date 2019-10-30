//
//  DataViewController.swift
//  JsonExampleInSwift
//
//  Created by PASHA on 01/11/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

import UIKit

class DataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

  var dataFeed:FeedDetails!
    
    var dataResults:[Results] = []
    var searchController:UISearchController!
    var isfilter :Bool = false
    
    
  @IBOutlet weak var dataTBV: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
    
    print("=======\(dataResults) ===")
   // dataFeed = AppManager.shared.feeds
       self.dataTBV.delegate = self
      self.dataTBV.dataSource = self
      print("data is : \(AppManager.shared.feeds!.feed.results[0])")
    
    searchController = UISearchController(searchResultsController: nil)
    searchController.delegate = self
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false // displays tableview
    definesPresentationContext = true

    searchController.searchBar.scopeButtonTitles = ["Friends", "Everyone"]
    searchController.searchBar.delegate = self
    if #available(iOS 11.0, *) {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    } else {
     //   dataTBV.tableHeaderView = searchController.searchBar
     //   searchController.searchBar.tintColor = UIColor.green
      //  searchController.searchBar.barTintColor = UIColor.green
    }
        // Do any additional setup after loading the view.
    }
    
    func isFiltering() -> Bool {
      return  searchController.searchBar.searchTextField.text?.isEmpty ?? true && searchController.isActive
    }
    
    
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if isfilter {
        return dataResults.count
    }
    else
    {
    return AppManager.shared.feeds!.feed.results.count
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataViewCell
   
    var url:String, name:String, date:String ;
    
    if isfilter {
        url = dataResults[indexPath.row].artworkUrl100
        name = dataResults[indexPath.row].name
        date = dataResults[indexPath.row].releaseDate
    }
    else
    {
         url = AppManager.shared.feeds!.feed.results[indexPath.row].artworkUrl100
         name = AppManager.shared.feeds!.feed.results[indexPath.row].name
         date = AppManager.shared.feeds!.feed.results[indexPath.row].releaseDate
    }
    
    
    DispatchQueue.global(qos: .background).async {
      let url = "\(url)"
      let dataImge = try! Data(contentsOf: URL(string: url)!)
    
      DispatchQueue.main.async {
        cell.imageV.image = UIImage(data: dataImge)
      }
    }
    cell.imageV.layer.cornerRadius = 30
    cell.imageV.layer.masksToBounds = true
    cell.imageV.layer.borderWidth = 3
    cell.imageV.layer.borderColor = UIColor.darkGray.cgColor
    cell.nameLbl.text = "\(name)"
    cell.discriptionLbl.text =  "Release date : \(date)"
  
  return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let DV = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
      DV.indexRow = indexPath.row
    self.navigationController?.pushViewController(DV, animated: true)
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
   return tableView.estimatedRowHeight
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
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

extension DataViewController: UISearchResultsUpdating,UISearchControllerDelegate,UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchTF = searchController.searchBar.searchTextField.text else {
             return
         }
         isfilter = true
         print("text dat is : \(searchTF)")
         dataResults = (AppManager.shared.feeds?.feed.results.filter{$0.name.lowercased().contains(searchTF.lowercased())})!
         
       //  guard let data = dataResults else { return }
         
         print("my data is--\(String(describing: dataResults))")
                 dataTBV.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isfilter = false
        searchBar.searchTextField.text = ""
        dataTBV.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("New scope index is now \(selectedScope)")
    }
    
    
    
//    func didDismissSearchController(_ searchController: UISearchController)
//    {
//        isfilter = false
//        searchController.searchBar.searchTextField.text = ""
//        dataTBV.reloadData()
//    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        guard let searchTF = searchBar.searchTextField.text else {
//                   return
//               }
//               isfilter = true
//               print("text dat is : \(searchTF)")
//               dataResults = (AppManager.shared.feeds?.feed.results.filter{$0.name.lowercased().contains(searchTF.lowercased())})!
//
//             //  guard let data = dataResults else { return }
//
//               print("my data is--\(String(describing: dataResults))")
//                       dataTBV.reloadData()
//    }
    
}
