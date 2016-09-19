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

class CollapsibleTableView: UITableView {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var fundsArray : Array<Funds> = Array<Funds>()
    var solutions : NSArray!
    var frontArr : Array<Funds> = Array<Funds>()
    var excludedArr : Array<Funds> = Array<Funds>()
    var incompleteArr : Array<Funds> = Array<Funds>()
    var selectedSection : Int = -1
    var popoverContent : TradePopUpViewController!
    weak var popupDelegate : UIView!

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func populateWithSolution (solutionsArr : NSArray, forFunds fundsArr : Array<Funds>){
        self.dataSource = self
        self.delegate = self
        fundsArray = fundsArr
        solutions = solutionsArr
        
        let podBundle = NSBundle(forClass: self.classForCoder)
        
        if let bundleURL = podBundle.URLForResource("WDCBundle", withExtension: "bundle") {
            if let bundle = NSBundle(URL: bundleURL) {
                popoverContent = TradePopUpViewController(nibName: "TradePopUpViewController", bundle: bundle)
            }else {
                assertionFailure("Could not load the bundle")
            }
        }else {
            assertionFailure("Could not create a path to the bundle")
        }

        for fundsRef in solutions{
            if let dict = fundsRef as? NSDictionary {
                if let statusStr = dict.valueForKey("status") as? NSString,
                    statusRefKey = dict.valueForKey("solution_ref") as? NSString {
                
                    for funds in fundsArr {
                        
                        if statusRefKey.isEqualToString(funds.key!){
                            
                            if statusStr.isEqualToString("FRONT"){
                                frontArr.append(funds)
                                break
                            }
                            else if statusStr.isEqualToString("EXCLUDED"){
                                excludedArr.append(funds)
                                break
                            }
                            else if statusStr.isEqualToString("INCOMPLETE"){
                                incompleteArr.append(funds)
                                break
                            }
                        }
                    }
                }
            }
        }
        
        self.reloadData()
    }
    
    func headerTapped(tapgest : UITapGestureRecognizer){
        let currentSelected = tapgest.view!.tag - 123
        if selectedSection == -1 {
            selectedSection = currentSelected
            self.reloadSections(NSIndexSet(index: selectedSection), withRowAnimation: .Automatic)
        } else if selectedSection == currentSelected{
            selectedSection = -1
            self.reloadSections(NSIndexSet(index: currentSelected), withRowAnimation: .Automatic)
        } else{
            let oldSelected = selectedSection
            selectedSection = currentSelected
            let set : NSMutableIndexSet = NSMutableIndexSet()
            set.addIndex(oldSelected)
            set.addIndex(selectedSection)
            self.reloadSections(set, withRowAnimation: .Automatic)
        }
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************

}

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************

extension CollapsibleTableView: UITableViewDataSource {

//*************************************************
// MARK: - Properties
//*************************************************

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************

//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : UILabel = UILabel(frame: CGRectMake(0, 0, tableView.frame.size.width, 44))
        headerView.backgroundColor = UIColor.grayColor()
        headerView.tag = 123 + section
        headerView.textAlignment = .Center
        headerView.layer.shadowColor = UIColor.blackColor().CGColor
        headerView.layer.shadowOffset = CGSizeMake(0, 2);
        headerView.layer.shadowRadius = 5.0
        headerView.layer.shadowOpacity = 0.7
        headerView.userInteractionEnabled = true
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self,
            action: #selector(CollapsibleTableView.headerTapped(_:))))
        
        switch (section){
        case 0:
            headerView.text = "Included Products (\(frontArr.count) objects)"
        case 1:
            headerView.text = "Excluded Products (\(excludedArr.count) objects)"
        case 2:
            headerView.text = "Incomplete Products (\(incompleteArr.count) objects)"
        default:
            headerView.text = ""
        }
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section){
        case 0:
            if selectedSection == section{
                return frontArr.count
            }
        case 1:
            if selectedSection == section{
                return excludedArr.count
            }
        case 2:
            if selectedSection == section{
                return incompleteArr.count
            }
        default:
            return 0
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("myCell")
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        }
        switch (indexPath.section){
        case 0:
            let funds : Funds = frontArr[indexPath.row]
            cell.textLabel?.text = funds.name
        case 1:
            let funds : Funds = excludedArr[indexPath.row]
            cell.textLabel?.text = funds.name
        case 2:
            let funds : Funds = incompleteArr[indexPath.row]
            cell.textLabel?.text = funds.name
        default:
            NSLog("");
        }
        cell.textLabel?.textAlignment = .Center
        return cell
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************

}

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************

extension CollapsibleTableView: UITableViewDelegate {
//*************************************************
// MARK: - Properties
//*************************************************

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************

//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        popoverContent.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        
        var funds = frontArr[indexPath.row]
        
        switch (indexPath.section){
        case 0:
            funds = frontArr[indexPath.row]
        case 1:
            funds = excludedArr[indexPath.row]
        case 2:
            funds = incompleteArr[indexPath.row]
        default:
            NSLog("");
        }
        
        popoverContent.fund = funds
        let popover = popoverContent.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(400,330)
        
        popover!.sourceView = self
        popover!.sourceRect = CGRectMake(150, 50, 400, 330)
        popupDelegate.parentViewController!.presentViewController(popoverContent,
                                                                  animated: true,
                                                                  completion: nil)
        popoverContent.tblView.reloadData()
        
    }


//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************

}
