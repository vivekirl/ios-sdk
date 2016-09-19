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

protocol TwoWaySliderDelegate : NSObjectProtocol{
    func sliderChangedForKey(key : String, leftVal : CGFloat, rightVal : CGFloat)
}

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class TwoWaySlider: UIView {

//*************************************************
// MARK: - Properties
//*************************************************
    
    var delegate : TwoWaySliderDelegate?
    var filterNameLabel : UILabel = UILabel()
    var rangeSlider : RangeSlider = RangeSlider(frame: CGRectZero)
    var currentFilter : FilterUIColumns!

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func createFilterWithFilter (filter : FilterUIColumns){
        currentFilter = filter
        filterNameLabel.frame = CGRectMake(0, 0, self.frame.size.width, 25)
        filterNameLabel.textAlignment = .Center
        filterNameLabel.text = filter.fullName
        filterNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        filterNameLabel.textColor = UIColor.whiteColor()
        self.addSubview(filterNameLabel)
        
        switch filterNameLabel.text! {
        case "YTD":
            filterNameLabel.backgroundColor = YTDColor
            break;
        case "Short Term (1 Yr)":
        //            64,224,208
            filterNameLabel.backgroundColor = shortTermColor
            break
        case "Mid Term (3 Yr)":
        //            50,205,50
            filterNameLabel.backgroundColor = midTermColor
            break
        case "Long Term (10 Yr)":
            //            139,0,0
            filterNameLabel.backgroundColor = longTermColor
           
            break
        case "Risk (Beta)":
            //            128,128,0
            filterNameLabel.backgroundColor = riskColor
            break
            
        case "Personality match":
            //            210,105,30
            filterNameLabel.backgroundColor = personalityColor
            break
            
        default:
            
            filterNameLabel.backgroundColor = UIColor.whiteColor()
        }
        
        rangeSlider.frame = CGRectMake(5,self.frame.height/2, self.frame.size.width - 10, 15)

        rangeSlider.minimumValue = filter.minValue!
        rangeSlider.lowerValue = rangeSlider.minimumValue
        rangeSlider.maximumValue = filter.maxValue!
        rangeSlider.upperValue = rangeSlider.maximumValue
        //        rangeSlider.leftStr = "\(rangeSlider.minimumValue)"
        //        rangeSlider.rightStr = "\(rangeSlider.maximumValue)"
        rangeSlider.addTarget(self, action: #selector(TwoWaySlider.rangeSliderValueChanged(_:)),
                                                      forControlEvents: .ValueChanged)
        //        rangeSlider.reload()
        self.addSubview(rangeSlider)
        
    }
    
    func rangeSliderValueChanged(sender : RangeSlider){
        delegate?.sliderChangedForKey(currentFilter.key!,
                                      leftVal: CGFloat(sender.lowerValue),
                                      rightVal: CGFloat(sender.upperValue))
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
}
