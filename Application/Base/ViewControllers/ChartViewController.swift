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
    @IBOutlet weak var barChart: BeautifulBarChart?
    
    private let numEntry = 5

    var currencyAmount: Float?
    var currencyArray: [Currency]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchViewControllerData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let dataEntries = generateEmptyDataEntries()
        basicBarChart?.updateDataEntries(dataEntries: dataEntries, animated: false)
        barChart?.updateDataEntries(dataEntries: dataEntries, animated: false)

        let timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) {[weak self] (timer) in
            let dataEntries = self?.generateRandomDataEntries()
            self?.barChart?.updateDataEntries(dataEntries: dataEntries!, animated: true)
            self?.basicBarChart?.updateDataEntries(dataEntries: dataEntries!, animated: true)
        }
        timer.fire()
    
    }
    
    func fetchViewControllerData(){
        currencyArray = CurrencyController.getExchangeRate(amount: currencyAmount ?? 1)
    }
    
    
    func generateEmptyDataEntries() -> [DataEntry] {
        var result: [DataEntry] = []
        for _ in currencyArray! {
            result.append(DataEntry(color: UIColor.clear, height: 0, textValue:"", title: ""))
        }
        return result
    }
    
    func generateRandomDataEntries() -> [DataEntry] {
        let colors = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)]
        var result: [DataEntry] = []
        for i in 0..<(currencyArray?.count ?? 0) {
            let value = currencyArray?[i].value ?? 0
            let height: Float = Float(value) / 100.0
            result.append(DataEntry(color: colors[i % colors.count], height: height, textValue:"\(currencyArray?[i].value ?? 0.0)", title: currencyArray?[i].name ?? ""))
        }
        return result
    }
}

