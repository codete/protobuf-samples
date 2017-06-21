/**
 *  Protobuf Sample iOS Application
 *  Copyright (c) Codete 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import UIKit

final class AccountsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var acceptHeaderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let httpClient = HttpClient()
    var accountList: AccountList?

    var selectedAccount: Account?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getListButtonPressed(_ sender: Any) {
        switch acceptHeaderSegmentedControl.selectedSegmentIndex {
        case 0:
            httpClient.getAccountList(acceptHeader: .json) { [unowned self] result, accountList, durationTimes in
                self.updateUI(result: result, accountList: accountList, durationTimes: durationTimes)
            }
        case 1:
            httpClient.getAccountList(acceptHeader: .protobuf) { [unowned self] result, accountList, durationTimes in
                self.updateUI(result: result, accountList: accountList, durationTimes: durationTimes)
            }
        default:
            break
        }
    }
    
    func updateUI(result: Bool, accountList: AccountList?, durationTimes: DurationTimes?) {
        self.accountList = accountList
        guard let totalDuration = durationTimes?.totalDuration,
              let requestDuration = durationTimes?.requestDuration else {
            durationLabel.text = ""
            return
        }
        
        durationLabel.text = String(format: "Request: %.4f Total: %.4f", requestDuration, totalDuration)
        print("Request: \(requestDuration) Total: \(totalDuration)")
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accountList?.accounts.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "TableViewCell")
        guard let name = self.accountList?.accounts[indexPath.row].name else {
            return cell
        }
        cell.textLabel?.text = name
        return cell
    }
    
    // MARK: - UITableViewCellDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let account = accountList?.accounts[indexPath.row] else {
            return
        }
        selectedAccount = account
        performSegue(withIdentifier: "showTransactions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTransactions" {
            let destinationViewController = segue.destination as! TransactionsViewController
            destinationViewController.selectedAccount = selectedAccount
        }
    }
}
