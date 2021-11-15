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
    self.makeRequestWithSSLPinning()
  }
  
  /// make a HTTP request without SSL Certificate
  private func makeRequestWithOutSSLPinning(){
    
    let url = AppConstants.url
    let session = AppConstants.unsecure_session
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      if let data = data {
        
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: [])
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
  
  
  /// make a HTTP request with SSL Certificate
  /// to see the effects turn on the MITM say charls proxy and app will cancels the request
  private func makeRequestWithSSLPinning(){
    
    let url = AppConstants.url
    let session = AppConstants.secure_session
    let task = session?.dataTask(with: url, completionHandler: { data, response, error in
      if let data = data {
        
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: [])
          print(json)
          print("---- received data in with SSL Certificate---")
        } catch {
          print(error)
        }
      } else if let error = error {
        print(error.localizedDescription as Any)
        print("---- received error in with SSL Certificate---")
      }
    })
    task?.resume()
  }
}

