import Foundation
import UIKit

private let REUSE_IDENTIFIER = "animalThumbnailCell"

class AnimalSearchResultCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var api: Api!
    var failureCallback: ((Error) -> Void)?

    var searchParams = AnimalSearchParams("", "")
    var searchResults: [AnimalBasicInfo] = []

    var selectedRow = 0
    var shouldShowHeader = true
    var shouldAllowFilters = true
    var loadingView: UIActivityIndicatorView!

    @IBOutlet weak var filterButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterButton.isEnabled = shouldAllowFilters

        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.tabBarController!.tabBar.frame.height, right: 0)
        loadingView = UIActivityIndicatorView(style: .large)
        collectionView.backgroundView = loadingView
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }

        // set up API
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        api = appDelegate.api
        makeApiCall()
    }

    // show loading indicator before cells start showing
    override func viewWillAppear(_ animated: Bool) {
        if collectionView.numberOfItems(inSection: 0) == 0 {
            loadingView.startAnimating()
        }
    }

    private func makeApiCall() {
        if api.tokenHasExpired() {
            api.getToken(with: TokenRequestParams(), fail: failureCallback ?? report)
        }
        api.searchAnimals(with: searchParams, then: display, fail: failureCallback ?? report)
    }

    // determine size of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfCell: CGFloat = 2
        let cellWidth = (self.view.frame.width - 15) / numberOfCell
        return CGSize(width: cellWidth, height: cellWidth)
    }

    // set number of cells in section to be number of search results returned
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }

    // set number of sections in collection view to be 1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // set the image and name for each cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
           UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath)
           as! AnimalSearchResultCollectionViewCell
        cell.thumbnailPhoto.image = UIImage(named: "NoImageAvailable")
            cell.thumbnailName.text = "No name available"
        if (searchResults[indexPath.row].photos.count != 0) {
            cell.thumbnailPhoto.imageURL = searchResults[indexPath.row].photos[0].full
        }
        cell.thumbnailName.text = searchResults[indexPath.row].name
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedRow = indexPath.row
        return true
    }

    // pass the name of the location from the controller to the search bar in the header of the results page
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                     at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
          case UICollectionView.elementKindSectionHeader:
            guard
              let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "\(SearchResultCollectionHeaderView.self)",
                for: indexPath) as? SearchResultCollectionHeaderView
              else {
                fatalError("Invalid view type")
              }
            headerView.searchField.text = searchParams.location
            headerView.searchField.delegate = self
            return headerView
          default:
            assert(false, "Invalid element type")
        }
    }

    // set up search bar header based on whether it needs to be shown
    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          referenceSizeForHeaderInSection section: Int) -> CGSize {
        if shouldShowHeader {
            return CGSize(width: self.view.frame.width, height: 85)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchParams.location = searchBar.text ?? searchParams.location
        makeApiCall()
    }

    private func display(searchResult: AnimalSearchResult) {
        searchResults = searchResult.animals
        loadingView.stopAnimating()
        collectionView.reloadData()
        if (searchResults.count == 0) {
            collectionView.showNoResultsMessage()
        } else {
            collectionView.restore()
        }
    }

    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "animalSearchResultCollectionToSingleResult" {
            if let animalSearchResultViewController = segue.destination as? AnimalSearchResultViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    animalSearchResultViewController.animalId = searchResults[indexPath.row].id
                    animalSearchResultViewController.searchDistance = searchResults[indexPath.row].distance
                }
            }
        }
        if segue.identifier == "filterSegue" {
            if let animalResultFiltersViewController = segue.destination as? AnimalResultFiltersViewController {
                animalResultFiltersViewController.searchParams = searchParams
            }
        }
    }

    @IBAction func returnFromFiltersToAnimalResultCollectionViewController(unwindSegue: UIStoryboardSegue) {
        // Don't do anything
    }

    @IBAction func applyFiltersToAnimalResultCollectionViewController(unwindSegue: UIStoryboardSegue) {
        viewDidLoad()
    }
}

// Credit: https://stackoverflow.com/questions/43772984/how-to-show-a-message-when-collection-view-is-empty
// Show error message if no results fit the search criteria
extension UICollectionView {
    func showNoResultsMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = "No results found.\nTry adjusting your filters\nto see more results."
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
