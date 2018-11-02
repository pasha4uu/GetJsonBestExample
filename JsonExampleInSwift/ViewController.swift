//
//  ViewController.swift
//  JsonExampleInSwift
//
//  Created by PASHA on 01/11/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var planTypeSegment: UISegmentedControl!
  @IBOutlet weak var countrySegment: UISegmentedControl!
  var url = String()
  override func viewDidLoad() {
    super.viewDidLoad()
    countrySegment.selectedSegmentIndex = 1
    planTypeSegment.selectedSegmentIndex = 0
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func getDataTap(_ sender: Any) {
    
    if self.countrySegment.selectedSegmentIndex == 0 {
      switch self.planTypeSegment.selectedSegmentIndex {
      case 0:
        self.url = "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/100/explicit.json"
      case 1:
        self.url = "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-paid/all/100/explicit.json"
      case 2:
        self.url = "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-grossing/all/100/explicit.json"
      default:
        self.url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/100/explicit.json"
      }
     
    }
   else if self.countrySegment.selectedSegmentIndex == 1 {
      switch self.planTypeSegment.selectedSegmentIndex {
      case 0:
        self.url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/100/explicit.json"
      case 1:
        self.url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-paid/all/100/explicit.json"
      case 2:
        self.url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/100/explicit.json"
      default:
        self.url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/100/explicit.json"
      }
      
    }
   else if self.countrySegment.selectedSegmentIndex == 2 {
      switch self.planTypeSegment.selectedSegmentIndex {
      case 0:
        self.url = "https://rss.itunes.apple.com/api/v1/gb/ios-apps/top-free/all/100/explicit.json"
      case 1:
        self.url = "https://rss.itunes.apple.com/api/v1/gb/ios-apps/top-paid/all/100/explicit.json"
      case 2:
        self.url = "https://rss.itunes.apple.com/api/v1/gb/ios-apps/top-grossing/all/100/explicit.json"
      default:
        self.url = "https://rss.itunes.apple.com/api/v1/gb/ios-apps/top-free/all/100/explicit.json"
      }
      
    }
    
    
    let url = URL(string: self.url)!
    let request = URLRequest(url: url)
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
      
      guard let data = data else { return}
      
      do {
        let sd = try JSONDecoder().decode(FeedDetails.self, from: data)
          print("data is : \(sd.feed.results[0].name)");
        AppManager.shared.feeds = sd
        DispatchQueue.main.async {
          let  dataViewController = self.storyboard?.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
         // dataViewController.dataFeed = sd
          self.navigationController?.pushViewController(dataViewController, animated: true)
        }
       
      } catch {
        print("\(error.localizedDescription)")
      }
    
    
      
    }.resume()
    
    
    
    
  }
  
}

