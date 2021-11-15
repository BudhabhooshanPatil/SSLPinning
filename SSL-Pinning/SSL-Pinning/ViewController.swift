//
//  ViewController.swift
//  SSL-Pinning
//
//  Created by Bhooshan Patil on 15/11/21.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  @IBAction func makeAHTTPRequestWithoutSSLCertificate(_ sender: UIButton) {
    self.makeRequestWithOutSSLPinning()
  }
  @IBAction func makeAHTTPRequestWithCertificate(_ sender: UIButton) {
    
  }
  
  private func makeRequestWithOutSSLPinning(){
    
    let url = URL(string: "https://run.mocky.io/v3/a4fe6e4c-dca1-4bc6-98e6-a2d9d6fef652")!
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      if let data = data {
        
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
          print(json)
          print("---- received data in without SSL Certificate---")
        } catch {
          print(error)
        }
      } else if let error = error {
        print(error.localizedDescription as Any)
        print("---- received error in without SSL Certificate---")
      }
    })
    task.resume()
  }
}

