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

let typeKey = "type"
let keyKey = "key"
let fullNameKey = "full_name"
let goalKey = "goal"
let isObjectiveKey = "is_objective"

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

class FilterColumns: NSObject {
    
//*************************************************
// MARK: - Properties
//*************************************************

    var type : String?
    var key : String?
    var fullName : String?
    var goal : String?
    var isObjective : Bool = false
    
//*************************************************
// MARK: - Constructors
//*************************************************
  
    init(dictionary : NSDictionary){
        type = dictionary.valueForKey(typeKey) as? String
        key = dictionary.valueForKey(keyKey) as? String
        fullName = dictionary.valueForKey(fullNameKey) as? String
        goal = dictionary.valueForKey(goalKey) as? String
        if ((dictionary.valueForKey(isObjectiveKey) as? NSNumber) != nil) {
            isObjective = ((dictionary.valueForKey(isObjectiveKey) as? NSNumber)?.boolValue)!
        }
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
