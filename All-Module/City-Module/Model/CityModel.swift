//
//  CityModel.swift
//  MobiquityDemo
//
//  Created by Shailendra Kumar Gupta on 10/08/21.
//  Copyright © 2020 Shailendra Kumar Gupta. All rights reserved.
//

import Foundation

struct FiveDaysForecaseCodable : Codable {
    let cod : String?
    let message : Int?
    let cnt : Int?
    let list : [List]?
    let city : City?
    
    enum CodingKeys: String, CodingKey {
        
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        message = try values.decodeIfPresent(Int.self, forKey: .message)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try values.decodeIfPresent([List].self, forKey: .list)
        city = try values.decodeIfPresent(City.self, forKey: .city)
    }
    
}
struct List : Codable {
    let dt : Int?
    let main : Main?
    let weather : [Weather]?
    let clouds : Clouds?
    let wind : Wind?
    let visibility : Int?
    let pop : Int?
    let sys : Sys?
    let dt_txt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case sys = "sys"
        case dt_txt = "dt_txt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        pop = try values.decodeIfPresent(Int.self, forKey: .pop)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        dt_txt = try values.decodeIfPresent(String.self, forKey: .dt_txt)
    }
    
}

struct City : Codable {
    let id : Int?
    let name : String?
    let coord : Coord?
    let country : String?
    let population : Int?
    let timezone : Int?
    let sunrise : Int?
    let sunset : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
    }
    
}
struct Clouds : Codable {
    let all : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case all = "all"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decodeIfPresent(Int.self, forKey: .all)
    }
    
}
struct Coord : Codable {
    let lat : Double?
    let lon : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lon = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
    }
    
}
struct Main : Codable {
    let temp : Double?
    let feels_like : Double?
    let temp_min : Double?
    let temp_max : Double?
    let pressure : Int?
    let sea_level : Int?
    let grnd_level : Int?
    let humidity : Int?
    let temp_kf : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case feels_like = "feels_like"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
        temp_min = try values.decodeIfPresent(Double.self, forKey: .temp_min)
        temp_max = try values.decodeIfPresent(Double.self, forKey: .temp_max)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        sea_level = try values.decodeIfPresent(Int.self, forKey: .sea_level)
        grnd_level = try values.decodeIfPresent(Int.self, forKey: .grnd_level)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        temp_kf = try values.decodeIfPresent(Double.self, forKey: .temp_kf)
    }
    
}
struct Sys : Codable {
    let pod : String?
    
    enum CodingKeys: String, CodingKey {
        
        case pod = "pod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pod = try values.decodeIfPresent(String.self, forKey: .pod)
    }
    
}
struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
    
}
struct Wind : Codable {
    let speed : Double?
    let deg : Int?
    let gust : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Int.self, forKey: .deg)
        gust = try values.decodeIfPresent(Double.self, forKey: .gust)
    }
    
}
struct TodayForecaseCodable: Codable {
    let coord : Coord?
    let weather : [Weather]?
    let base : String?
    let main : Main?
    let visibility : Int?
    let wind : Wind?
    let clouds : Clouds?
    let dt : Int?
    let sys : Sys?
    let timezone : Int?
    let id : Int?
    let name : String?
    let cod : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
    }
    
}

