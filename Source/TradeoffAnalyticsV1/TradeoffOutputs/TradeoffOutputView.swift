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

let managerTenureColor = UIColor.redColor()
let YTDColor = UIColor(red: 30.0/255.0, green: 144.0/255.0, blue: 255.00/255.0, alpha: 0.9)
let shortTermColor = UIColor(red: 64.0/255.0, green: 224.0/255.0, blue: 208/255.0, alpha: 1.0)
let midTermColor = UIColor(red: 50.0/255.0, green: 205.0/255.0, blue: 50.0/255.0, alpha: 1.0)
let assetsColor = UIColor.orangeColor()
let netExpenseColor = UIColor.brownColor()
let personalityColor = UIColor(red: 210.0/255.0, green: 105.0/255.0, blue: 30.0/255.0, alpha: 1.0)
let riskColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let longTermColor = UIColor(red: 139.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
let morningstarRatingColor = UIColor.grayColor()

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Extensions -
//
//**************************************************************************************************

extension UIView {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

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

}

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class TradeoffOutputView: UIView {
    
//*************************************************
// MARK: - Properties
//*************************************************

    var polygonView: PolygonView!
    var popoverContent : TradePopUpViewController!
    var fundsArr : Array <Funds> = Array<Funds> ()
    var maxManagerTenure : Int? = Int(INT16_MIN)
    var maxYTD : Float? = Float(INT16_MIN)
    var maxShortTerm : Float? = Float(INT16_MIN)
    var maxMidTerm : Float? = Float(INT16_MIN)
    var maxAssets : Float? = Float(INT16_MIN)
    var maxNetExpense : Float? = Float(INT16_MIN)
    var maxPersonality : Float? = Float(INT16_MIN)
    var maxRisk : Float? = Float(INT16_MIN)
    var maxLongTerm : Float? = Float(INT16_MIN)
    var maxMorningstarRating : Int? = Int(INT16_MIN)
    
    var minManagerTenure : Int? = Int(INT_MAX)
    var minYTD : Float? = Float(INT64_MAX)
    var minShortTerm : Float? = Float(INT64_MAX)
    var minMidTerm : Float? = Float(INT64_MAX)
    var minAssets : Float? = Float(INT64_MAX)
    var minNetExpense : Float? = Float(INT64_MAX)
    var minPersonality : Float? = Float(INT64_MAX)
    var minRisk : Float? = Float(INT64_MAX)
    var minLongTerm : Float? = Float(INT64_MAX)
    var minMorningstarRating : Int? = Int(INT_MAX)
    
    
    var currmaxManagerTenure : Int? = Int(INT16_MIN)
    var currmaxYTD : Float? = Float(INT16_MIN)
    var currmaxShortTerm : Float? = Float(INT16_MIN)
    var currmaxMidTerm : Float? = Float(INT16_MIN)
    var currmaxAssets : Float? = Float(INT16_MIN)
    var currmaxNetExpense : Float? = Float(INT16_MIN)
    var currmaxPersonality : Float? = Float(INT16_MIN)
    var currmaxRisk : Float? = Float(INT16_MIN)
    var currmaxLongTerm : Float? = Float(INT16_MIN)
    var currmaxMorningstarRating : Int? = Int(INT16_MIN)
    
    var currminManagerTenure : Int? = Int(INT_MAX)
    var currminYTD : Float? = Float(INT64_MAX)
    var currminShortTerm : Float? = Float(INT64_MAX)
    var currminMidTerm : Float? = Float(INT64_MAX)
    var currminAssets : Float? = Float(INT64_MAX)
    var currminNetExpense : Float? = Float(INT64_MAX)
    var currminPersonality : Float? = Float(INT64_MAX)
    var currminRisk : Float? = Float(INT64_MAX)
    var currminLongTerm : Float? = Float(INT64_MAX)
    var currminMorningstarRating : Int? = Int(INT_MAX)
    
    var isManagerTenure : Bool = false
    var isYTD : Bool = false
    var isShortTerm : Bool = false
    var isMidTerm : Bool = false
    var isAssets : Bool = false
    var isNetExpense : Bool = false
    var isPersonality : Bool = false
    var isRisk : Bool = false
    var isLongTerm : Bool = false
    var isMorningstarRating : Bool = false
    
    var collapsibleTableView : CollapsibleTableView!
    var bgView : UIView!
    var filterScrollView : FilterScrollView = FilterScrollView()
    
    var nodesArrayGlobal : NSArray!

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

    func getImageWithName(name: String) -> UIImage {
        var image: UIImage = UIImage()
        let podBundle = NSBundle(forClass: self.classForCoder)
        if let bundleURL = podBundle.URLForResource("WDCImages", withExtension: "bundle") {
            if let bundle = NSBundle(URL: bundleURL) {
                let imagePath = bundle.pathForResource(name, ofType: "")
                if imagePath != nil {
                    image = UIImage(contentsOfFile: imagePath!)!
                }
            }else {
                assertionFailure("Could not load the bundle")
            }
        }else {
            assertionFailure("Could not create a path to the bundle")
        }
        return image
    }
    
    func createFund(dict: NSDictionary) {
        let fund : Funds = Funds(dictionary: dict)
        self.fundsArr.append(fund)
        if self.maxAssets < fund.assets{
            self.maxAssets = fund.assets!
        }
        if self.maxManagerTenure < fund.managerTenure{
            self.maxManagerTenure = fund.managerTenure!
        }
        if self.maxYTD < fund.YTD{
            self.maxYTD = fund.YTD!
        }
        if self.maxShortTerm < fund.shortTerm{
            self.maxShortTerm = fund.shortTerm!
        }
        if self.maxMidTerm < fund.midTerm{
            self.maxMidTerm = fund.midTerm!
        }
        if self.maxNetExpense < fund.netExpense{
            self.maxNetExpense = fund.netExpense!
        }
        if self.maxPersonality < fund.personality{
            self.maxPersonality = fund.personality!
        }
        if self.maxRisk < fund.risk{
            self.maxRisk = fund.risk!
        }
        if self.maxLongTerm < fund.longTerm{
            self.maxLongTerm = fund.longTerm!
        }
        if self.maxMorningstarRating < fund.morningstarRating{
            self.maxMorningstarRating = fund.morningstarRating!
        }
        
        if self.minAssets > fund.assets{
            self.minAssets = fund.assets!
        }
        if self.minManagerTenure > fund.managerTenure{
            self.minManagerTenure = fund.managerTenure!
        }
        if self.minYTD > fund.YTD{
            self.minYTD = fund.YTD!
        }
        if self.minShortTerm > fund.shortTerm{
            self.minShortTerm = fund.shortTerm!
        }
        if self.minMidTerm > fund.midTerm{
            self.minMidTerm = fund.midTerm!
        }
        if self.minNetExpense > fund.netExpense{
            self.minNetExpense = fund.netExpense!
        }
        if self.minPersonality > fund.personality{
            self.minPersonality = fund.personality!
        }
        if self.minRisk > fund.risk{
            self.minRisk = fund.risk!
        }
        if self.minLongTerm > fund.longTerm{
            self.minLongTerm = fund.longTerm!
        }
        if self.minMorningstarRating > fund.morningstarRating{
            self.minMorningstarRating = fund.morningstarRating!
        }
    }
    func createTableView(solutionArr : NSArray, forFunds fundsArr : Array<Funds>){
        bgView = UIView(frame: CGRect(x: self.frame.size.width - 25, y: 0, width: 300,
            height: self.frame.size.height))
        
        collapsibleTableView = CollapsibleTableView(frame: CGRect(x: 20, y: 0, width: 300,
            height: self.frame.size.height + 50))
        collapsibleTableView.popupDelegate = self
        collapsibleTableView.populateWithSolution(solutionArr, forFunds:fundsArr)
        bgView.layer.shadowColor = UIColor.blackColor().CGColor
        bgView.layer.shadowOffset = CGSizeMake(0, 2);
        bgView.layer.shadowRadius = 5.0
        bgView.layer.shadowOpacity = 0.7
        
        let btn = UIButton(type: .Custom)
        
        btn.setImage(self.getImageWithName("btn_blueArrow_slideMore.png"), forState: .Normal)
        btn.setImage(self.getImageWithName("btn_blueArrow_slideLess.png"), forState: .Selected)
        btn.addTarget(self, action: #selector(TradeoffOutputView.buttonTapped(_:)),
                      forControlEvents: .TouchUpInside)
        btn.frame = CGRect(x: 0, y: (bgView.frame.size.height/2) - 21, width: 20, height: 42);
        bgView.addSubview(btn)
        collapsibleTableView.clipsToBounds = false
        bgView.clipsToBounds = false
        bgView.addSubview(collapsibleTableView)
        self.addSubview(bgView)
        self.bringSubviewToFront(bgView)
    }
    func checkForArray (nodesArr : NSArray){
        for nodesDict in nodesArr{
            let myPieChartView: PieChartView!
            if let dictTemp = nodesDict as? NSDictionary,
                refArr = dictTemp.valueForKey("solution_refs") as? NSArray {
                if let tagValue = refArr.objectAtIndex(0) as? NSString {
                    let tag = tagValue.integerValue + 12345
                    if let aview = polygonView.viewWithTag(tag) as? PieChartView {
                        myPieChartView = aview
                        let fund = fundsArr[myPieChartView.tag - 12346]
                        if checkFundLiesWithinRange(fund){
                            myPieChartView.alpha = 1.0
                            myPieChartView.userInteractionEnabled = true
                        } else {
                            myPieChartView.alpha = 0.3
                            myPieChartView.userInteractionEnabled = false
                        }
                    }
                }
            }
        }
    }
    func computeInvolvedFilters(columnArr : NSArray){
        isManagerTenure = false
        isYTD = false
        isShortTerm = false
        isMidTerm = false
        isAssets = false
        isNetExpense = false
        isPersonality = false
        isRisk = false
        isLongTerm = false
        isMorningstarRating = false
        for dict in columnArr {
            if let isObjectiveTemp = dict["is_objective"] as? NSNumber {
                if isObjectiveTemp.boolValue {
                    if let value = dict["key"] as? NSString {
                        if value.isEqualToString(managerTenureKey) {
                            self.isManagerTenure = true
                        }
                        if value.isEqualToString(ytdKey) {
                            self.isYTD = true
                        }
                        if value.isEqualToString(shortTermKey) {
                            self.isShortTerm = true
                        }
                        if value.isEqualToString(midTermKey) {
                            self.isMidTerm = true
                        }
                        if value.isEqualToString(longTermKey) {
                            self.isLongTerm = true
                        }
                        if value.isEqualToString(assetsKey) {
                            self.isAssets = true
                        }
                        if value.isEqualToString(netExpenseKey) {
                            self.isNetExpense = true
                        }
                        if value.isEqualToString(riskKey) {
                            self.isRisk = true
                        }
                        if value.isEqualToString(personalityKey) {
                            self.isPersonality = true
                        }
                        if value.isEqualToString(morningStarRatingKey) {
                            self.isMorningstarRating = true
                        }
                    }
                }
            }
        }
        self.createFilterView(columnArr)
    }
    
    func createFilterView(columnArr : NSArray){
        var filterColumnArr : Array<FilterUIColumns> = Array<FilterUIColumns>()
        for dict in columnArr{
            if let dictTemp = dict as? NSDictionary {
                if let isObjectiveTemp = dictTemp["is_objective"] as? NSNumber {
                    if isObjectiveTemp.boolValue {
                        let filterUIColumn = FilterUIColumns(dictionary: dictTemp)
                        if filterUIColumn.isObjective{
                            if (filterUIColumn.key! as NSString).isEqualToString(managerTenureKey) {
                                filterUIColumn.minValue = Float(minManagerTenure!)
                                filterUIColumn.maxValue = Float(maxManagerTenure!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(ytdKey) {
                                filterUIColumn.minValue = Float(minYTD!)
                                filterUIColumn.maxValue = Float(maxYTD!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(shortTermKey) {
                                filterUIColumn.minValue = Float(minShortTerm!)
                                filterUIColumn.maxValue = Float(maxShortTerm!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(midTermKey) {
                                filterUIColumn.minValue = Float(minMidTerm!)
                                filterUIColumn.maxValue = Float(maxMidTerm!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(longTermKey) {
                                filterUIColumn.minValue = Float(minLongTerm!)
                                filterUIColumn.maxValue = Float(maxLongTerm!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(assetsKey) {
                                filterUIColumn.minValue = Float(minAssets!)
                                filterUIColumn.maxValue = Float(maxAssets!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(netExpenseKey) {
                                filterUIColumn.minValue = Float(minNetExpense!)
                                filterUIColumn.maxValue = Float(maxNetExpense!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(riskKey) {
                                filterUIColumn.minValue = Float(minRisk!)
                                filterUIColumn.maxValue = Float(maxRisk!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(personalityKey) {
                                filterUIColumn.minValue = Float(minPersonality!)
                                filterUIColumn.maxValue = Float(maxPersonality!)
                            }
                            if (filterUIColumn.key! as NSString).isEqualToString(morningStarRatingKey){
                                filterUIColumn.minValue = Float(minMorningstarRating!)
                                filterUIColumn.maxValue = Float(maxMorningstarRating!)
                            }
                            filterColumnArr.append(filterUIColumn)
                        }
                    }
                }
            }
        }
        filterScrollView.viewController = self
        filterScrollView.populateWithFilters(filterColumnArr)
        filterScrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 100)
        self.addSubview(filterScrollView)
    }
    func viewTapped(tapGest : UITapGestureRecognizer){
        buttonTapped(nil)
    }
    func buttonTapped(sender : UIButton?){
        if sender == nil{
            UIView.animateWithDuration(0.3, animations: {
                self.bgView.frame = CGRect(x: self.frame.size.width - 20, y: 0, width: 300,
                    height: self.frame.size.height)
            })
            return
        }
        sender!.selected = !sender!.selected
        if sender!.selected {
            UIView.animateWithDuration(0.3, animations: {
                self.bgView.frame = CGRect(x: self.frame.size.width - 320, y: 0, width: 300,
                    height: self.frame.size.height)
            })
        } else {
            UIView.animateWithDuration(0.3, animations: {
                self.bgView.frame = CGRect(x: self.frame.size.width - 20, y: 0, width: 300,
                    height: self.frame.size.height)
            })
        }
    }
    func addPieChartFor(nodesArr : NSArray, forAnchorArr anchorArr : NSArray){
        var xMax : CGFloat = 0.0
        var yMax : CGFloat = 0.0
        for dict in anchorArr{
            if let positionDict = dict["position"] as? NSDictionary {
                if let xvalue = positionDict.valueForKey("x") as? NSNumber {
                    let xval = CGFloat(xvalue.floatValue)
                    if xval > xMax {
                        xMax = xval
                    }
                }
                if let yvalue = positionDict.valueForKey("y") as? NSNumber {
                    let yval = CGFloat(yvalue.floatValue)
                    if yval > yMax {
                        yMax = yval
                    }
                }
            }
        }
        for nodesDict in nodesArr{
            if let dictTemp = nodesDict as? NSDictionary {
                if let positionDict = dictTemp.valueForKey("coordinates") as? NSDictionary {
                    if let xvalue = positionDict.valueForKey("x") as? NSNumber,
                        yvalue = positionDict.valueForKey("y") as? NSNumber,
                        solutionRefs = dictTemp.valueForKey("solution_refs") as? NSArray {
                        let xval = CGFloat(xvalue.floatValue)
                        let yval = CGFloat(yvalue.floatValue)
                        let size = self.polygonView.frame.size
                        let a = CGPoint (x: (((size.width - 40) / xMax) * xval) + 20,
                                         y: (((size.height - 40) / yMax) * yval) + 20)
                        if let stringTag = solutionRefs.objectAtIndex(0) as? NSString {
                            let tag = stringTag.integerValue + 12345
                            self.createPieChartView(a, withTag: tag)
                        }
                    }
                }
            }
        }
    }
    func createPieChartView(point: CGPoint, withTag tag: NSInteger) {
        let myPieChartView: PieChartView! = PieChartView(frame: CGRect(x: point.x, y: point.y,
            width: 30, height: 30))
        self.polygonView.addSubview(myPieChartView)
        let selector = #selector(TradeoffOutputView.pieTapped(_:))
        myPieChartView.addGestureRecognizer(UITapGestureRecognizer (target: self, action: selector))
        myPieChartView.centerGraph()
        myPieChartView.dataSource = self
        myPieChartView.dataSource1 = self
        myPieChartView.radius = 15
        myPieChartView.legendOffSet = 0
        myPieChartView.legendSize = 0
        myPieChartView.legendFontSize = 0
        myPieChartView.legendFontName = "Verdana"
        myPieChartView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        myPieChartView.layer.borderColor = UIColor.darkGrayColor().CGColor
        myPieChartView.layer.borderWidth = 1.0
        myPieChartView.layer.cornerRadius = 15.0;
        myPieChartView.clipsToBounds = true
        myPieChartView.tag = tag//(refArr.objectAtIndex(0) as! NSString).integerValue + 12345
    }
    func checkFundLiesWithinRange (fund : Funds) -> Bool {
        if isManagerTenure {
            if fund.managerTenure < currminManagerTenure ||
                fund.managerTenure > currmaxManagerTenure {
                return false
            }
        }
        if isYTD {
            if fund.YTD < currminYTD || fund.YTD > currmaxYTD{
                return false
            }
        }
        if isShortTerm {
            if fund.shortTerm < currminShortTerm || fund.shortTerm > currmaxShortTerm {
                return false
            }
        }
        if isMidTerm {
            if fund.midTerm < currminMidTerm || fund.midTerm > currmaxMidTerm {
                return false
            }
        }
        if isAssets {
            if fund.assets < currminAssets || fund.assets > currmaxAssets {
                return false
            }
        }
        if isNetExpense {
            if fund.netExpense < currminNetExpense || fund.netExpense > currmaxNetExpense {
                return false
            }
        }
        if isPersonality {
            if fund.personality < currminPersonality || fund.personality > currmaxPersonality {
                return false
            }
        }
        if isRisk {
            if fund.risk < currminRisk || fund.risk > currmaxRisk {
                return false
            }
        }
        if isLongTerm {
            if fund.longTerm < currminLongTerm || fund.longTerm > currmaxLongTerm {
                return false
            }
        }
        if isMorningstarRating {
            if fund.morningstarRating < currminMorningstarRating
                || fund.morningstarRating > currmaxMorningstarRating{
                return false
            }
        }
        return true
    }
    func pieTapped (gest : UITapGestureRecognizer){
        popoverContent.modalPresentationStyle = UIModalPresentationStyle.Popover
        let tag : Int = gest.view!.tag - 12346
        let fund = fundsArr[tag]
        popoverContent.fund = fund
        let popover = popoverContent.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: 300, height: 330)
        popover!.sourceView = self
        popover!.sourceRect = self.convertRect(gest.view!.frame, fromView: polygonView)
        self.parentViewController!.presentViewController(popoverContent,
                                                         animated: true, completion: nil)
        popoverContent.tblView.reloadData()
    }
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
}

extension TradeoffOutputView {
//*************************************************
// MARK: - Properties
//*************************************************

//**************************************************
// MARK: - Constructors
//**************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************

//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func populateOutputView(response: AnyObject) {
        var rect = self.bounds
        rect.origin.x += 50
        rect.origin.y += 150
        rect.size.width -= 100
        rect.size.height -= 200
        polygonView = PolygonView(frame: rect)
        polygonView.hidden = false
        polygonView.backgroundColor = UIColor.clearColor()
        self.addSubview(polygonView)
        let podBundle = NSBundle(forClass: self.classForCoder)
        if let bundleURL = podBundle.URLForResource("WDCBundle", withExtension: "bundle") {
            if let bundle = NSBundle(URL: bundleURL) {
                popoverContent = TradePopUpViewController(nibName: "TradePopUpViewController",
                                                          bundle: bundle)
            } else {
                assertionFailure("Could not load the bundle")
            }
        }else {
            assertionFailure("Could not create a path to the bundle")
        }
        
        if let anchorArr = response.valueForKeyPath("resolution.map.anchors") as? NSArray {
            self.polygonView.calculatePolygonArray(anchorArr)
            if let nodesArr = response.valueForKeyPath("resolution.map.nodes") as? NSArray {
                self.nodesArrayGlobal = nodesArr
                self.addPieChartFor(nodesArr, forAnchorArr: anchorArr)
            }
        }
        if let fundsArrJSON = response.valueForKeyPath("problem.options") as? NSArray {
            for funds in fundsArrJSON{
                if let dict = funds as? NSDictionary {
                    self.createFund(dict)
                }
            }
        }
        
        self.currmaxManagerTenure = self.maxManagerTenure
        self.currmaxYTD = self.maxYTD
        self.currmaxShortTerm = self.maxShortTerm
        self.currmaxMidTerm = self.maxMidTerm
        self.currmaxAssets = self.maxAssets
        self.currmaxNetExpense = self.maxNetExpense
        self.currmaxPersonality = self.maxPersonality
        self.currmaxRisk = self.maxRisk
        self.currmaxLongTerm  = self.maxLongTerm
        self.currmaxMorningstarRating = self.maxMorningstarRating
        
        
        self.currminManagerTenure = self.minManagerTenure
        self.currminYTD = self.minYTD
        self.currminShortTerm = self.minShortTerm
        self.currminMidTerm = self.minMidTerm
        self.currminAssets = self.minAssets
        self.currminNetExpense = self.minNetExpense
        self.currminPersonality = self.minPersonality
        self.currminRisk = self.minRisk
        self.currminLongTerm  = self.minLongTerm
        self.currminMorningstarRating = self.minMorningstarRating
        
        
        if let columnArr = response.valueForKeyPath("problem.columns") as? NSArray {
            self.computeInvolvedFilters(columnArr)
        }
        
        if let solutionArr = response.valueForKeyPath("resolution.solutions") as? NSArray {
            self.createTableView(solutionArr, forFunds: self.fundsArr)
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

extension TradeoffOutputView: TwoWaySliderDelegate {
    
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
    
    func sliderChangedForKey(key : String, leftVal : CGFloat, rightVal : CGFloat){
        if (key as NSString).isEqualToString(managerTenureKey){
            self.currmaxManagerTenure = Int(rightVal)
            self.currminManagerTenure = Int(leftVal)
        }
        if (key as NSString).isEqualToString(ytdKey){
            self.currminYTD = Float(leftVal)
            self.currmaxYTD = Float(rightVal)
        }
        if (key as NSString).isEqualToString(shortTermKey){
            self.currminShortTerm = Float(leftVal)
            self.currmaxShortTerm = Float(rightVal)
        }
        if (key as NSString).isEqualToString(midTermKey){
            self.currminMidTerm = Float(leftVal)
            self.currmaxMidTerm = Float(rightVal)
        }
        if (key as NSString).isEqualToString(longTermKey){
            self.currminLongTerm = Float(leftVal)
            self.currmaxLongTerm = Float(rightVal)
        }
        if (key as NSString).isEqualToString(assetsKey){
            self.currminAssets = Float(leftVal)
            self.currmaxAssets = Float(rightVal)
        }
        if (key as NSString).isEqualToString(netExpenseKey){
            self.currminNetExpense = Float(leftVal)
            self.currmaxNetExpense = Float(rightVal)
        }
        if (key as NSString).isEqualToString(riskKey){
            self.currminRisk = Float(leftVal)
            self.currmaxRisk = Float(rightVal)
        }
        if (key as NSString).isEqualToString(personalityKey){
            self.currminPersonality = Float(leftVal)
            self.currmaxPersonality = Float(rightVal)
        }
        if (key as NSString).isEqualToString(morningStarRatingKey){
            self.currminMorningstarRating = Int(leftVal)
            self.currmaxMorningstarRating = Int(rightVal)
        }
        self.checkForArray(self.nodesArrayGlobal)
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************

}

extension TradeoffOutputView: PieChartDataSource {
    
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
    
    
    func dataForPie() -> [PieChartDataItem] {
        return  []
    }
    
    func dataForPie(chart: PieChartView) -> [PieChartDataItem] {
        var pieChartItems: [PieChartDataItem] = []
        
        
        let tag : Int = chart.tag - 12346
        let fund = fundsArr[tag]
        
        
        if isYTD {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: YTDColor,
                                        description: "Microsoft : $1500")
            pie1.radius = CGFloat((fund.YTD!/(maxYTD! - minYTD!)) * 20)
            
            pieChartItems.append(pie1)
        }
        
        if isManagerTenure {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: managerTenureColor,
                                        description: "Microsoft : $1500")
            let num = (fund.managerTenure! - minManagerTenure!)
            pie1.radius = CGFloat((num/(maxManagerTenure! - minManagerTenure!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isShortTerm {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: shortTermColor,
                                        description: "Microsoft : $1500")
            let num = (fund.shortTerm! - minShortTerm!)
            pie1.radius = CGFloat((num/(maxShortTerm! - minShortTerm!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isMidTerm {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: midTermColor,
                                        description: "Microsoft : $1500")
            pie1.radius = CGFloat(((fund.midTerm! - minMidTerm!)/(maxMidTerm! - minMidTerm!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isAssets {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: assetsColor,
                                        description: "Microsoft : $1500")
            pie1.radius = CGFloat(((fund.assets! - minAssets!)/(maxAssets! - minAssets!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isNetExpense {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: netExpenseColor,
                                        description: "Microsoft : $1500")
            let num = (fund.netExpense! - minNetExpense!)
            pie1.radius = CGFloat((num/(maxNetExpense! - minNetExpense!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isPersonality {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: personalityColor,
                                        description: "Microsoft : $1500")
            let num = (fund.personality! - minPersonality!)
            pie1.radius = CGFloat((num/(maxPersonality! - minPersonality!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isRisk {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: riskColor,
                                        description: "Microsoft : $1500")
            pie1.radius = CGFloat(((fund.risk! - minRisk!)/(maxRisk! - minRisk!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isLongTerm {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: longTermColor,
                                        description: "Microsoft : $1500")
            let num = (fund.longTerm! - minLongTerm!)
            pie1.radius = CGFloat((num/(maxLongTerm! - minLongTerm!)) * 20)
            
            pieChartItems.append(pie1)
        }
        if isMorningstarRating {
            let pie1 = PieChartDataItem(value: CGFloat(20), color: morningstarRatingColor,
                                        description: "Microsoft : $1500")
            let num = (fund.morningstarRating! - minMorningstarRating!)
            pie1.radius = CGFloat((num/(maxMorningstarRating! - minMorningstarRating!)) * 20)
            
            pieChartItems.append(pie1)
        }
        
        return pieChartItems
    }
    func showLegend() -> Bool {
        return false
    }
    func showPercentage() ->Bool{
        return false
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************
}
