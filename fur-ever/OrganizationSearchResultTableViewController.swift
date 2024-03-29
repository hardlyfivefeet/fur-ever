import Foundation
import UIKit

private let REUSE_IDENTIFIER = "organizationTableCell"

class OrganizationSearchResultTableViewController: UITableViewController {

    var api: Api!
    var failureCallback: ((Error) -> Void)?

    var searchParams = OrganizationSearchParams(name: "", location: "")
    var searchResults: [Organization] = []
    var loadingView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.tabBarController?.tabBar.frame.height ?? 0, right: 0)
        loadingView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = loadingView

        // set up API to use the app delegate one if not running unit tests
        if !isRunningTests {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            api = appDelegate.api
            if api.tokenHasExpired() {
                api.getToken(with: TokenRequestParams(), fail: failureCallback ?? report)
            }
        }
        api.searchOrganizations(with: searchParams, then: display, fail: failureCallback ?? report)
    }

    // show loading indicator before results are shown
    override func viewWillAppear(_ animated: Bool) {
        if tableView.numberOfRows(inSection: 0) == 0 {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
            loadingView.startAnimating()
        }
    }

    // set the name for each row in the table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! OrganizationSearchResultTableViewCell

        cell.organizationName.text = searchResults[indexPath.row].name

        return cell
    }

    // set height of each row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfRows: CGFloat = 10
        let rowHeight = self.view.frame.height / numberOfRows
        return CGFloat(rowHeight)
    }

    // set number of rows in section to be number of search results returned
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    // set number of sections to be 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "organizationSearchResultCollectionToSingleResult", sender: indexPath)
    }

    private func display(searchResult: OrganizationSearchResult) {
        searchResults = searchResult.organizations
        loadingView.stopAnimating()
        tableView.reloadData()
        if (searchResults.count == 0) {
            tableView.showNoResultsMessage()
        } else {
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            tableView.restore()
        }
    }

    private func report(error: Error) {
        loadingView.stopAnimating()
       let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

       alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
       present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "organizationSearchResultCollectionToSingleResult" {
            if let organizationSearchResultViewController = segue.destination as? OrganizationSearchResultViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    organizationSearchResultViewController.organization = searchResults[indexPath.row]
                }
            }
        }
    }
}

// Credit: https://stackoverflow.com/questions/43772984/how-to-show-a-message-when-collection-view-is-empty
// Show error message if no results fit the search criteria
extension UITableView {
    func showNoResultsMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = "No results found.\nTry changing the search name or \n search location to see more results."
        messageLabel.textColor = .systemIndigo
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "System", size: 18)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
}
