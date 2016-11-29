/* 
Copyright (c) 2016 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation 
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class DetailFilm {
	public var adult : String?
	public var backdrop_path : String?
	public var belongs_to_collection : String?
	public var budget : Int?
	public var genres : Array<Genres>?
	public var homepage : String?
	public var id : Int?
	public var imdb_id : String?
	public var original_language : String?
	public var original_title : String?
	public var overview : String?
	public var popularity : Double?
	public var poster_path : String?
	public var production_companies : Array<Production_companies>?
	public var production_countries : Array<Production_countries>?
	public var release_date : String?
	public var revenue : Int?
	public var runtime : Int?
	public var spoken_languages : Array<Spoken_languages>?
	public var status : String?
	public var tagline : String?
	public var title : String?
	public var video : String?
	public var vote_average : Double?
	public var vote_count : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let DetailFilm_list = DetailFilm.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of DetailFilm Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [DetailFilm]
    {
        var models:[DetailFilm] = []
        for item in array
        {
            models.append(DetailFilm(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let DetailFilm = DetailFilm(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: DetailFilm Instance.
*/
	required public init?(dictionary: NSDictionary) {

		adult = dictionary["adult"] as? String
		backdrop_path = dictionary["backdrop_path"] as? String
		belongs_to_collection = dictionary["belongs_to_collection"] as? String
		budget = dictionary["budget"] as? Int
		if (dictionary["genres"] != nil) { genres = Genres.modelsFromDictionaryArray(array: dictionary["genres"] as! NSArray) }
		homepage = dictionary["homepage"] as? String
		id = dictionary["id"] as? Int
		imdb_id = dictionary["imdb_id"] as? String
		original_language = dictionary["original_language"] as? String
		original_title = dictionary["original_title"] as? String
		overview = dictionary["overview"] as? String
		popularity = dictionary["popularity"] as? Double
		poster_path = dictionary["poster_path"] as? String
		if (dictionary["production_companies"] != nil) { production_companies = Production_companies.modelsFromDictionaryArray(array: dictionary["production_companies"] as! NSArray) }
		if (dictionary["production_countries"] != nil) { production_countries = Production_countries.modelsFromDictionaryArray(array: dictionary["production_countries"] as! NSArray) }
		release_date = dictionary["release_date"] as? String
		revenue = dictionary["revenue"] as? Int
		runtime = dictionary["runtime"] as? Int
		if (dictionary["spoken_languages"] != nil) { spoken_languages = Spoken_languages.modelsFromDictionaryArray(array: dictionary["spoken_languages"] as! NSArray) }
		status = dictionary["status"] as? String
		tagline = dictionary["tagline"] as? String
		title = dictionary["title"] as? String
		video = dictionary["video"] as? String
		vote_average = dictionary["vote_average"] as? Double
		vote_count = dictionary["vote_count"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.adult, forKey: "adult")
		dictionary.setValue(self.backdrop_path, forKey: "backdrop_path")
		dictionary.setValue(self.belongs_to_collection, forKey: "belongs_to_collection")
		dictionary.setValue(self.budget, forKey: "budget")
		dictionary.setValue(self.homepage, forKey: "homepage")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.imdb_id, forKey: "imdb_id")
		dictionary.setValue(self.original_language, forKey: "original_language")
		dictionary.setValue(self.original_title, forKey: "original_title")
		dictionary.setValue(self.overview, forKey: "overview")
		dictionary.setValue(self.popularity, forKey: "popularity")
		dictionary.setValue(self.poster_path, forKey: "poster_path")
		dictionary.setValue(self.release_date, forKey: "release_date")
		dictionary.setValue(self.revenue, forKey: "revenue")
		dictionary.setValue(self.runtime, forKey: "runtime")
		dictionary.setValue(self.status, forKey: "status")
		dictionary.setValue(self.tagline, forKey: "tagline")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.video, forKey: "video")
		dictionary.setValue(self.vote_average, forKey: "vote_average")
		dictionary.setValue(self.vote_count, forKey: "vote_count")

		return dictionary
	}

}
