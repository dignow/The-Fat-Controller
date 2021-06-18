//
//  SettingsVC.swift
//  Remote
//
//  Created by Indiana Kernick on 4/2/21.
//  Copyright © 2021 Indiana Kernick. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController, UITextFieldDelegate, NavigationChild {
    @IBOutlet weak var hostNameField: UITextField!
    @IBOutlet weak var statusCell: UITableViewCell!
    @IBOutlet var statusIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var socket: SocketManager!
    private var online = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = view as! UITableView
        
        let leftView = UIView(frame: CGRect(
            x: 0, y: 0,
            width: tableView.separatorInset.left, height: hostNameField.frame.size.height
        ))
        leftView.backgroundColor = hostNameField.backgroundColor
        hostNameField.leftView = leftView
        hostNameField.leftViewMode = .always
        hostNameField.delegate = self
        
        onlineStatusChanged(online: online)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        onlineStatusChanged(online: online)
        hostNameField.text = UserDefaults.standard.string(forKey: StorageKeys.hostName)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = hostNameField.text {
            UserDefaults.standard.set(text, forKey: StorageKeys.hostName)
            socket.connectTo(host: text)
        }
        view.endEditing(true)
        return true
    }

    func onlineStatusChanged(online: Bool) {
        self.online = online
        if statusCell == nil {
            return
        }
        if online {
            statusLabel.text = "Yes"
            statusIndicator.stopAnimating()
            statusCell.accessoryView = nil
        } else {
            statusLabel.text = ""
            statusIndicator.startAnimating()
            statusCell.accessoryView = statusIndicator
        }
    }
    
    func onlineStatusInitial(online: Bool) {
        self.online = online
    }
    
    func setSocket(_ socket: SocketManager) {
        self.socket = socket
    }
}
