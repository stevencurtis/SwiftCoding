//
//  ReusableTableViewCell.swift
//  WorkingsUITableView
//
//  Created by Steven Curtis on 25/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ReusableTableViewCell: UITableViewCell {
    var task: URLSessionDownloadTask!
    var session: URLSession!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        downloadImage()
    }
    
    func downloadImage() {
        let url:URL! = URL(string: "https://lorempixel.com/400/200/")
        task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
            if let data = try? Data(contentsOf: url){
                DispatchQueue.main.async(execute: { () -> Void in
                    let img:UIImage! = UIImage(data: data)
                    self.imageView?.image = img
                })
            }
        })
        task.resume()
        
        
        self.imageView?.image = UIImage(named: "placeholder.png")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        self.imageView?.image = UIImage(named: "placeholder.png")
    }
}
