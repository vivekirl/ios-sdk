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

import Foundation
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

class PieChartDataItem:NSObject {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var value : CGFloat = CGFloat()
    var color :UIColor = UIColor()
    var descriptionValue: String?
    var radius : CGFloat = -1

//*************************************************
// MARK: - Constructors
//*************************************************
    
    convenience override init () {
        self.init(value: 0.0, color: UIColor(), description: "")
    }

    init (value: CGFloat, color: UIColor, description: String) {
        self.value = value
        self.color = color
        self.descriptionValue = description
    }

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************

//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************

}

