//
//  TweetService.swift
//  TwitterHopefully
//
//  Created by Michael Perrone on 5/6/20.
//  Copyright © 2020 Michael Perrone. All rights reserved.
//

import Firebase

struct TweetService {
    static let shared = TweetService();
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let userId = USER_ID else {return}
        let values = ["uid": userId, "caption": caption, "timeStamp": Int(NSDate().timeIntervalSince1970), "likes": 0, "retweets": 0] as [String : Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) {snapshot  in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            let tweet = Tweet(tweetId: snapshot.key, dictionary: dictionary)
            tweets.append(tweet);
            completion(tweets)
        }
    }
}
