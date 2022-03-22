//
//  Weather.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 22.03.22.
//

import Foundation

struct Weather: Codable {
    let latitude: Float?
    let longitude: Float?
    let timezone: String?
    let currently: CurrentWeather?
    let daily: DailyWeather?
}

struct CurrentWeather: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let temperature: Double
    let apparentTemperature: Double?
    let dewPoint: Double?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let cloudCover: Double?
    let visibility: Double?
}

struct DailyWeather: Codable {
    let summary: String?
    let icon: String?
    let data: [DailyWeatherEntry]?
}

struct DailyWeatherEntry: Codable {
    let time: Int?
    let summary: String?
    let icon: String?
    let sunriseTime: Int?
    let sunsetTime: Int?
    let moonPhase: Double?
    let precipType: String?
    let temperatureHigh: Double?
    let temperatureHighTime: Int?
    let temperatureLow: Double?
    let temperatureLowTime: Int?
    let humidity: Double?
    let pressure: Double?
    let windSpeed: Double?
    let visibility: Double?
}
