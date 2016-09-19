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
// MARK: - Class -
//
//**************************************************************************************************

class FilterScrollView: UIScrollView {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
     weak var viewController : TradeoffOutputView!

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func populateWithFilters(filterArr : Array<FilterUIColumns>){
        
        var xOffset : CGFloat = 10.0
        
        for index in 0...filterArr.count - 1{
            let twoWaySlider = TwoWaySlider()
            twoWaySlider.backgroundColor = UIColor.whiteColor()
            twoWaySlider.frame = CGRectMake(CGFloat(xOffset), 0, 200, 90)
            twoWaySlider.createFilterWithFilter(filterArr[index])
            twoWaySlider.delegate = viewController
            twoWaySlider.layer.shadowColor = UIColor.blackColor().CGColor
            twoWaySlider.layer.shadowOffset = CGSizeMake(0, 2);
            twoWaySlider.layer.shadowRadius = 5.0
            twoWaySlider.layer.shadowOpacity = 0.7
            self.addSubview(twoWaySlider)
            xOffset = xOffset + 210.0
        }
        self.contentSize = CGSizeMake(CGFloat(xOffset), self.frame.size.height)
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
}
