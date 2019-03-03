//
//  MenuViewController.swift
//  AutomotiveDSTest
//
//  Created by Juan Armario Munoz on 2019-03-02.
//  Copyright © 2019 Juan Armario Munoz. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate {
    func tapped()
}

class MenuViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties

    var delegate: MenuViewControllerDelegate?
    var auxiliaryView: UIView!
    var button: UIButton!
    var tableView: UITableView!
    var timeStampArray: Array<UILabel>!
    let timeStampNotification = Notification.Name(rawValue: timeStampNotificationKey)

    //MARK: - Initialization

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupMenuViewController()
        createObserver()
    
        self.timeStampArray = Array<UILabel>()
    }
    
    //MARK: - Button method selector

    @objc func buttonClicked(sender : UIButton){
        sender.postNotificationWithName(notificationName: timeStampNotificationKey)
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
    
    //MARK: - Table View DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeStampArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath)
        let timeStampLabel = self.timeStampArray[indexPath.row]
        
        cell.textLabel?.text = timeStampLabel.text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 26/255.0, green: 35/255.0, blue: 126/255.0, alpha: 1.0)
        
        return cell
    }
    
    //MARK: - Auxiliary Methods

    /// Method to configure our ViewController
    func setupMenuViewController() {
        self.view.backgroundColor = UIColor(red: 48/255.0, green: 79/255.0, blue: 254/255.0, alpha: 1.0)
        creatViewWithButtonView()
    }
    
    /// Method to create the view in which add the button and tableView
    func creatViewWithButtonView() {
        self.auxiliaryView = UIView()
        self.auxiliaryView.frame = CGRect(x: self.view.frame.origin.x + 15, y: 88, width: self.view.frame.width/2.25 - 30, height: 281)
        self.auxiliaryView.backgroundColor = UIColor(red: 26/255.0, green: 35/255.0, blue: 126/255.0, alpha: 1.0)
        createButtonIn(view: auxiliaryView)
        createTableViewIn(view: auxiliaryView)
        self.view.addSubview(auxiliaryView)
    }
    
    /// Method to create and configure the button and add it to an specific view
    ///
    /// - Parameter view: View in which add the button
    func createButtonIn(view: UIView) {
        let buttonX = 50
        let buttonY = 0
        let buttonWidth = 46
        let buttonHeight = 30
        
        self.button = UIButton(type: .system)
        self.button.setTitle("Button", for: .normal)
        self.button.tintColor = .white
        self.button.backgroundColor = UIColor(red: 26/255.0, green: 35/255.0, blue: 126/255.0, alpha: 1.0)
        self.button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        
        view.addSubview(button)
    }
    
    /// Method to create and configure the tableView and add it to an specific view
    ///
    /// - Parameter view: View in which add the tableView
    func createTableViewIn(view: UIView) {
        self.tableView = UITableView()
        self.tableView.backgroundColor = UIColor(red: 26/255.0, green: 35/255.0, blue: 126/255.0, alpha: 1.0)
        self.tableView.frame = CGRect(x: 0, y: self.button.frame.height, width: self.auxiliaryView.frame.width, height: self.auxiliaryView.frame.height - self.button.frame.height)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuTableViewCell")
        view.addSubview(tableView)
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
