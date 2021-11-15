//
//  AppConstants.swift
//  SSL-Pinning
//
//  Created by Bhooshan Patil on 15/11/21.
//

import Foundation

struct AppConstants {
  // this will create an instace if URLSession with SSL certi
  static let secure_session = RequestManager().session
  
  // this will create an URLSession instance without any SSL Certificate
  static let unsecure_session = URLSession.shared
  
  // demo URL from json provider mocky.io
  static let url = URL(string: "https://run.mocky.io/v3/a4fe6e4c-dca1-4bc6-98e6-a2d9d6fef652")!
}
