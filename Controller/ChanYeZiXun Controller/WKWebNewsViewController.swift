//
//  WKWebNewsViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/7/9.
//  Copyright © 2018年 OS. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import WebKit

class WKWebNewsViewController:UIViewController,WKUIDelegate,WKNavigationDelegate{
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        self.title="资讯详情"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToFatherPage))
        let navigationHeight=self.navigationController?.navigationBar.frame.size.height
        let bounds=UIScreen.main.bounds
        let frame=CGRect(x:0,y:0-navigationHeight!,width:bounds.width,height:bounds.height)
        
        let url=URL(string:NewsModel.instance.urllists[NewsModel.instance.selectedRow])
        let urlRequest=URLRequest(url:url!)
        
        let webView = WKWebView.init(frame: view.bounds)
        webView.navigationDelegate = self
        webView.backgroundColor=UIColor.clear
        //webView.autoresizingMask = .flexibleHeight
        //webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.load(urlRequest)
        
        self.view.addSubview(webView)
    }

    
    @objc func returnToFatherPage()
    {
        self.navigationController?.popViewController(animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

