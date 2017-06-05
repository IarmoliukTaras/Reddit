//
//  Entry.swift
//  RedditTaras
//
//  Created by 123 on 02.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import Foundation

class Entry {
    
    private var _title: String!
    private var _author: String!
    private var _numberOfComments: Int!
    private var _thumbnail: String!
    private var _date: Int!
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }
    
    var author: String {
        if _author == nil {
            _author = ""
        }
        return _author
    }
    
    var numberOfComments: Int {
        if _numberOfComments == nil {
            _numberOfComments = 0
        }
        return _numberOfComments
    }
    
    var thumbnail: String {
        if _thumbnail == nil {
            _thumbnail = ""
        }
        return _thumbnail
    }
    
    var date: Int {
        if _date == nil {
            _date = 0
        }
        return _date
    }
    
    init(entryInfo: Dictionary<String, AnyObject>) {
        if let author = entryInfo["author"] as? String {
            _author = author
        }
        if let thumbnail = entryInfo["thumbnail"] as? String {
            _thumbnail = thumbnail
        }
        if let title = entryInfo["title"] as? String {
            _title = title
        }
        if let numberOfComments = entryInfo["num_comments"] as? Int {
            _numberOfComments = numberOfComments
        }
        if let date = entryInfo["created_utc"] as? Int {
            let dateSince1970 = Date(timeIntervalSince1970: TimeInterval(date))
            let seconds = Int(Date().timeIntervalSince(dateSince1970))
            _date = seconds / (60 * 60)
        }
    }
    
}
