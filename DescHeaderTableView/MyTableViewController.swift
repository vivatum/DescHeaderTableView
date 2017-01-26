//
//  MyTableViewController.swift
//  DescHeaderTableView
//
//  Created by Vivatum on 1/26/17.
//  Copyright © 2017 vivatum. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var myEventList = [MyEvent]()
    var tableViewSource: [Int : [MyEvent]]!
    var tableViewHeaders: [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // get Events and tableViewSource
        myEventList = SourceManager.createEventList()
        tableViewSource = SourceManager.createTableViewData(events: myEventList).events
        tableViewHeaders = SourceManager.createTableViewData(events: myEventList).years
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewHeaders.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = tableViewHeaders[tableViewHeaders.index(tableViewHeaders.startIndex, offsetBy: section)]
        let filesInSection = tableViewSource[sectionTitle]
        return filesInSection!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = "dd/MM"
        
        let sectionTitle = tableViewHeaders[tableViewHeaders.index(tableViewHeaders.startIndex, offsetBy: indexPath.section)]
        let eventsInSection = tableViewSource[sectionTitle]
        let event = eventsInSection![indexPath.row]
        
        cell.textLabel?.text = event.place
        cell.detailTextLabel?.text = dateFormatter.string(from: event.date)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionTitle = tableViewHeaders[tableViewHeaders.index(tableViewHeaders.startIndex, offsetBy: section)]
        
        let customLabel = UILabel()
        let width = self.tableView.frame.width
        customLabel.frame = CGRect(x: 0, y: 0, width: width, height: 40)
        customLabel.font = UIFont.boldSystemFont(ofSize: 17)
        customLabel.backgroundColor = UIColor(red: 234/255, green: 235/255, blue: 237/255, alpha: 1)
        customLabel.text = "    \(sectionTitle)"
        
        let headerView = UIView()
        headerView.addSubview(customLabel)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
