//
//  ChanPinWebViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/4/8.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit

class ChanPinWebViewController: UIViewController,UIWebViewDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="资讯详情"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回产品服务列表",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToFatherPage))
        
        let navigationHeight=self.navigationController?.navigationBar.frame.size.height
        let bounds=UIScreen.main.bounds
        let frame=CGRect(x:0,y:navigationHeight!+10,width:bounds.width,height:bounds.height)
        let webView=UIWebView(frame:frame)
        
        webView.delegate=self
        webView.scalesPageToFit=true
        webView.backgroundColor=UIColor.clear

        let url=URL(string:ServiceKinds.instance.GetURLS[ServiceKinds.instance.selectedRow])
        print(ServiceKinds.instance.GetURLS[ServiceKinds.instance.selectedRow])
        print("REmind!")
        let urlRequest=NSURLRequest(url:url!)
        webView.loadRequest(urlRequest as URLRequest)
        webView.scrollView.bounces=false
        self.view.addSubview(webView)
        
        // Do any additional setup after loading the view.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible=true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible=false
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
