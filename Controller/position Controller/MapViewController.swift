//
//  MapViewController.swift
//  ShenNongTongV0.2
//
//  Created by OS on 2018/3/26.
//  Copyright © 2018年 OS. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    var selectedAnnotion:MKAnnotation!
   // let mapView=MKMapView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="示范站地图"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
         let mapView=MKMapView()
        
        //mapView=MKMapView(frame:self.view.bounds)
        mapView.frame=self.view.bounds
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        
        let coordinate2D=CLLocationCoordinate2D(latitude:35.187993,longitude:109.452671)
        let region=MKCoordinateRegionMake(coordinate2D, MKCoordinateSpanMake(0.02, 0.02))
        mapView.setRegion(region, animated: true)
        
        let objectAnnotation=MKPointAnnotation()
        objectAnnotation.coordinate=coordinate2D
        objectAnnotation.title="白水实验站"
        objectAnnotation.subtitle="西北农林科技大学苹果实验站分站（点击左侧查看介绍）"
        //objectAnnotation.accessibilityFrame.size=CGSize(width:400,height:250)
        mapView.addAnnotation(objectAnnotation)
        
        self.view.addSubview(mapView)

        // Do any additional setup after loading the view.
    }
    
    
    func mapView(_ mapView:MKMapView,viewFor annotation:MKAnnotation)->MKAnnotationView?{
        let identifier="annotationView"
        var annotationView=mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView==nil{
            print("失败！\n")
            annotationView=MKAnnotationView(annotation:annotation,reuseIdentifier:identifier)
        }
        print("SUCCESS!\n")
        let buttuon=UIButton(type:UIButtonType.infoDark)
        buttuon.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        annotationView?.leftCalloutAccessoryView=buttuon
        annotationView?.image=UIImage(named:"place2")
        
        self.selectedAnnotion=annotation
        annotationView?.canShowCallout=true
        return annotationView
    }
    
    @objc func showInfo(){
        let message="这里是西农白水苹果实验站，该站位于xxxx，目前主要在干xxxx"
        let alertView=UIAlertController(title:self.selectedAnnotion.title!,message:message,preferredStyle:UIAlertControllerStyle.alert)
        let OKAction=UIAlertAction(title:"确认",style:.default,handler:nil)
        alertView.addAction(OKAction)
        self.present(alertView,animated: true,completion: nil)
    }
    
    func mapView(_mapView:MKMapView,didSelect view:MKAnnotationView){
        print(view.annotation?.coordinate ?? 0)
        //print(view.annotation?.title)
        //print(view.annotation?.subtitle)
    }
    
    
    @objc func returnToHomePage()
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
