import Foundation
import UIKit

private let REUSE_IDENTIFIER = "animalThumbnailCell"

class AnimalSearchResultCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : ApiService() // for real API call, do RealApiService instead of ApiService
    var failureCallback: ((Error) -> Void)?

    var searchParams = AnimalSearchParams(animal_type: "", location: "")
    var searchResults: [AnimalBasicInfo] = []

    var selectedRow = 0
    var shouldShowHeader = true

    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        makeApiCall()
    }

    private func makeApiCall() {
        api.api(host: "https://api.petfinder.com/v2/")
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

    // Set the image and name for each cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
           UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath)
           as! AnimalSearchResultCollectionViewCell

        cell.thumbnailPhoto.imageURL = searchResults[indexPath.row].image.url
        cell.thumbnailName.text = searchResults[indexPath.row].name
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedRow = indexPath.row
        return true
    }

    // Pass the name of the location from the controller to the search bar in the header of the results page
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
        collectionView.reloadData()
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
                }
            }
        }
        if segue.identifier == "filterSegue" {
            if let animalResultFiltersViewController = segue.destination as? AnimalResultFiltersViewController {
                animalResultFiltersViewController.searchAnimalType = searchParams.animal_type
            }
        }
    }
    
    @IBAction func returnFromFiltersToAnimalResultCollectionViewController(unwindSegue: UIStoryboardSegue) {
        // Don't do anything
    }
    
    @IBAction func applyFiltersToAnimalResultCollectionViewController(unwindSegue: UIStoryboardSegue) {
        // Don't do anything
    }
}
