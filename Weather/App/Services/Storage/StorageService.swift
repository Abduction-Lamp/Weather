//
//  StorageService.swift
//  Weather
//
//  Created by Владимир on 13.04.2022.
//

import Foundation

protocol StorageServiceProtocol: AnyObject {
    
    func featch(_ completion: @escaping (Result<Settings, CompletionError>) -> Void)
    func save(_ settings: Settings)
    func reset() -> Settings
}


final class Storage: StorageServiceProtocol {
    
    func featch(_ completion: @escaping (Result<Settings, CompletionError>) -> Void) {
        DispatchQueue.global().async {
            if let data = UserDefaults.standard.object(forKey: AppKeys.shared.settings) as? Data {
                do {
                    let settings = try JSONDecoder().decode(Settings.self, from: data)
                    completion(.success(settings))
                } catch {
                    completion(.failure(.decode(message: "Decoding error when extracting settings")))
                }
            } else {
                completion(.failure(.empty(message: "No data available")))
            }
        }
    }
    
    func save(_ settings: Settings) {
        DispatchQueue.global().async {
            do {
                let data = try JSONEncoder().encode(settings)
                UserDefaults.standard.set(data, forKey: AppKeys.shared.settings)
            } catch {
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func reset() -> Settings {
        UserDefaults.standard.removeObject(forKey: AppKeys.shared.settings)
        return Settings()
    }
}
