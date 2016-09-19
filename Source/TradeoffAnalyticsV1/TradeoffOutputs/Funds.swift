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

let valuesKey = "values"
let key = "key"
let nameKey = "name"
let managerTenureKey = "Manager Tenure"
let ytdKey = "YTD"
let shortTermKey = "Short Term (1 Yr)"
let midTermKey = "Mid Term (3 Yr)"
let assetsKey = "Assets"
let netExpenseKey = "Net Expense"
let personalityKey = "Personality"
let riskKey = "Risk (Beta)"
let longTermKey = "Long Term (10 Yr)"
let morningStarRatingKey = "Morningstar Rating"
let descKey = "description_html"
let appDataKey = "app-data"

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

class Funds: NSObject {

//*************************************************
// MARK: - Properties
//*************************************************
    
    var key : String?
    var name : String?
    var managerTenure : Int?  = 0
    var YTD : Float? = 0.0
    var shortTerm : Float? = 0.0
    var midTerm : Float? = 0.0
    var assets : Float? = 0.0
    var netExpense : Float? = 0.0
    var personality : Float? = 0.0
    var risk : Float? = 0.0
    var longTerm : Float? = 0.0
    var morningstarRating : Int? = 0
    
    var descriptionHtml : String?
    var appData : NSDictionary?

//*************************************************
// MARK: - Constructors
//*************************************************
    
    init(dictionary : NSDictionary){
        if ((dictionary.valueForKey(keyKey) as? String) != nil) {
            key = dictionary.valueForKey(keyKey) as? String
        }
        name = dictionary.valueForKey(nameKey) as? String
        
        if ((dictionary.valueForKey(valuesKey) as? NSDictionary) != nil) {
            if let valueDict = dictionary.valueForKey(valuesKey) as? NSDictionary {
                managerTenure = (valueDict.valueForKey(managerTenureKey) as? NSNumber)?.integerValue
                YTD = ((valueDict.valueForKey(ytdKey) as? NSNumber)?.floatValue)!
                shortTerm = ((valueDict.valueForKey(shortTermKey) as? NSNumber)?.floatValue)!
                midTerm = ((valueDict.valueForKey(midTermKey) as? NSNumber)?.floatValue)!
                assets = ((valueDict.valueForKey(assetsKey) as? NSNumber)?.floatValue)!
                netExpense = ((valueDict.valueForKey(netExpenseKey) as? NSNumber)?.floatValue)!
                personality = ((valueDict.valueForKey(personalityKey) as? NSNumber)?.floatValue)!
                risk = ((valueDict.valueForKey(riskKey) as? NSNumber)?.floatValue)!
                if ((valueDict.valueForKey(longTermKey) as? NSNumber) != nil) {
                    longTerm = ((valueDict.valueForKey(longTermKey) as? NSNumber)?.floatValue)!
                }
                if let value = valueDict.valueForKey(morningStarRatingKey) as? NSNumber {
                    morningstarRating = value.integerValue
                }
            }
        }
        
        descriptionHtml = dictionary.valueForKey(descKey) as? String
        appData = dictionary.valueForKey(appDataKey) as? NSDictionary
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
