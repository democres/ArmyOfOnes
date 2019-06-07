//
//  ChartViewController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import UIKit

class ChartViewController: UIViewController {
    @IBOutlet weak var basicBarChart: BasicBarChart?
    @IBOutlet weak var beautifulBarChart: BeautifulBarChart?
    
    private let numEntry = 5

    var currencyAmount: Float?
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchViewControllerData()
    }
    

    func fetchViewControllerData(){
        
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .userInitiated).async {
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
//
//        let timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) {[weak self] (timer) in
//            let dataEntries = self?.generateRandomDataEntries()
//            self?.barChart?.updateDataEntries(dataEntries: dataEntries!, animated: true)
//            self?.basicBarChart?.updateDataEntries(dataEntries: dataEntries!, animated: true)
//        }
//        timer.fire()
    }
    
    func generateDataEntries() -> [DataEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [DataEntry] = []
        
        guard let rates = self.currency?.rates else { return result}
        var i = 0
        for rate in rates {
            let value = Float(rate.value as? NSNumber ?? 1)
            let height: Float = Float(value) / 100.0
            result.append(DataEntry(color: colors[i % colors.count], height: height, textValue:"\(value)", title: rate.key))
            i += 1
        }
        
        return result
    }
    
    @IBAction func chartSwitch(_ sender: UISwitch) {
        if sender.isOn {
            basicBarChart?.isHidden = true
            beautifulBarChart?.isHidden = false
        } else {
            basicBarChart?.isHidden = false
            beautifulBarChart?.isHidden = true
        }
    }
    
}

