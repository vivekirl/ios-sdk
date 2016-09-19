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
import TradeoffAnalyticsV1

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


class TradeoffInputView: UIView  {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    let dateCellIdentifier = "DateCellIdentifier"
    let contentCellIdentifier = "ContentCellIdentifier"
    
    var arrColumns: [Column]!
    var arrRows: [Option]!
    
    var inputTitleLabel: UILabel!
    var inputCollectionView: UICollectionView!
    let customCollectionViewLayout: CustomCollectionViewLayout = CustomCollectionViewLayout()

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func resetInputView(){
        self.arrColumns = nil
        self.arrRows = nil
    }
    
    func setViews() {
        self.inputTitleLabel = UILabel(frame: CGRectMake(10, 10, 160, 34))
        self.inputTitleLabel.textColor = UIColor.whiteColor()
        self.inputTitleLabel.font = UIFont.boldSystemFontOfSize(22.0)
        self.addSubview(self.inputTitleLabel)
        
        self.inputCollectionView = UICollectionView(frame: CGRect(x:0, y:50, width: self.bounds.width,
            height:self.bounds.height-50), collectionViewLayout: self.customCollectionViewLayout)
        self.inputCollectionView.dataSource = self
        self.inputCollectionView.bounces = true
        self.inputCollectionView.alwaysBounceVertical = true
        self.inputCollectionView.backgroundColor = UIColor.whiteColor()
        self.inputCollectionView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,
                                                UIViewAutoresizing.FlexibleWidth]
        self.inputCollectionView.registerClass(DateCollectionViewCell.self,
                                          forCellWithReuseIdentifier: self.dateCellIdentifier)
        self.inputCollectionView.registerClass(ContentCollectionViewCell.self,
                                          forCellWithReuseIdentifier: self.contentCellIdentifier)
        
        self.addSubview(self.inputCollectionView)
    }
    
    
    func populateInputView(inputTitle: String, columns: [Column], rows: [Option]) {
        Storage.sharedObject().arrColumns = columns
        self.arrColumns = columns
        self.arrRows = rows
        self.setViews()
        self.inputTitleLabel.text = inputTitle
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

extension TradeoffInputView: UICollectionViewDataSource {

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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.arrRows.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
            return self.arrColumns.count
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if let dateCell = collectionView.dequeueReusableCellWithReuseIdentifier(
                    dateCellIdentifier, forIndexPath: indexPath) as? DateCollectionViewCell {
                    dateCell.backgroundColor = UIColor.whiteColor()
                    dateCell.dateLabel.font = UIFont.systemFontOfSize(15)
                    dateCell.dateLabel.textColor = UIColor.whiteColor()
                    dateCell.backgroundColor = UIColor.init(red: 105.0/255.0, green: 105.0/255.0,
                                                            blue: 105.0/255.0, alpha: 105.0/255.0)
                    
                    let aColumn = self.arrColumns[indexPath.row]
                    dateCell.dateLabel.text = aColumn.fullName!
                    
                    return dateCell
                }
            } else {
                if let contentCell = collectionView.dequeueReusableCellWithReuseIdentifier(
                    contentCellIdentifier, forIndexPath: indexPath) as? ContentCollectionViewCell {
                    contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                    contentCell.contentLabel.textColor = UIColor.blackColor()
                    
                    let aColumn = self.arrColumns[indexPath.row]
                    contentCell.contentLabel.text = aColumn.fullName!
                    
                    if indexPath.section % 2 != 0 {
                        contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                    } else {
                        contentCell.backgroundColor = UIColor.whiteColor()
                    }
                    
                    contentCell.backgroundColor = UIColor.init(red: 220.0/255.0, green: 220.0/255.0,
                                                               blue: 220.0/255.0, alpha: 1.0)
                    
                    return contentCell
                }
            }
        } else {
            if indexPath.row == 0 {
                if let dateCell = collectionView.dequeueReusableCellWithReuseIdentifier(
                    dateCellIdentifier, forIndexPath: indexPath) as? DateCollectionViewCell {
                    dateCell.dateLabel.font = UIFont.systemFontOfSize(13)
                    dateCell.dateLabel.textColor = UIColor.blackColor()
                    
                    let aRow = self.arrRows[indexPath.section]
                    dateCell.dateLabel.text = aRow.name!
                    
                    if indexPath.section % 2 != 0 {
                        dateCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                    } else {
                        dateCell.backgroundColor = UIColor.whiteColor()
                    }
                    
                    return dateCell
                }
            } else {
                if let contentCell = collectionView.dequeueReusableCellWithReuseIdentifier(
                    contentCellIdentifier, forIndexPath: indexPath) as? ContentCollectionViewCell {
                    contentCell.contentLabel.font = UIFont.systemFontOfSize(13)
                    contentCell.contentLabel.textColor = UIColor.blackColor()
                    
                    let aRow = self.arrRows[indexPath.section]
                    let rowValues = aRow.values
                    
                    let aColumn = self.arrColumns[indexPath.row]
                    contentCell.contentLabel.text = String(rowValues[aColumn.key]!)
                
                    if indexPath.section % 2 != 0 {
                        contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                    } else {
                        contentCell.backgroundColor = UIColor.whiteColor()
                    }
                    
                    return contentCell
                }
            }
        }
        
        return UICollectionViewCell()
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
// MARK: - Class -
//
//**************************************************************************************************

/**
 This class is responsible for creating the managing collectionViewCell that will be used to display 
 information of the date received from Watson.
*/
public class DateCollectionViewCell: UICollectionViewCell {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    /**
    This property is label whit informations of the date received from watson.
    */
    public let dateLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(0, 0, 91, 40))
        label.text = "Mar-15"
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

//*************************************************
// MARK: - Constructors
//*************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************

    func setupViews() {
        self.addSubview(dateLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-12-[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": dateLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": dateLabel]))
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
// MARK: - Class -
//
//**************************************************************************************************

/**
 This class is responsible for creating the managing collectionViewCell that will be used to display
 information of the content received from Watson.
 */
public class ContentCollectionViewCell: UICollectionViewCell {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    /**
     This property is label whit informations of the content received from watson.
     */
    public let contentLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(0, 0, 256, 40))
        label.text = "Test"
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//*************************************************
// MARK: - Constructors
//*************************************************

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func setupViews() {
        self.addSubview(contentLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-12-[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": contentLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|",
            options: NSLayoutFormatOptions(),
            metrics: nil,
            views: ["v0": contentLabel]))
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************

//*************************************************
// MARK: - Internal Methods
//*************************************************
    
}
