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

class TradePopUpViewController: UIViewController {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    @IBOutlet weak var tblView : UITableView!
    var strArray: Array<String> = Array<String>()
    
    var fund : Funds!

//*************************************************
// MARK: - Constructors
//*************************************************

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

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        strArray.removeAll()
        strArray.append("\(fund.name!)")
        strArray.append("\(managerTenureKey) : \(fund.managerTenure!)")
        strArray.append("\(ytdKey) : \(fund.YTD!)")
        strArray.append("\(shortTermKey) : \(fund.shortTerm!)")
        strArray.append("\(midTermKey) : \(fund.midTerm!)")
        strArray.append("\(assetsKey) : \(fund.assets!)")
        strArray.append("\(netExpenseKey) : \(fund.netExpense!)")
        strArray.append("\(personalityKey) : \(fund.personality!)")
        strArray.append("\(riskKey) :\(fund.risk!)")
        strArray.append("\(longTermKey) :\(fund.longTerm!)")
        strArray.append("\(morningStarRatingKey) :\(fund.morningstarRating!)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
}


//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************

extension TradePopUpViewController: UITableViewDataSource {
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("myCell")
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: "myCell")
        }
        cell.textLabel?.text = strArray[indexPath.row]
        
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