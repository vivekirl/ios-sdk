/*
 * Assembly Kit
 * Licensed Materials - Property of IBM
 * Copyright (C) 2016 IBM Corp. All Rights Reserved.
 * 6949 - XXX
 *
 * IMPORTANT:  This IBM software is supplied to you by IBM
 * Corp. ("IBM") in consideration of your agreement to the following
 * terms, and your use, installation, modification or redistribution of
 * this IBM software constitutes acceptance of these terms. If you do
 * not agree with these terms, please do not use, install, modify or
 * redistribute this IBM software.
 */

import UIKit

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

let pi:CGFloat = 3.14159265358979323846264338327950288

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Protocols -
//
//**************************************************************************************************

 @objc protocol PieChartDataSource {
    optional func dataForPie()->[PieChartDataItem]
    optional func dataForPie(chart : PieChartView)->[PieChartDataItem]
    optional func showAnimation()->Bool //default value is false
    optional func showLabel() ->Bool // default value false
    optional func showPercentage() ->Bool // default value false
    optional func showLegend()->Bool //default is false
}

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class PieChartView: UIView {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var dataSource: PieChartDataSource?
    
    var dataSource1: PieChartDataSource?
    var pieChartItems:[PieChartDataItem]?
    var pieChartLabel:[String]?
    var legendFontName:String?
    var labelFontName:String?
    var showLabels = false //default value
    var showPercentage = false //default value
    var showAnimation = false //default value
    var showLegend = false //default value
    var radius:CGFloat = 100 //default value
    var legendOffSet:CGFloat = 15 //default value
    var legendSize:CGFloat = 15 //default value
    var legendFontSize:CGFloat = 15 //default value
    var labelFontSize:CGFloat = 17 //default value
    var animationDuration:CFTimeInterval = 5 //default value
    
    
    var total:CGFloat = CGFloat()
    var centerPie = CGPoint()
    var startAngle = CGFloat()
    var endAngle = CGFloat()
    var startPercentage = CGFloat()
    var endPercentage = CGFloat()
    var currentValue:CGFloat = CGFloat()

//*************************************************
// MARK: - Constructors
//*************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func centerGraph(factor : CGFloat = 1.0) {
        
        self.backgroundColor = UIColor.clearColor()
        self.centerPie = CGPointMake(frame.size.width / (2 * factor), frame.size.height/2)
    }
    
    func drawPie(){
        self.currentValue  = 0
        for pieChartItem in pieChartItems! {
            
            let currentItem = pieChartItem.value
            let currentColor = pieChartItem.color
            
            let circle = CAShapeLayer(layer: layer)
            self.startPercentage = self.currentValue / self.total
            self.endPercentage = (self.currentValue + CGFloat(currentItem)) / self.total
            
            self.startAngle = self.startPercentage * 360
            self.endAngle = self.endPercentage * 360
            
            if pieChartItem.radius != -1{
                circle.path = getPath(self.startAngle, end: self.endAngle, myColor:currentColor,
                                      radius:pieChartItem.radius).CGPath
            } else {
                circle.path = getPath(self.startAngle, end: self.endAngle, myColor:currentColor,
                                      radius:radius).CGPath
            }

            circle.fillColor = currentColor.CGColor
            circle.strokeColor = UIColor.darkGrayColor().CGColor
            self.currentValue = self.currentValue + CGFloat(currentItem)
            self.layer.addSublayer(circle)
        }
    }
    
    //add animation of colors coming from 0 to 1 not a valid animation
    func addAnimation(layerToAnimate:CALayer, color:UIColor = UIColor.blackColor() ){
        let fillColorAnimation = CABasicAnimation (keyPath: "fillColor")
        fillColorAnimation.duration = self.animationDuration
        fillColorAnimation.fromValue = UIColor.clearColor().CGColor
        fillColorAnimation.toValue = color.CGColor
        fillColorAnimation.repeatCount = 1
        fillColorAnimation.timingFunction  = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionDefault)
        layerToAnimate.addAnimation(fillColorAnimation, forKey: "fillColor")
    }
    
    func drawLabels(){
        self.currentValue = 0
        var i: Int = 0
        for pieChartItem in self.pieChartItems! {
            self.startPercentage = self.currentValue / self.total
            self.endPercentage = (self.currentValue + pieChartItem.value) / self.total
            self.startAngle = self.startPercentage * 360
            self.endAngle = self.endPercentage * 360
            self.descriptionLabel(pieChartItem.descriptionValue!,start: self.startAngle,
                                  end: self.endAngle)
            self.currentValue = self.currentValue + pieChartItem.value
            i += 1
        }
    }
    
    func drawLegend(){
        let xPosition = self.centerPie.x + self.radius + self.legendOffSet
        var yPosition = self.centerPie.y - self.radius/2
        
        //for each item in legend
        for pieChartItem in pieChartItems! {
            let legendLayer = CAShapeLayer(layer: layer)
            let path = UIBezierPath()
            
            //draw the box for the legend
            path.moveToPoint(CGPoint(x: xPosition, y: yPosition))
            path.addLineToPoint(CGPoint(x: xPosition + self.legendSize, y: yPosition))
            path.addLineToPoint(CGPoint(x: xPosition + self.legendSize,
                y: yPosition + self.legendSize))
            path.addLineToPoint(CGPoint(x: xPosition, y: yPosition + self.legendSize))
            path.closePath()
            
            //fill box with right colour
            legendLayer.path = path.CGPath
            legendLayer.fillColor = pieChartItem.color.CGColor
            legendLayer.strokeColor = UIColor.clearColor().CGColor
            self.layer.addSublayer(legendLayer)
            
            //draw legend text
            let legendText = self.getLabel(pieChartItem.descriptionValue!,
                                           labelCenter: CGPoint(x:xPosition + 110 ,
                                            y: yPosition + self.legendSize/2),
                                           alignment: NSTextAlignment.Left,isLegend: true)
            self.addSubview(legendText)
            
            //move down (twice the size of the legend box)
            yPosition = yPosition + 2 * self.legendSize
        }
    }
    
    func descriptionLabel(label:String,start:CGFloat,end:CGFloat){
        
        let path = UIBezierPath()
        path.moveToPoint(self.centerPie)
        path.appendPath(UIBezierPath(arcCenter: self.centerPie, radius: self.radius/1.8,
            startAngle: self.getRadian(start), endAngle: self.getRadian((start + end)/2),
            clockwise: true))
        let labelCenter = path.currentPoint
        path.closePath()
        let desLabel = self.getLabel(label, labelCenter: labelCenter,
                                     alignment: NSTextAlignment.Center ,isLegend: false)
        self.addSubview(desLabel)
    }
    
    func getLabel(labelText :String, labelCenter : CGPoint, alignment: NSTextAlignment,
                  isLegend:Bool) -> UILabel{
        let frame = CGRectMake(0, 0, 180, 80)
        let labelToDraw = UILabel(frame: frame)
        labelToDraw.text = labelText
        
        if isLegend{
            if self.legendFontName != nil{
                labelToDraw.font = UIFont(descriptor:
                    UIFontDescriptor(name: self.legendFontName!, size: self.legendFontSize),
                                          size: self.legendFontSize)
            }else{
                labelToDraw.font = UIFont(descriptor: UIFontDescriptor(), size: self.legendFontSize)
            }
        }else{
            if self.labelFontName != nil{
                labelToDraw.font = UIFont(descriptor:
                    UIFontDescriptor(name: self.labelFontName!, size: self.labelFontSize),
                                          size: self.labelFontSize)
            }else{
                labelToDraw.font = UIFont(descriptor: UIFontDescriptor(), size: self.labelFontSize)
            }
            
        }
        labelToDraw.textColor = UIColor.blackColor()
        labelToDraw.textAlignment = alignment
        labelToDraw.center = labelCenter
        labelToDraw.backgroundColor = UIColor.clearColor()
        return labelToDraw
        
    }
    
    func getPath(start:CGFloat,end:CGFloat,myColor:UIColor, radius : CGFloat)->UIBezierPath{
        let path = UIBezierPath()
        path.moveToPoint(self.centerPie)
        path.appendPath(UIBezierPath(arcCenter: self.centerPie, radius: radius,
            startAngle: self.getRadian(start), endAngle: self.getRadian(end), clockwise: true))
        path.addLineToPoint(self.centerPie)
        path.closePath()
        return path
        
    }
    
    
    func getRadian(degreeValue:CGFloat)->CGFloat{
        let radianValue = (pi / 180) * degreeValue
        return radianValue
    }
    
    func setTheTotal(pieChartItems:[PieChartDataItem]){
        self.total = 0
        for pieChartItem in pieChartItems {
            self.total = self.total + pieChartItem.value
        }
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func drawRect(rect: CGRect){
        
        if self.dataSource != nil{
            
            if let isLabel = self.dataSource?.showLabel?(){
                self.showLabels = isLabel
            }
            
            if let isPercentage = self.dataSource?.showPercentage?(){
                self.showPercentage = isPercentage
            }
            
            if let isAnimation = self.dataSource?.showAnimation?(){
                self.showAnimation = isAnimation
            }
            
            if let isLegend = self.dataSource?.showLegend?(){
                self.showLegend = isLegend
            }
            if (self.dataSource?.dataForPie!() != nil){
                self.pieChartItems = self.dataSource?.dataForPie!()
            }
            if (self.dataSource1?.dataForPie!(self) != nil){
                self.pieChartItems = self.dataSource1?.dataForPie!(self)
            }
            self.setTheTotal(self.pieChartItems!)
            
            self.drawPie()
            
            if self.showLabels{
                self.drawLabels()
            }
            
            if self.showLegend{
                self.drawLegend()
            }
            
        }
        
    }
    
    
}
