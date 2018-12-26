//
//  TableViewController.swift
//  GSMessagesExample
//
//  Created by GeSen on 2017/6/10.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    enum Sections: Int {
        case type
        case control
        case style
        case textAlign
        case navigation
        
        var title: String {
            switch self {
            case .type:         return "Type"
            case .control:      return "Control"
            case .style:        return "Style"
            case .textAlign:    return "Text Align"
            case .navigation:   return "Navigation Bar"
            }
        }
        
        var titles: [String] {
            switch self {
            case .type:
                return ["Success", "Error", "Warning", "Info"]
            case .control:
                return ["Fade", "Endless", "Dismiss", "Long Time"]
            case .style:
                return ["Bottom", "Height", "Long Text",
                        "Margin", "Padding", "Rounded Corners"]
            case .textAlign:
                return ["TopLeft", "Center", "BottomRight"]
            case .navigation:
                return ["Toggle NavBar Translucent",
                        "Toggle NavBar Hidden"]
            }
        }
        
        static var count = 5
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Important: Used in UITableViewController, you must add this in viewWillDisappear or viewDidDisappear.
        hideMessage()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections(rawValue: section)?.titles.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Sections(rawValue: section)?.title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        
        let section = Sections(rawValue: indexPath.section)
        let title = section?.titles[indexPath.row]
        
        cell.textLabel?.text = title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let section = Sections(rawValue: indexPath.section) else {
            return
        }
        
        switch section {
        case .type:
            switch indexPath.row {
            case 0: showMessage("Something success", type: .success)
            case 1: showMessage("Something failed", type: .error)
            case 2: showMessage("Some warning", type: .warning)
            case 3: showMessage("Some message", type: .info)
            default: break
            }
        case .control:
            switch indexPath.row {
            case 0:
                showMessage("Fade", type: .success, options: [.animations([.fade])])
            case 1:
                showMessage("Endless", type: .success, options: [
                    .autoHide(false),
                    .hideOnTap(false)
                ])
            case 2:
                hideMessage()
            case 3:
                showMessage("Long Time", type: .success, options: [.autoHideDelay(10)])
            default:
                break
            }
        case .style:
            switch indexPath.row {
            case 0:
                showMessage("Bottom", type: .success, options: [.position(.bottom)])
            case 1:
                showMessage("Height", type: .success, options: [.height(100)])
            case 2:
                showMessage("This will be a very long message that someone wanna show in a high message", type: .success, options: [.textNumberOfLines(0)])
            case 3:
                showMessage("Margin", type: .success, options: [
                    .margin(.init(top: 20, left: 20, bottom: 0, right: 20))
                ])
            case 4:
                showMessage("Padding,Padding,Padding,Padding,Padding", type: .success, options: [
                    .padding(.init(top: 10, left: 50, bottom: 10, right: 0))
                ])
            case 5:
                showMessage("Rounded Corners", type: .success, options: [
                    .cornerRadius(10),
                    .margin(.init(top: 0, left: 10, bottom: 0, right: 10))
                ])
            default:
                break
            }
        case .textAlign:
            switch indexPath.row {
            case 0:
                showMessage("TopLeft", type: .success, options: [
                    .textAlignment(.topLeft),
                    .height(60)
                ])
            case 1:
                showMessage("Center", type: .success, options: [
                    .textAlignment(.center),
                    .height(60)
                ])
            case 2:
                showMessage("BottomRight", type: .success, options: [
                    .textAlignment(.bottomRight),
                    .height(60)
                ])
            default:
                break
            }
        case .navigation:
            switch indexPath.row {
            case 0:
                hideMessage(animated: false)
                navigationController!.navigationBar.isTranslucent = navigationController!.navigationBar.isTranslucent
            case 1:
                hideMessage(animated: false)
                navigationController!.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
            default:
                break
            }
        }
    }

}
