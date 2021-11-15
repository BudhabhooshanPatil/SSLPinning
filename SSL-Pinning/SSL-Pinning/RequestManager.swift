//
//  RequestManager.swift
//  SSL-Pinning
//
//  Created by Bhooshan Patil on 15/11/21.
//

import Foundation

class RequestManager: NSObject {
  
  // ref to local certificate, downloaded from crome, by manually visiting the website, for this demo
  // you can ask to your devOps or server guy to provide you the original one for your server
  private lazy var certificates: [Data] = {
    let url = Bundle.main.url(forResource: "run.mocky.io", withExtension: "cer")!
    let data = try! Data(contentsOf: url)
    return [data]
  }()
  
  public var session: URLSession!
  
  override init() {
    super.init()
    session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
  }
}

extension RequestManager: URLSessionDelegate {
  
  // IMP
  // this will compare the certificate bits by bits
  // if received the correct certificate then request is processed
  // otherwise cancelled
  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    if let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 {
      if let certificate = SecTrustGetCertificateAtIndex(trust, 0) {
        let data = SecCertificateCopyData(certificate) as Data
        if certificates.contains(data) {
          completionHandler(.useCredential, URLCredential(trust: trust))
          return
        }
      }
    }
    completionHandler(.cancelAuthenticationChallenge, nil)
  }
}

