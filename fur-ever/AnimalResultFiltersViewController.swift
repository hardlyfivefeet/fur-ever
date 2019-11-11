import Foundation
import UIKit

class AnimalResultFiltersViewController: UIViewController {

    @IBOutlet weak var breedFilter: UIButton!
    @IBOutlet weak var ageFilter: UIButton!
    @IBOutlet weak var sizeFilter: UIButton!
    @IBOutlet weak var genderFilter: UIButton!
    @IBOutlet weak var animalType: UISegmentedControl!
    @IBOutlet weak var distanceFilter: UISegmentedControl!

    var searchParams: AnimalSearchParams!
    var searchParamsCopy: AnimalSearchParams!

    override func viewDidLoad() {
        super.viewDidLoad()
        if searchParams.breeds == nil {
            setAvailableBreedValues(for: searchParams.animalType!)
        }
        initializeSegmentedControls(with: searchParams.animalType!, searchParams.distance)
        updateFilterLabels()
        searchParamsCopy = AnimalSearchParams(copy: searchParams)
    }

    private func initializeSegmentedControls(with searchAnimalType: String, _ distance: Int) {
        switch searchAnimalType {
        case "Dog":
            animalType.selectedSegmentIndex = 0
            break
        case "Cat":
            animalType.selectedSegmentIndex = 1
            break
        case "Bird":
            animalType.selectedSegmentIndex = 2
            break
        default:
            animalType.selectedSegmentIndex = 3
            break
        }
        switch distance {
        case 10:
            distanceFilter.selectedSegmentIndex = 0
            break
        case 25:
            distanceFilter.selectedSegmentIndex = 1
            break
        case 50:
            distanceFilter.selectedSegmentIndex = 2
            break
        default:
            distanceFilter.selectedSegmentIndex = 3
            break
        }
    }

    @IBAction func animalTypeChanged(_ sender: Any) {
        searchParams.animalType = animalType.titleForSegment(at: animalType.selectedSegmentIndex)!
        setAvailableBreedValues(for: searchParams.animalType!)
        updateFilterLabels()
    }

    @IBAction func distanceChanged(_ sender: Any) {
        let distanceString = distanceFilter.titleForSegment(at: distanceFilter.selectedSegmentIndex)!
        let index = distanceString.index(distanceString.endIndex, offsetBy: -3)
        let distanceSubstring = distanceString[..<index]

        searchParams.distance = Int(String(distanceSubstring))!
    }

    private func setAvailableBreedValues(for animalType: String) {
        switch searchParams.animalType {
        case "Dog":
            searchParams.breeds = Filter(Breeds.dogBreeds)
            break
        case "Cat":
            searchParams.breeds = Filter(Breeds.catBreeds)
            break
        case "Bird":
            searchParams.breeds = Filter(Breeds.birdBreeds)
            break
        default:
            searchParams.breeds = Filter(Breeds.rabbitBreeds)
            break
        }
    }

    @IBAction func clearFilters(_ sender: Any) {
        searchParams.breeds!.appliedFilters = []
        searchParams.age.appliedFilters = []
        searchParams.size.appliedFilters = []
        searchParams.gender.appliedFilters = []
        updateFilterLabels()
    }

    // Unwind segue when user clicks on cancel button from filter selection table
    @IBAction func cancelFilterSelectionToAnimalResultFiltersViewController(unwindSegue: UIStoryboardSegue) {
    }

    // Unwind segue when user clicks on save button from filter selection table
    @IBAction func saveFilterSelectionToAnimalResultFiltersViewController(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is AnimalResultFilterSelectionViewController {
            updateFilterLabels()
        }
    }

    private func updateFilterLabels() {
        updateFilterButtonLabel(breedFilter, searchParams.breeds!.appliedFilters.count)
        updateFilterButtonLabel(ageFilter, searchParams.age.appliedFilters.count)
        updateFilterButtonLabel(sizeFilter, searchParams.size.appliedFilters.count)
        updateFilterButtonLabel(genderFilter, searchParams.gender.appliedFilters.count)
    }

    private func updateFilterButtonLabel(_ button: UIButton, _ filteredValueCount: Int) {
        button.setTitle(filteredValueCount > 0 ? String(filteredValueCount) + " selected" : "Select", for: UIControl.State.normal)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancelButtonTappedAtAnimalResultFilters" {
            if let animalSearchResultCollectionViewController = segue.destination as? AnimalSearchResultCollectionViewController {
                animalSearchResultCollectionViewController.searchParams = searchParamsCopy
            }
        }
        if segue.identifier == "selectFilterValues" {
            if let animalResultFilterSelectionViewController = segue.destination as? AnimalResultFilterSelectionViewController {
                switch sender as! UIButton {
                    case breedFilter:
                        animalResultFilterSelectionViewController.filterOption = searchParams.breeds
                        animalResultFilterSelectionViewController.tableTitleText = "Breed"
                    break
                    case ageFilter:
                        animalResultFilterSelectionViewController.filterOption = searchParams.age
                        animalResultFilterSelectionViewController.tableTitleText = "Age"
                        break
                    case sizeFilter:
                        animalResultFilterSelectionViewController.filterOption = searchParams.size
                        animalResultFilterSelectionViewController.tableTitleText = "Size"
                        break
                    case genderFilter:
                        animalResultFilterSelectionViewController.filterOption = searchParams.gender
                        animalResultFilterSelectionViewController.tableTitleText = "Gender"
                        break
                    default:
                        break
                }
            }
        }
    }
}
