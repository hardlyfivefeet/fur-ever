import Foundation
import UIKit

class AnimalResultFilterSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let REUSE_IDENTIFIER = "filterValuesTableCell"

    @IBOutlet weak var tableTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var filterOption: Filter!
    var tableTitleText: String!
    var selectedCells: [Int]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableTitle.text = tableTitleText
        tableView.tableFooterView = UIView(frame: .zero)
        tableView?.backgroundColor = UIColor(red: 227.0/255.0, green: 246.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        selectedCells = filterOption.appliedFilters
    }

    // set the name for each row in the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: REUSE_IDENTIFIER, for: indexPath) as! AnimalResultFilterSelectionTableViewCell

        // set row text for each available filter option
        cell.value.text = filterOption.availableValues[indexPath.row]

        // if filter value is currently applied, the row should be selected
        if (selectedCells.contains(indexPath.row)) {
            self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    // set height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let numberOfRows: CGFloat = 12
        let rowHeight = self.view.frame.height / numberOfRows
        return CGFloat(rowHeight)
    }

    // remove checkmark on deselected rows
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCells = selectedCells.filter {$0 != indexPath.row}
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }

    // put a checkmark on selected rows
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCells.append(indexPath.row)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
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

    @IBAction func saveButtonTapped(_ sender: Any) {
        filterOption.appliedFilters = selectedCells
        self.performSegue(withIdentifier: "saveAnimalResultFilterSelection", sender: self)
    }
}
