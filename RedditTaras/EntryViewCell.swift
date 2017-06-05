//
//  EntryViewCell.swift
//  RedditTaras
//
//  Created by 123 on 02.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit

class EntryViewCell: UITableViewCell {
    
    
    @IBOutlet weak var entryImage: UIImageView!
    
    @IBOutlet weak var title: UITextView!
    
    @IBOutlet weak var author: UILabel!

    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var numberOfComments: UILabel!
    
    private var imageUrlStr = String()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openImageUrl(tapGestureRecognizer:)))
        entryImage.isUserInteractionEnabled = true
        entryImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func openImageUrl(tapGestureRecognizer: UITapGestureRecognizer) {
        if let url = URL(string: imageUrlStr) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func configCell(entry: Entry) {
        title.text = entry.title
        author.text = entry.author
        numberOfComments.text = String(entry.numberOfComments)
        date.text = String(entry.date)
        getImage(urlStr: entry.thumbnail, imageView: self.entryImage)
        imageUrlStr = entry.thumbnail
    }

    
    private func getImage(urlStr: String, imageView: UIImageView) {
        guard let url = URL(string: urlStr) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { (data, response, erroe) in
            if data != nil {
                let image = UIImage(data: data!)
                if image != nil {
                    DispatchQueue.main.async(execute: {
                        imageView.image = image
                    })
                }
            }
        })
        task.resume()
    }

}
