//
//  WebNewsViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/20.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import Alamofire
class WebNewsViewController: UIViewController,UIWebViewDelegate,UITabBarDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title="资讯详情"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToFatherPage))
        
        let navigationHeight=self.navigationController?.navigationBar.frame.size.height
        let bounds=UIScreen.main.bounds
        let frame=CGRect(x:0,y:0-navigationHeight!,width:bounds.width,height:bounds.height)
        let webView=UIWebView(frame:frame)
        
        
        
        webView.delegate=self
        webView.scalesPageToFit=true
        webView.backgroundColor=UIColor.white
        webView.scrollView.bounces=false
        
        let url=URL(string:NewsModel.instance.urllists[NewsModel.instance.selectedRow])
        let urlRequest=NSURLRequest(url:url!)
        webView.loadRequest(urlRequest as URLRequest)
        
        
        
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
