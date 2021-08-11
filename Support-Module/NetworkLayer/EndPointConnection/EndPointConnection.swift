

import Foundation

struct Environment {
    static let BaseURL = "http://api.openweathermap.org/"
    static let APIKey  = "fae7190d7e6433ec3a45285ffcf55c86"
}

struct WebServiceName {
    static let kTodayForecastAPI  = Environment.BaseURL + "data/2.5/weather?&q="
    static let kFiveDaysForecastAPI   = Environment.BaseURL + "data/2.5/forecast?&q="
}

