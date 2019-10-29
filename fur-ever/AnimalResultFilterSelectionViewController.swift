import Foundation
import UIKit

class AnimalResultFilterSelectionViewController: UIViewController, UITableViewDelegate {
    
    private let REUSE_IDENTIFIER = "filterValuesTableCell"
    
    @IBOutlet weak var tableView: UITableView!
    var filterOption: Filter!
    // check if array already have things
    // if so, mark those things as checked in table
    // if not, just load table with available values
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.reloadData()
    }

    // set the name for each row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! AnimalResultFilterSelectionTableViewCell

        cell.value.text = filterOption.availableValues[indexPath.row]
        if (filterOption.appliedFilters.contains(indexPath.row)) {
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }

    // set height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfRows: CGFloat = 10
        let rowHeight = self.view.frame.height / numberOfRows
        return CGFloat(rowHeight)
    }

    // set number of rows in section to be number of available values for the filter
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterOption.availableValues.count
    }

    // set number of sections to be 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    private func getSelectedRows() {
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        filterOption.appliedFilters = selectedIndexPaths!.map {$0.row}
    }
}
