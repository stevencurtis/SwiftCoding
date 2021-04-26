//
//  ImageView+downloadImageFrom.swift
//  SeparatorLinesForUITableViewCellStyle
//
//  Created by Steven Curtis on 13/04/2021.
//

import UIKit

extension UIImageView {
    func downloadImage(with string: String, contentMode: UIView.ContentMode) {
        guard let url = NSURL(string: string) else {return}
        URLSession.shared.dataTask(with: url as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
