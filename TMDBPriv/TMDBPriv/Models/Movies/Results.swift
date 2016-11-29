/*
Copyright (c) 2016 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
import UIKit
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Results {
	public var poster_path : String?
	public var adult : String?
	public var overview : String?
	public var release_date : String?
	public var genre_ids : Array<Int>?
	public var id : Int?
	public var original_title : String?
	public var original_language : String?
	public var title : String?
	public var backdrop_path : String?
	public var popularity : Double?
	public var vote_count : Int?
	public var video : String?
	public var vote_average : Double?
    public var image: UIImage?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let results_list = Results.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Results Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Results]
    {
        var models:[Results] = []
        for item in array
        {
            models.append(Results(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let results = Results(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Results Instance.
*/
	required public init?(dictionary: NSDictionary) {

		poster_path = dictionary["poster_path"] as? String
		adult = dictionary["adult"] as? String
		overview = dictionary["overview"] as? String
		release_date = dictionary["release_date"] as? String
		/*if (dictionary["genre_ids"] != nil) { genre_ids = Genre_ids.modelsFromDictionaryArray(dictionary["genre_ids"] as! NSArray) }*/
		id = dictionary["id"] as? Int
		original_title = dictionary["original_title"] as? String
		original_language = dictionary["original_language"] as? String
		title = dictionary["title"] as? String
		backdrop_path = dictionary["backdrop_path"] as? String
		popularity = dictionary["popularity"] as? Double
		vote_count = dictionary["vote_count"] as? Int
		video = dictionary["video"] as? String
		vote_average = dictionary["vote_average"] as? Double
        image = nil
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.poster_path, forKey: "poster_path")
		dictionary.setValue(self.adult, forKey: "adult")
		dictionary.setValue(self.overview, forKey: "overview")
		dictionary.setValue(self.release_date, forKey: "release_date")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.original_title, forKey: "original_title")
		dictionary.setValue(self.original_language, forKey: "original_language")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.backdrop_path, forKey: "backdrop_path")
		dictionary.setValue(self.popularity, forKey: "popularity")
		dictionary.setValue(self.vote_count, forKey: "vote_count")
		dictionary.setValue(self.video, forKey: "video")
		dictionary.setValue(self.vote_average, forKey: "vote_average")

		return dictionary
	}

}
