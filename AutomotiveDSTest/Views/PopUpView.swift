//
//  PopUpView.swift
//  AutomotiveDSTest
//
//  Created by Juan Armario Munoz on 2019-03-03.
//  Copyright © 2019 Juan Armario Munoz. All rights reserved.
//

import UIKit

class PopUpView: UIView, UITableViewDelegate, UITableViewDataSource {
    let kCONTENT_XIB_NAME = "PopUpView"

    //MARK: - IBOutlets

    @IBOutlet var contentView: UIView!
    @IBOutlet var button: UIButton!
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Properties
    
    var timeStampArray: Array<UILabel>!
    let timeStampNotification = Notification.Name(rawValue: timeStampNotificationKey)
    
    //MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPopUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPopUpView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Notification Observer Methods
    
    /// Method to create a notification observer
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(MenuViewController.printTimeStamp(notification:)), name: timeStampNotification, object: nil)
    }
    
    /// Method to manage the notification
    ///
    /// - Parameter notification: notification received
    @objc func printTimeStamp(notification: NSNotification) {
        createALabelWithTimeStamp()
        tableView.reloadData()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.postNotificationWithName(notificationName: timeStampNotificationKey)
    }
    
    //MARK: - Table View DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeStampArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popUpTableViewCell", for: indexPath)
        let timeStampLabel = self.timeStampArray[indexPath.row]
        
        cell.textLabel?.text = timeStampLabel.text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 255/255.0, green: 102/255.0, blue: 0/255.0, alpha: 1.0)
        
        return cell
    }
    
    //MARK: - Auxiliary Methods
    
    /// Method to configure the popUpView
    func setupPopUpView() {
        self.backgroundColor = UIColor(red: 255/255.0, green: 152/255.0, blue: 0/255.0, alpha: 1.0)
        self.timeStampArray = Array<UILabel>()
        createObserver()
        contentView = loadNib()
        contentView.frame = bounds
        addSubview(contentView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "popUpTableViewCell")
    }
    
    /// Method to create a label with a time stamp inside
    func createALabelWithTimeStamp() {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 50, width: 40, height: 30)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        label.text = dateString
        label.font = label.font.withSize(15)
        label.tintColor = .white
        label.textColor = .white
        
        timeStampArray.append(label)
    }
}
