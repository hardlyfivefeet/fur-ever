import Foundation
import UIKit

private let REUSE_IDENTIFIER = "organizationTableCell"

class OrganizationSearchResultTableViewController: UITableViewController {

    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : ApiService()
    var failureCallback: ((Error) -> Void)?

    var searchParams = OrganizationSearchParams(name: "", location: "")
    var searchResults: [OrganizationBasicInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.petfinder.com/v2/")
        api.searchOrganizations(with: searchParams, then: display, fail: failureCallback ?? report)
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

    private func display(searchResult: OrganizationSearchResult) {
            searchResults = searchResult.organizations
            tableView.reloadData()
    }

    private func report(error: Error) {
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
                    organizationSearchResultViewController.organizationId = searchResults[indexPath.row].id
                }
            }
        }
    }
}
