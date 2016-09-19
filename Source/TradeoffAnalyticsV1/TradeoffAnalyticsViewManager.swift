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
// MARK: - protocols-
//
//**************************************************************************************************

/**
 This protocol is responsible for calling the graph of tradeoff Analytics.
 */
public protocol TradeoffAnalyticsViewManagerDelegate {
    func willShowTradeoffAnalyticsGraph(TAGraph: UIView)
}

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

/**
This class works with the analysis of the tradeoff.
*/
public class TradeoffAnalyticsViewManager {
    
//*************************************************
// MARK: - Definitions
//*************************************************
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var tradeoffInputView: TradeoffInputView!
    var tradeoffOutputView: TradeoffOutputView!
    
    /**
     This var is the Delegate of Class.
     */
    public var delegate : TradeoffAnalyticsViewManagerDelegate!
    
    /**
     This property allows you to generate the display or not (True by default).
     */
    public var generateVisualization: Bool = true

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//    private func preparePathTradeoffAnalyticsForContent() -> String {
//        var path = "\(WDCClient.url)\(kTADilemmasAPIExtn)?"
//        path += "\(kTAGenerateVisualizationInputKey)=\(generateVisualization)"
//        return path
//    }
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func showTradeoffAnalyticsGraph(response: AnyObject) -> UIView {
        if let vc = self.delegate as? UIViewController {
            tradeoffOutputView = TradeoffOutputView(frame: vc.view.bounds)
            tradeoffOutputView.populateOutputView(response)
            return tradeoffOutputView
        } else {
            return UIView()
        }
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    /**
     This method makes the view with the information from the tradeoff received from Watson.
     
     - returns: a view with the information from the tradeoff.
    */
    public func getViewWithFrameForTradeoffInputData(frame frame:CGRect, inputData: Problem)
        -> UIView {
    
        let defaultFrame = CGRectMake(0, 0, 500, 500)
        
        if frame != CGRectZero {
            tradeoffInputView = TradeoffInputView(frame: frame)
        }
        else {
            tradeoffInputView = TradeoffInputView(frame: defaultFrame)
        }
        
        if inputData.columns.count > 0 {
            
            tradeoffInputView.resetInputView()
            tradeoffInputView.populateInputView(inputData.subject, columns: inputData.columns, rows: inputData.options)
            
            return tradeoffInputView
        }
            
        return UIView()
    }
    
    /**
     This method makes the request to be sent by the manager and also connects the class Delegate.
     
     - parameter content: It is the content that you will use to enter the URL of the request made 
     by the manager.
     */
//    public func getTradeoffAnalyticsForContent(content: String) {
//        connManager.delegate = self
//        connManager.requestPacket.HTTPMethod = kHTTPMethodPOST
//        connManager.requestPacket.setValue(parameterContentType, forHTTPHeaderField: "Content-Type")
//        connManager.requestPacket.setValue(responseContentType, forHTTPHeaderField: "Accept")
//        connManager.requestPacket.HTTPBody = content.dataUsingEncoding(NSUTF8StringEncoding)
//        connManager.sendRequestWithURL(self.preparePathTradeoffAnalyticsForContent())
//    }
}
