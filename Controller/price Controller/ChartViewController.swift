//
//  ChartViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/23.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    var gridViewController: UICollectionGridViewController!
    var MylineChartView=LineChartView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="价格图表"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToFatherPage))
        
        //let navigationHeight=self.navigationController?.navigationBar.frame.size.height
        
        let ScreenRect=UIScreen.main.bounds
        let ScreenWidth=ScreenRect.size.width
        let ScreenHeight=ScreenRect.size.height
        
        let Price=PAK.instance.SevenDaysPrice
        let DayPC=PAK.instance.DayPriceChange
        let MonPC=PAK.instance.MonthPriceChange
        
        
        for num in 0..<PAK.instance.SevenDaysPrice.count
        {
            print(PAK.instance.SevenDaysPrice[num])
        }
        let Days=["六日前","五日前","四日前","三日前","二日前","一日前","今日"]
        gridViewController = UICollectionGridViewController()
        gridViewController.setColumns(columns: ["日期","价格","较昨日增长","较上月增长"])
        gridViewController.addRow(row: ["六天前","\(Price[0])", "\(DayPC[0])", "\(MonPC[0])"])
        gridViewController.addRow(row: ["五天前","\(Price[1])", "\(DayPC[1])", "\(MonPC[1])"])
        gridViewController.addRow(row: ["四天前","\(Price[2])", "\(DayPC[2])", "\(MonPC[2])"])
        gridViewController.addRow(row: ["三天前","\(Price[3])", "\(DayPC[3])", "\(MonPC[3])"])
        gridViewController.addRow(row: ["两天前","\(Price[4])", "\(DayPC[4])", "\(MonPC[4])"])
        gridViewController.addRow(row: ["一天前","\(Price[5])", "\(DayPC[5])", "\(MonPC[5])"])
        gridViewController.addRow(row: ["今日","\(Price[6])", "\(DayPC[6])", "\(MonPC[6])"])
        
        let navigationHeight=self.navigationController?.navigationBar.frame.size.height
        
        gridViewController.view.frame = CGRect(x:ScreenWidth/14, y:30+navigationHeight!, width:ScreenWidth/14*12,height:ScreenHeight/3*0.9)
        
        MylineChartView.frame=CGRect(x:0,y:30+navigationHeight!+ScreenHeight/3*0.9+60,width:ScreenWidth,height:ScreenHeight/2)
        
        setChart(dataPoints: Days, values: Price)
        
        MylineChartView.rightAxis.enabled = false;
        MylineChartView.doubleTapToZoomEnabled = false;
        MylineChartView.chartDescription?.text="最近七日间价格变化"
        let leftAxis = MylineChartView.leftAxis;
        leftAxis.forceLabelsEnabled = false;
        let xAxis = MylineChartView.xAxis;
        xAxis.granularityEnabled = true;
        xAxis.labelPosition = .bottom;
        
        self.view.backgroundColor=UIColor.white
        self.view.addSubview(gridViewController.view)
        self.view.addSubview(MylineChartView)
        // Do any additional setup after loading the view.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        //let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        //let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        //pieChartView.data = pieChartData
        
        /*var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }*/
        
        //pieChartDataSet.colors = colors
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "（价格：元／每斤）")
        let lineChartData = LineChartData()
        lineChartData.addDataSet(lineChartDataSet)
        
        MylineChartView.data = lineChartData
        
    }
    
    @objc func returnToFatherPage()
    {
        //PAK.instance.SevenDaysPrice.removeAll()
        //PAK.instance.DayPriceChange.removeAll()
        //PAK.instance.MonthPriceChange.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
