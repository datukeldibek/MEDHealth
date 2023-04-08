//
//  PharmaciesList.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import Foundation

struct PharmaciesList {
    // MARK: - Singleton
    static let shared = PharmaciesList()
    
    enum PharmacyCompany: String, CaseIterable {
        case nemanFarm = "Неман Фарм"
        case farmamir = "Фармамир"
        case aibolit = "Айболит"
        case bimedFarm = "Бимед Фарм"
        case niman = "Ниман"
        case insanFarm = "Инсан Фарм"
    }
    
    var pharmacies: [PharmacyCompany:[String]]
    
    private init() {
        pharmacies = [
                .nemanFarm: [
                    "Байтик-Баатыра 93",
                    "Горького 101",
                    "Ибраимова 103",
                    "Ленинградская 23",
                    "Байтик Баатыра 57",
                    "Московская 69",
                    "Киевская 38",
                    "Тоголок Молдо 14"
                ],
                
                .farmamir: [
                    "Чуй 23",
                    "Горького 20",
                    "Байтик Баатыра 51",
                    "Московская 86",
                    "Льва Толстого 24",
                    "Ибрамова 57"
                    
                ],
            
                .aibolit: [
                    "Манаса 15",
                    "Токомбаева 105",
                    "Адырская 54",
                    "Наманганская 20",
                    "Скрябина 35",
                    "Тоголок Молдо 1/12",
                    "7-й микрорайон 28"
                    
                ],
            
                .bimedFarm: [
                    "Ахунбаева 23",
                    "Манаса 40",
                    "Байтик Баатыра 76",
                    "Горького 124",
                    "Абдрахманова 129"
                ],
            
                .insanFarm: [
                    "Усенбаева 47",
                    "Московская 41а",
                ]
        ]
    }
    
}
