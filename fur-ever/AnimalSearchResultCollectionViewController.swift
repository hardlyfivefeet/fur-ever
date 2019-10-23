import Foundation
import UIKit

private let REUSE_IDENTIFIER = "animalThumbnailCell"

class AnimalSearchResultCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : ApiService()
    var failureCallback: ((Error) -> Void)?

    var searchParams = AnimalSearchParams(animal_type: "", location: "")
    var searchResults: [Animal] = []

    var selectedRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.petfinder.com/v2/")
        api.searchAnimals(with: searchParams, then: display, fail: failureCallback ?? report)
    }

    // heckin broken if you try to go back and change the location
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
    
    // Pass the name of the location from the controller to the text field in the header of the results page
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
        headerView.locationField.text = searchParams.location
        return headerView
      default:
        assert(false, "Invalid element type")
      }
    }

    private func display(searchResult: AnimalSearchResult) {
        searchResults = searchResult.animals
        collectionView.reloadData()
//        collectionView.collectionViewLayout.invalidateLayout()
    }

    private func report(error: Error) {
       let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

       alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
       present(alert, animated: true, completion: nil)
    }
}
