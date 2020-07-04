//
//  Tweet.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 5/6/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import Foundation

struct Tweet {
    
     let caption: String;
     var date: Date!;
     let uid: String;
     let reweets: Int;
     let likes: Int;
     let tweetId: String;
    
    init(tweetId: String, dictionary: [String: Any]) {
        self.tweetId = tweetId;
        self.caption = dictionary["caption"] as? String ?? "";
        self.uid = dictionary["uid"] as? String ?? "";
        self.likes = dictionary["likes"] as? Int ?? 0;
        self.reweets = dictionary["retweets"] as? Int ?? 0;
        
        if let timeStamp = dictionary["timeStamp"] as? Double {
            self.date = Date(timeIntervalSince1970: timeStamp)
        }
        
    }
}
