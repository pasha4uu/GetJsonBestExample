//
//  DetailsViewController.swift
//  JsonExampleInSwift
//
//  Created by PASHA on 02/11/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  @IBOutlet weak var dateLbl: UILabel!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var artistIdLbl: UILabel!
  @IBOutlet weak var idLbl: UILabel!
  @IBOutlet weak var imgeV: UIImageView!
  @IBOutlet weak var kindLbl: UILabel!
  @IBOutlet weak var genreTBV: UITableView!
  var indexRow: Int!
  override func viewDidLoad() {
    super.viewDidLoad()
    updateFecthData()
    genreTBV.delegate = self
    genreTBV.dataSource = self
    // Do any additional setup after loading the view.
  }
  
  
  func updateFecthData() -> Void {
    
    nameLbl.text = AppManager.shared.feeds?.feed.results[indexRow].name
    dateLbl.text = AppManager.shared.feeds?.feed.results[indexRow].releaseDate
    artistIdLbl.text = AppManager.shared.feeds?.feed.results[indexRow].artistId
    idLbl.text = AppManager.shared.feeds?.feed.results[indexRow].id
    kindLbl.text = AppManager.shared.feeds?.feed.results[indexRow].kind
    

    DispatchQueue.global(qos: .background).async {
      
      let url = URL(string: (AppManager.shared.feeds?.feed.results[self.indexRow].artworkUrl100)!)
      let dataImage = try! Data(contentsOf: url!)
      DispatchQueue.main.async {
        self.imgeV.image = UIImage(data: dataImage)
      }
    }
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (AppManager.shared.feeds?.feed.results[indexRow].genres.count)!
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "\( AppManager.shared.feeds?.feed.results[indexRow].genres[indexPath.row].name ?? "")"
    return cell
  }
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Genres"
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
