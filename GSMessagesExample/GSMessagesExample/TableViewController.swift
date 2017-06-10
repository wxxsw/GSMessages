//
//  TableViewController.swift
//  GSMessagesExample
//
//  Created by GeSen on 2017/6/10.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Important: Used in UITableViewController, you must add this in viewWillDisappear or viewDidDisappear.
        hideMessage()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        
        switch indexPath.row {
        case 0:  cell.textLabel?.text = "Success"
        case 1:  cell.textLabel?.text = "Error"
        case 2:  cell.textLabel?.text = "Warning"
        case 3:  cell.textLabel?.text = "Info"
        case 4:  cell.textLabel?.text = "Endless"
        case 5:  cell.textLabel?.text = "Dismiss"
        case 6:  cell.textLabel?.text = "Fade"
        case 7:  cell.textLabel?.text = "Long Time"
        case 8:  cell.textLabel?.text = "Height"
        case 9:  cell.textLabel?.text = "Left"
        case 10: cell.textLabel?.text = "Center"
        case 11: cell.textLabel?.text = "Right"
        case 12: cell.textLabel?.text = "Long Text"
        case 13: cell.textLabel?.text = "Bottom"
        case 14: cell.textLabel?.text = "Toggle NavBar Translucent"
        case 15: cell.textLabel?.text = "Toggle NavBar Hidden"
        default: break
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showMessage("Something success", type: .success)
        case 1:
            showMessage("Something failed", type: .error)
        case 2:
            showMessage("Some warning", type: .warning)
        case 3:
            showMessage("Some message", type: .info)
        case 4:
            showMessage("Endless", type: .success, options: [.autoHide(false), .hideOnTap(false)])
        case 5:
            hideMessage()
        case 6:
            showMessage("Fade", type: .success, options: [.animation(.fade)])
        case 7:
            showMessage("Long Time", type: .success, options: [.autoHideDelay(10)])
        case 8:
            showMessage("Height", type: .success, options: [.height(100)])
        case 9:
            showMessage("Left", type: .success, options: [.textAlignment(.left)])
        case 10:
            showMessage("Center", type: .success, options: [.textAlignment(.center)])
        case 11:
            showMessage("Right", type: .success, options: [.textAlignment(.right)])
        case 12:
            showMessage("This will be a very long message that someone wanna show in a high message", type: .success, options: [.textNumberOfLines(0)])
        case 13:
            showMessage("Bottom", type: .success, options: [.position(.bottom)])
        case 14:
            hideMessage(animated: false)
            navigationController!.navigationBar.isTranslucent = !navigationController!.navigationBar.isTranslucent
        case 15:
            hideMessage(animated: false)
            navigationController!.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
        default:
            break
        }
    }

}
