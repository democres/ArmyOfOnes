//
//  ChartViewController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var chartView: BarChartView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        chartView?.delegate = self
        chartView?.drawBarShadowEnabled = false
        chartView?.drawValueAboveBarEnabled = false
        chartView?.maxVisibleCount = 60

        
        chartView?.xAxis.labelPosition = .bottom
        chartView?.xAxis.labelFont = .systemFont(ofSize: 10)
        chartView?.xAxis.granularity = 1
        chartView?.xAxis.labelCount = 7
        chartView?.xAxis.valueFormatter = DefaultAxisValueFormatter(decimals: 1)
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " $"
        leftAxisFormatter.positiveSuffix = " $"
        
        let leftAxis = chartView?.leftAxis
        leftAxis?.labelFont = .systemFont(ofSize: 10)
        leftAxis?.labelCount = 8
        leftAxis?.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis?.labelPosition = .outsideChart
        leftAxis?.spaceTop = 0.15
        leftAxis?.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
        let rightAxis = chartView?.rightAxis
        rightAxis?.enabled = true
        rightAxis?.labelFont = .systemFont(ofSize: 10)
        rightAxis?.labelCount = 8
        rightAxis?.valueFormatter = leftAxis?.valueFormatter
        rightAxis?.spaceTop = 0.15
        rightAxis?.axisMinimum = 0
        
        let legend = chartView?.legend
        legend?.horizontalAlignment = .left
        legend?.verticalAlignment = .bottom
        legend?.orientation = .horizontal
        legend?.drawInside = false
        legend?.form = .circle
        legend?.formSize = 9
        legend?.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        legend?.xEntrySpace = 4
        
//
//
//        let marker = MarkerView(color: UIColor.green,
//                                  font: .systemFont(ofSize: 12),
//                                  textColor: .white,
//                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
//                                  xAxisValueFormatter: chartView?.xAxis.valueFormatter!)
//        marker.chartView = chartView
//        marker.minimumSize = CGSize(width: 80, height: 40)
//        chartView.marker = marker

        
        
        
        
        updateGraph()
    }
    
    
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]()
        var numbers = [0.2,1.2,44.1,1.0]
        
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        
        
        let line1 = BarChartDataSet(entries: lineChartEntry, label: "DAMN")
        line1.colors = [NSUIColor.green] //Sets the colour to blue
        
        let data = BarChartData() //This is the object that will be added to the chart
        data.addDataSet(line1) //Adds the line to the dataSet
        
        
        chartView?.data = data //finally - it adds the chart data to the chart and causes an update
        chartView?.chartDescription?.text = "My awesome chart" // Here we set the description for the graph
    }
    
    
}



