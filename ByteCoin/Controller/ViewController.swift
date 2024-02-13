//
//  ViewController.swift
//  ByteCoin
//
//  Created by Harshit on 13/02/2024.

//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    var  coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }


}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        coinManager.getCoinPrice(currency: coinManager.currencyArray[row])
    }
    
}

extension ViewController: CoinManagerDelegate{
    func updateCurrency(_ cData: CurrencyData) {
        DispatchQueue.main.async {
            self.currencyLabel.text = cData.asset_id
            self.bitCoinLabel.text = cData.rateString
        }
    }
    
    
}
