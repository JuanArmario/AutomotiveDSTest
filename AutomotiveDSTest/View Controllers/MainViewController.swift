//
//  ViewController.swift
//  AutomotiveDSTest
//
//  Created by Juan Armario Munoz on 2019-03-02.
//  Copyright © 2019 Juan Armario Munoz. All rights reserved.
//

import UIKit

let timeStampNotificationKey = "timeStampNotification"

class MainViewController: UIViewController, SideMenuDelegate, UITableViewDelegate, UITableViewDataSource {

    //MARK: - IBOutlets

    @IBOutlet weak var auxiliaryView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var popUpViewContainer: UIView!
    @IBOutlet weak var popUpView: PopUpView!
    
    //MARK: - Properties

    var timeStampArray: Array<UILabel>!
    let timeStampNotification = Notification.Name(rawValue: timeStampNotificationKey)
    
    //MARK: - Initialization
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.green
        self.auxiliaryView.backgroundColor = UIColor(red: 98/255.0, green: 167/255.0, blue: 54/255.0, alpha: 1.0)
        self.tableView.backgroundColor = UIColor(red: 98/255.0, green: 167/255.0, blue: 54/255.0, alpha: 1.0)
        self.popUpViewContainer.backgroundColor = .orange

        createObserver()
        self.timeStampArray = Array<UILabel>()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - IBActions

    @IBAction func notificationButtonPressed(_ sender: UIButton) {
        sender.postNotificationWithName(notificationName: timeStampNotificationKey)
    }
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        SideMenu(delegate: self).openSideMenu()
    }
    
    //MARK: - Notification Observer Methods
    
    /// Method to create a notification observer
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.printTimeStamp(notification:)), name: self.timeStampNotification, object: nil)
    }
    
    /// Method to manage the notification
    ///
    /// - Parameter notification: notification received
    @objc func printTimeStamp(notification: NSNotification) {
        createALabelWithTimeStamp()
        self.tableView.reloadData()
    }
    
    //MARK: - Table View DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.timeStampArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let timeStampLabel = self.timeStampArray[indexPath.row]
        
        cell.textLabel?.text = timeStampLabel.text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 98/255.0, green: 167/255.0, blue: 54/255.0, alpha: 1.0)
        
        return cell
    }
    
    //MARK: - SideMenu Delegate
    
    /// Method to executed when Side Menu has been opened
    func sideMenuDidOpen() {
        
    }
    
    /// Method to executed when Side Menu has been closed
    func sideMenuDidClose() {
        
    }
    
    //MARK: - Auxiliary Methods
    
    /// Method to create a label with a time stamp inside
    func createALabelWithTimeStamp() {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: self.tableView.contentSize.height, width: self.tableView.frame.width, height: 30)
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        
        label.text = dateString
        label.font = label.font.withSize(15)
        
        label.tintColor = .white
        label.textColor = .white
        
        self.timeStampArray.append(label)
    }
}
