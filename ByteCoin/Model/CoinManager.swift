//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Harshit on 13/02/2024.

//

import Foundation

protocol CoinManagerDelegate {
    func updateCurrency(_ cData: CurrencyData)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "Api-Key"
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(currency: String){
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        guard let url = URL(string: urlString) else{
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URLRequest(url: url)){ data, response, error in
            if error != nil{
                print(error!)
                return
            }
            if let data = data{
                if let cData = jsonParser(data){
                    delegate?.updateCurrency(cData)
                }
            }
        }
        task.resume()
    }
    
    func jsonParser(_ data:Data) -> CurrencyData?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(AssetManager.self, from: data)
            let currencyData = CurrencyData(asset_id: decodeData.asset_id_quote, rate: decodeData.rate)
            return currencyData
        } catch {
            return nil
        }
    }
}
