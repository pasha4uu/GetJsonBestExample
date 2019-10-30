//
//  Feed.swift
//  JsonExampleInSwift
//
//  Created by PASHA on 01/11/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

import Foundation

struct FeedDetails:Codable {
    let feed:Feeds
}
struct Feeds:Codable {
  let author:Author
  let copyright:String
  let country:String
  let icon:String
  let id :String
  //let links : [String:Any]
  let results:[Results]
}
struct Author:Codable {
  let name:String
  let uri:String
}

struct Results:Codable {
  let name:String
  let releaseDate:String
  let artworkUrl100:String
  let artistId:String
  let kind:String
  let id:String
  let genres:[Genres]
}
struct Genres: Codable {
  let name:String
  let genreId:String
  let url:String
  
}
