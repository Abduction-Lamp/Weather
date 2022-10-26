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
    
    func getAirPollution(lat: Double, lon: Double,
                         completed: @escaping (Result<AirPollutionResponse, NetworkResponseError>) -> Void)
}


final class Network: NetworkServiceProtocol {
    
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    
    // MARK: - Coordinates By Location Name
    /// Возвращает координаты запрошенного города
    ///
    func getCoordinatesByLocationName(city: String,
                                      completed: @escaping (Result<[GeocodingResponse], NetworkResponseError>) -> Void) {
        if let url = makeUrl(request: GeocodingRequest(сity: city)) {
            fetchData(from: url) { response in completed(response) }
        } else {
            completed(.failure(.url(message: "Failed to retrieve url.")))
        }
    }
    
    // MARK: - Weather One Call
    /// Получает подробнейший прогноз погоды для заданных координат:
    /// (текущая погода, поминутный прогноз (на 1 час), почасовой прогноз (на 48 часов), нрогноз на денелю (7 дней), национальные погодные предупреждения)
    ///
    /// - Parameter lat:   Географическая координата широты
    /// - Parameter lon:   Географическая координата долготы
    /// - Parameter units: Единицы измерения может принимать одно из значений: ["standard", "metric", "imperial"]
    /// - Parameter lang:  Язык выходных данных ["ru", "en", и др.]
    ///
    /// - Для температуры в градусах Фаренгейта и скорости ветра в милях/час используйте единицы измерения units = "imperial"
    /// - Для температуры в градусах Цельсия и скорости ветра в метрах/сек используйте единицы измерения units = "metric"
    /// - Температура в Кельвинах и скорость ветра в метрах / сек используются по умолчанию units = "standard"
    ///
    func getWeatherOneCall(lat: Double, lon: Double,
                           units: String = "metric",
                           lang: String = NSLocalizedString("General.Lang", comment: "Lang"),
                           completed: @escaping (Result<OneCallResponse, NetworkResponseError>) -> Void) {
        if let url = makeUrl(request: OneCallRequest(lat: lat, lon: lon, units: units, lang: lang)) {
            fetchData(from: url) { response in completed(response) }
        } else {
            completed(.failure(.url(message: "Failed to retrieve url.")))
        }
    }
    
    // MARK: - Air Pollution
    /// Получает данных о качестве воздуха:
    /// Компоненты по которым оценивается качество воздуха, [мкг/м3]:
    /// - CO (Оксид углерода);
    /// - NO (Оксид азота);
    /// - NO2 (Диоксида азота);
    /// - О3 (Озон);
    /// - SO2 (Диоксид серы);
    /// - PM2.5 (Мелкие частицы);
    /// - PM10 (Крупные частицы);
    /// - Концентрация NH3 (Аммиак).
    ///
    /// - Parameter lat: Географическая координата широты
    /// - Parameter lon: Географическая координата долготы
    ///
    func getAirPollution(lat: Double, lon: Double, completed: @escaping (Result<AirPollutionResponse, NetworkResponseError>) -> Void) {
        if let url = makeUrl(request: AirPollutionRequest(lat: lat, lon: lon)) {
            fetchData(from: url) { response in completed(response) }
        } else {
            completed(.failure(.url(message: "Failed to retrieve url.")))
        }
    }
}


// MARK: - Private support methods
//
extension Network {
    
    private func fetchData<ResponseType>(from url: URL,
                                         completed: @escaping (Result<ResponseType, NetworkResponseError>) -> Void) where ResponseType: Decodable {
        
        session.dataTaskEx(with: url) { (data, response, error) in
            if let error = error {
                if let networkResponseError = error as? NetworkResponseError {
                    completed(.failure(networkResponseError))
                } else {
                    completed(.failure(.error(url: url.absoluteString, message: error.localizedDescription)))
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    guard (200...299).contains(httpResponse.statusCode) else {
                        completed(.failure(.status(url: url.absoluteString, code: httpResponse.statusCode)))
                        return
                    }
                    guard let data = data else {
                        completed(.failure(.data(url: url.absoluteString, message: "Data field is missing in the response.")))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(ResponseType.self, from: data)
                        completed(.success(result))
                    } catch {
                        completed(.failure(.decode(url: url.absoluteString, message: "Data could not be decoded.")))
                    }
                } else {
                    completed(.failure(.status(url: url.absoluteString, code: nil)))
                }
            }
        }.resume()
    }
}


extension Network {
    
    private func makeUrl(request: BaseRequest) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path  = request.path
        urlComponents.queryItems = request.params
        return urlComponents.url
    }
}
