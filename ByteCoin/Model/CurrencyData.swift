//
//  CurrencyData.swift
//  ByteCoin
//
//  Created by Harshit Bhargava  on 13/02/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation


struct CurrencyData{
    let asset_id: String
    let rate: Double
    
    
    var rateString:String{
        String(format: "%.2f", rate)
    }
}
