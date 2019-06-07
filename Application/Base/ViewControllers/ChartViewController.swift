//
//  ChartViewController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import UIKit

class ChartViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var basicBarChart: BasicBarChart?
    @IBOutlet weak var beautifulBarChart: BeautifulBarChart?
    @IBOutlet weak var randomCurrencyTextField: UITextField?
    @IBOutlet weak var convertButton: UIButton?
    
    @IBOutlet weak var amountTitleLabel: UILabel?
    @IBOutlet weak var baseTitleLabel: UILabel?
    private let numEntry = 5

    var currencyAmount: Float?
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomCurrencyTextField?.addBorderToTextField()
        fetchViewControllerData()
        buttonsWithShadows()
        
        randomCurrencyTextField?.delegate = self
    }
    
    func buttonsWithShadows(){
        convertButton?.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        convertButton?.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        convertButton?.layer.shadowOpacity = 1.0
        convertButton?.layer.shadowRadius = 3.0
        convertButton?.layer.masksToBounds = false
        convertButton?.layer.cornerRadius = 4.0
    }

    func fetchViewControllerData(base: String? = "USD"){
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .userInitiated).async {
            if base != "USD" {
                CurrencyController.getExchangeRateCustomBase(base: base ?? "USD", completion: { (Currency) in
                    // Bounce back to the main thread to update the UI
                    DispatchQueue.main.async {
                        self.currency = Currency
                        self.generateChart()
                    }
                })
                return
            }
            CurrencyController.getExchangeRate(completion: { (Currency) in
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.currency = Currency
                    self.generateChart()
                }
            })
        }
        
    }
    
    func generateChart(){
        let dataEntries = generateDataEntries()
        basicBarChart?.updateDataEntries(dataEntries: dataEntries, animated: true)
        beautifulBarChart?.updateDataEntries(dataEntries: dataEntries, animated: true)
    }
    
    func generateDataEntries() -> [DataEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [DataEntry] = []
        
        let ratesArray = self.currency?.rates?.filter({ (key, _) -> Bool in
            return key == "GBP" || key == "EUR" || key == "JPY" || key == "BRL"
        })
        
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        guard let rates = ratesArray else { return result }
        var i = 0
        for rate in rates {
            let value = Float(truncating: rate.value as? NSNumber ?? 1)
            let height = value / ( value > 100 ? 1000 : 100)
            result.append(DataEntry(color: colors[i % colors.count], height: height, textValue:formatter.string(from: NSNumber(value: (value * (currencyAmount ?? 1)))) ?? "", title: rate.key))
            i += 1
        }
        
        return result
    }
    
    //MARK: Actions
    @IBAction func chartSwitch(_ sender: UISwitch) {
        if sender.isOn {
            basicBarChart?.isHidden = true
            beautifulBarChart?.isHidden = false
        } else {
            basicBarChart?.isHidden = false
            beautifulBarChart?.isHidden = true
        }
    }
    @IBAction func convertCustom(_ sender: Any) {
        guard let text = randomCurrencyTextField?.text, text.count == 3 else { return }
        fetchViewControllerData(base: text.uppercased())
        self.baseTitleLabel?.text = text.uppercased()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 3
    }
    
    
}

