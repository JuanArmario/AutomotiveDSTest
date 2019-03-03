//
//  SideMenu.swift
//  AutomotiveDSTest
//
//  Created by Juan Armario Munoz on 2019-03-02.
//  Copyright © 2019 Juan Armario Munoz. All rights reserved.
//

import Foundation
import UIKit

protocol SideMenuDelegate {
    func sideMenuDidOpen()
    func sideMenuDidClose()
}

class SideMenu: NSObject {
    
    //MARK: - Properties

    var view: UIView?
    var delegate: SideMenuDelegate?
    var viewController: MenuViewController?
    
    //MARK: - Initialization

    init(delegate: SideMenuDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    /// Method to open the side menu
    func openSideMenu() {
        let bounds = UIScreen.main.bounds
        view = UIView(frame: CGRect(x: -bounds.width, y: 0, width: bounds.width, height: bounds.height))
        viewController = MenuViewController()
        
        if let view = self.view {
            view.addSubview(viewController!.view)
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
            UIApplication.shared.keyWindow?.addSubview(view)
        }

        if let viewController = self.viewController {
            viewController.delegate = self
        }
        openAnimation()
    }
    
    /// Method to close the side menu
    func closeSideMenu() {
        closeAnimation()
    }
    
    /// Method to handler gestures and execute some action
    ///
    /// - Parameter sender: Type of gesture to recongnize
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer) {
        closeSideMenu()
    }
    
    //MARK: - Auxiliary Methods
    
    /// Method to execute an animation when side menu is opened
    fileprivate func openAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.view?.frame = CGRect(x: 0, y: 0, width: self.view!.frame.width/2, height: self.view!.frame.height)
            self.view?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: {completed in
            self.delegate?.sideMenuDidOpen()
        })
    }
    
    /// Method to execute an animation when side menu is closed
    fileprivate func closeAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            if let view = self.view {
                view.frame = CGRect(x: -view.frame.width, y: 0, width: view.frame.width/2, height: view.frame.height)
                self.view?.backgroundColor = .clear
            }
        }, completion: {completed in
            self.view?.removeFromSuperview()
            self.view = nil
            self.viewController = nil
            self.delegate?.sideMenuDidClose()
        })
    }
}

extension SideMenu: MenuViewControllerDelegate{
    func tapped() {
        closeSideMenu()
    }
}
