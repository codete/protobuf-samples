/**
 *  Protobuf Sample iOS Application
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

final class TransactionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var acceptHeaderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var durationLabel: UILabel!
    
    var selectedAccount: Account?
    
    private let httpClient = HttpClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        switch acceptHeaderSegmentedControl.selectedSegmentIndex {
        case 0:
            httpClient.getTransactionList(acceptHeader: .json, id: (self.selectedAccount?.id)!) {
                [unowned self] result, transactions, durationTimes in
                self.updateUI(result: result, transactions: transactions, durationTimes: durationTimes)
            }
        case 1:
            httpClient.getTransactionList(acceptHeader: .protobuf, id: (self.selectedAccount?.id)!) {
                [unowned self] result, transactions, durationTimes in
                self.updateUI(result: result, transactions: transactions, durationTimes: durationTimes)
            }
        default:
            break
        }
    }
    
    func updateUI(result: Bool, transactions: [Transaction], durationTimes: DurationTimes?) {
        selectedAccount?.transactions = transactions
        guard let totalDuration = durationTimes?.totalDuration,
              let requestDuration = durationTimes?.requestDuration else {
            self.durationLabel.text = ""
            return
        }
        
        durationLabel.text = String(format: "Request: %.4f Total: %.4f", requestDuration, totalDuration)
        print("Request: \(requestDuration) Total: \(totalDuration)")
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedAccount?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
        guard let transactionDate = self.selectedAccount?.transactions[indexPath.row].transactionDate,
              let details = self.selectedAccount?.transactions[indexPath.row].details else {
            return cell
        }
        
        cell.dateLabel?.text = transactionDate
        cell.descriptionLabel?.text = details
        return cell
    }
}
