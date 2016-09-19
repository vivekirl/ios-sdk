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

import TradeoffAnalyticsV1
import Foundation

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

let sharedStorageObject : Storage = { Storage() }()

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

class Storage: NSObject {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    //- Tradeoff Analytics
    var arrColumns: [Column] = [Column]()

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    class func sharedObject() -> Storage {
        return sharedStorageObject
    }

    
//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
}