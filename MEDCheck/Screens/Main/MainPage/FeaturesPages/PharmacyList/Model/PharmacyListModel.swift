//
//  PharmacyListModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import Foundation

struct PharmacyListModel {
    enum PharmacyCompany: String, CaseIterable {
        case neman = "Неман Фарм"
        case farmamir = "Фармамир"
        case aibolit = "Айболит"
        case bimedFarm = "Бимед Фарм"
    }
    
    var pharmacies: [PharmacyCompany:[String]]
    
    init() {
        pharmacies = [
            .neman: [
                "Байтик-Баатыра 93",
                "Горького 101",
                "Ибраимова 103",
                "Ленинградская 23",
            ],
            
            .farmamir: [
                "Чуй 23",
                "Горького 20"
            ],
        
            .aibolit: [
                "Манаса 15",
                "Токомбаева 105",
                "Адырская 54",
                "Наманганская 20"
            ],
        
            .bimedFarm: [
                "Ахунбаева 23"
            ]
            
        ]
    }
}
