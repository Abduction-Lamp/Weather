//
//  NetworkService.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {

    func getCoordinatesByLocationName(city: String,
                                      completed: @escaping (Result<[GeocodingResponse], NetworkResponseError>) -> Void)
    
    func getWeatherOneCall(lat: Double, lon: Double, units: String, lang: String,
                           completed: @escaping (Result<OneCallResponse, NetworkResponseError>) -> Void)
}


final class Network: NetworkServiceProtocol {
    
    // MARK: - Coordinates By Location Name
    ///
    /// Возвращает координаты запрошенного города
    ///
    func getCoordinatesByLocationName(city: String,
                                      completed: @escaping (Result<[GeocodingResponse], NetworkResponseError>) -> Void) {
        if let url = makeUrl(request: GeocodingRequest(сity: city)) {
            fetchData(from: url) { response in completed(response) }
        } else {
            completed(.failure(.url(message: "failed to retrieve url")))
        }
    }
    
    // MARK: - Weather One Call
    /// Получает подробнейший прогноз погоды для заданных координат:
    /// (текущая погода, поминутный прогноз (на 1 час), почасовой прогноз (на 48 часов), нрогноз на денелю (7 дней), национальные погодные предупреждения)
    ///
    /// - Parameter lat: Географическая координата широты
    /// - Parameter lon: Географическая координата долготы
    /// - Parameter units: Единицы измерения может принимать одно из значений: ["standard", "metric", "imperial"]
    /// - Parameter lang: Язык выходных данных ["ru", "en", и др.]
    ///
    /// - Для температуры в градусах Фаренгейта и скорости ветра в милях/час используйте единицы измерения units = "imperial"
    /// - Для температуры в градусах Цельсия и скорости ветра в метрах/сек используйте единицы измерения units = "metric"
    /// - Температура в Кельвинах и скорость ветра в метрах / сек используются по умолчанию units = "standard"
    ///
    func getWeatherOneCall(lat: Double, lon: Double, units: String, lang: String,
                           completed: @escaping (Result<OneCallResponse, NetworkResponseError>) -> Void) {
        if let url = makeUrl(request: OneCallRequest(lat: lat, lon: lon, units: units, lang: lang)) {
            fetchData(from: url) { response in completed(response) }
        } else {
            completed(.failure(.url(message: "failed to retrieve url")))
        }
    }
}


// MARK: - Private support methods
//
extension Network {
    
    private func makeUrl(request: BaseRequest) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path  = request.path
        urlComponents.queryItems = request.params
        return urlComponents.url
    }
    
    private func fetchData<ResponseType>(from url: URL,
                                         completed: @escaping (Result<ResponseType, NetworkResponseError>) -> Void) where ResponseType: Decodable {
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        let session = URLSession(configuration: config)

        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completed(.failure(.error(message: error.localizedDescription)))
            } else {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.status(code: 0)))
                    return
                }
                guard let data = data else {
                    completed(.failure(.data(message: "date field is missing in the response")))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: data)
                    completed(.success(result))
                } catch {
                    completed(.failure(.error(message: error.localizedDescription)))
                    print("⚠️\tNetwork > try Decoder: \(error.localizedDescription)\n\turl: \(url.absoluteString)")
                }
            }
        }.resume()
    }
}
