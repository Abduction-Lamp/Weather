//
//  AlertsResponse.swift
//  Weather
//
//  Created by Владимир on 25.04.2022.
//

import Foundation

struct AlertsResponse: Decodable {
    let sender: String          // Название источника оповещений
    let event: String           // Имя события оповещения
    let start: TimeInterval     // Дата и время начала оповещения, Unix, UTC
    let end: TimeInterval       // Дата и время окончания оповещения, Unix, UTC
    let description: String     // Описание предупреждения
    let tags: [String]          // Тип погоды
    
    private enum CodingKeys: String, CodingKey {
        case sender = "sender_name"
        case event, start, end, description, tags
    }
}
