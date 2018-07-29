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
    var stationLocation:Array<Double>=[]
    var selectedStation:Int = 0
    var stationName:Array<String>=[]
    var Introduce:Array<String>=[]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        
        stationName.append("白水苹果试验站")
        stationName.append("西农苹果研究中心")
        Introduce.append("坐落于渭南市，是全国首个专业从事苹果生产技术研究、试验、示范、培训和技术推广服务的事业单位。有高级研究和推广专家20多名，博士、硕士研究生20多名，每年国际同行20多人前来交流，7000多国内外果农前来参观学习和考察。")
        Introduce.append("坐落于西农北校区，专门从事于各类苹果生长，外观，口味，病虫害等研究的国家级研究中心")
        
        super.viewDidLoad()
        self.title="示范站地图"
        self.navigationItem.leftBarButtonItem=UIBarButtonItem(title:"返回",style:UIBarButtonItemStyle.plain,target:self,action: #selector(returnToHomePage))
        
        let mapView=MKMapView()
        
        mapView.frame=self.view.bounds
        mapView.delegate = self
        mapView.mapType = MKMapType.standard
        
        let coordinate2D=CLLocationCoordinate2D(latitude:stationLocation[1],longitude:stationLocation[0])
        let region=MKCoordinateRegionMake(coordinate2D, MKCoordinateSpanMake(0.02, 0.02))
        mapView.setRegion(region, animated: true)
        
        let objectAnnotation=MKPointAnnotation()
        objectAnnotation.coordinate=coordinate2D
        objectAnnotation.title=stationName[selectedStation]
        objectAnnotation.subtitle="点击左侧图标查看介绍"
        
        mapView.addAnnotation(objectAnnotation)
        
        self.view.addSubview(mapView)
        
        // Do any additional setup after loading the view.
    }
    
    
    func mapView(_ mapView:MKMapView,viewFor annotation:MKAnnotation)->MKAnnotationView?{
        let identifier="annotationView"
        var annotationView=mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView==nil{
            annotationView=MKAnnotationView(annotation:annotation,reuseIdentifier:identifier)
        }
        
        let buttuon=UIButton(type:UIButtonType.infoDark)
        buttuon.addTarget(self, action: #selector(showInfo), for: .touchUpInside)
        annotationView?.leftCalloutAccessoryView=buttuon
        annotationView?.image=UIImage(named:"place2")
        
        self.selectedAnnotion=annotation
        annotationView?.canShowCallout=true
        return annotationView
    }
    
    @objc func showInfo(){
        let message=Introduce[selectedStation]
        let alertView=UIAlertController(title:self.selectedAnnotion.title!,message:message,preferredStyle:UIAlertControllerStyle.alert)
        let OKAction=UIAlertAction(title:"确认",style:.default,handler:nil)
        alertView.addAction(OKAction)
        self.present(alertView,animated: true,completion: nil)
    }
    
    /*func mapView(_mapView:MKMapView,didSelect view:MKAnnotationView){
     print(view.annotation?.coordinate ?? 0)
     }*/
    
    
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
