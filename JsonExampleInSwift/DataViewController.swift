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
  
  @IBOutlet weak var dataTBV: UITableView!
  override func viewDidLoad() {
        super.viewDidLoad()
   // dataFeed = AppManager.shared.feeds
       self.dataTBV.delegate = self
      self.dataTBV.dataSource = self
      print("data is : \(AppManager.shared.feeds!.feed.results[0])")
        // Do any additional setup after loading the view.
    }
    
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return AppManager.shared.feeds!.feed.results.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataViewCell
   
    DispatchQueue.global(qos: .background).async {
      let url = "\(AppManager.shared.feeds!.feed.results[indexPath.row].artworkUrl100)"
      let dataImge = try! Data(contentsOf: URL(string: url)!)
      DispatchQueue.main.async {
        cell.imageV.image = UIImage(data: dataImge)
      }
    }
    cell.imageV.layer.cornerRadius = 30
    cell.imageV.layer.masksToBounds = true
    cell.imageV.layer.borderWidth = 3
    cell.imageV.layer.borderColor = UIColor.darkGray.cgColor
    cell.nameLbl.text = "\(AppManager.shared.feeds!.feed.results[indexPath.row].name)"
    cell.discriptionLbl.text =  "Release date : \(AppManager.shared.feeds!.feed.results[indexPath.row].releaseDate)"
  
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
    return tableView.estimatedRowHeight
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
