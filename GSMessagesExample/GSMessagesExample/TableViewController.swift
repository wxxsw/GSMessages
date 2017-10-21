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
        return 22
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
        case 9:  cell.textLabel?.text = "TopLeft"
        case 10: cell.textLabel?.text = "TopCenter"
        case 11: cell.textLabel?.text = "TopRight"
        case 12: cell.textLabel?.text = "Left"
        case 13: cell.textLabel?.text = "Center"
        case 14: cell.textLabel?.text = "Right"
        case 15: cell.textLabel?.text = "BottomLeft"
        case 16: cell.textLabel?.text = "BottomCenter"
        case 17: cell.textLabel?.text = "BottomRight"
        case 18: cell.textLabel?.text = "Long Text"
        case 19: cell.textLabel?.text = "Bottom"
        case 20: cell.textLabel?.text = "Toggle NavBar Translucent"
        case 21: cell.textLabel?.text = "Toggle NavBar Hidden"
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
            showMessage("TopLeft", type: .success, options: [.textAlignment(.topLeft), .height(60)])
        case 10:
            showMessage("TopCenter", type: .success, options: [.textAlignment(.topCenter), .height(60)])
        case 11:
            showMessage("TopRight", type: .success, options: [.textAlignment(.topRight), .height(60)])
        case 12:
            showMessage("Left", type: .success, options: [.textAlignment(.left), .height(60)])
        case 13:
            showMessage("Center", type: .success, options: [.textAlignment(.center), .height(60)])
        case 14:
            showMessage("Right", type: .success, options: [.textAlignment(.right), .height(60)])
        case 15:
            showMessage("BottomLeft", type: .success, options: [.textAlignment(.bottomLeft), .height(60)])
        case 16:
            showMessage("BottomCenter", type: .success, options: [.textAlignment(.bottomCenter), .height(60)])
        case 17:
            showMessage("BottomRight", type: .success, options: [.textAlignment(.bottomRight), .height(60)])
        case 18:
            showMessage("This will be a very long message that someone wanna show in a high message", type: .success, options: [.textNumberOfLines(0)])
        case 19:
            showMessage("Bottom", type: .success, options: [.position(.bottom)])
        case 20:
            hideMessage(animated: false)
            navigationController!.navigationBar.isTranslucent = navigationController!.navigationBar.isTranslucent
        case 21:
            hideMessage(animated: false)
            navigationController!.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
        default:
            break
        }
    }

}
