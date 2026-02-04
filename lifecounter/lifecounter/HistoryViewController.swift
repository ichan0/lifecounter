//
//  HistoryViewController.swift
//  lifecounter
//
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var history: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        history.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "HistoryCell")

        cell.textLabel?.text = history[indexPath.row]
        return cell
    }
}

