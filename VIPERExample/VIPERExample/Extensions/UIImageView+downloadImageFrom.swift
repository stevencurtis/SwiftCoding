//
//  UIImageView+downloadImageFrom.swift
//  VIPERExample
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import NetworkLibrary
import UIKit

extension UIImageView {
    func downloadImageFrom(with url: URL, contentMode: UIView.ContentMode) {
        downloadImageFrom(with: url, network: NetworkManager(session: URLSession.shared), contentMode: contentMode)
    }
    
    func downloadImageFrom<T: NetworkManagerProtocol>(with url: URL, network: T, contentMode: UIView.ContentMode) {
        network.fetch(url: url, method: .get, completionBlock: { result in
            switch result {
            case .failure:
                print ("failed")
            // commnunicate failure to the user, or silently fail
            // as it will currently (leaves placeholder)
            case .success(let data):
                DispatchQueue.main.async {
                    self.contentMode = contentMode
                    self.image = UIImage(data: data)
                }
            }
        })

    }
}
