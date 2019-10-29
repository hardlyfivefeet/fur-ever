import Foundation
import UIKit

class AnimalResultFiltersViewController: UIViewController {
    
    @IBOutlet weak var breedFilter: UIButton!
    @IBOutlet weak var ageFilter: UIButton!
    @IBOutlet weak var sizeFilter: UIButton!
    @IBOutlet weak var genderFilter: UIButton!
    @IBOutlet weak var animalType: UISegmentedControl!
    @IBOutlet weak var distanceFilter: UISegmentedControl!
    
    var searchAnimalType = ""
    var distance = 100
    var breed: Filter!
    var age: Filter!
    var size: Filter!
    var gender: Filter!
    
    // TODO: instead of resetting filters everytime, should show currently applied filters if they exist
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFilters()
        initializeSegmentedControls(with: searchAnimalType, distance)
    }
    
    @IBAction func animalTypeChanged(_ sender: Any) {
        setAvailableBreedValues(for: animalType.titleForSegment(at: animalType.selectedSegmentIndex)!)
    }
    
    private func initializeSegmentedControls(with searchAnimalType: String, _ distance: Int) {
        switch searchAnimalType {
        case "Dog":
            animalType.selectedSegmentIndex = 0
            break
        case "Cat":
            animalType.selectedSegmentIndex = 1
            break
        default:
            animalType.selectedSegmentIndex = 2
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
    
    private func setAvailableBreedValues(for searchAnimalType: String) {
        switch searchAnimalType {
        case "Dog":
            breed = Filter(Breeds.dogBreeds)
            break
        case "Cat":
            breed = Filter(Breeds.catBreeds)
            break
        default:
            breed = Filter(Breeds.otherBreeds)
            break
        }
    }
    
    private func initializeFilters() {
        setAvailableBreedValues(for: searchAnimalType)
        // if these don't already exist, initialize
        age = Filter(["Baby", "Young", "Adult", "Senior"])
        size = Filter(["Small", "Medium", "Large", "XLarge"])
        gender = Filter(["Male", "Female"])
    }

    @IBAction func clearFilters(_ sender: Any) {
        initializeFilters()
        updateFilterLabels()
    }
    
    @IBAction func cancelFilterSelectionToAnimalResultFiltersViewController(unwindSegue: UIStoryboardSegue) {
        // Don't do anything, we're just going backwards in the flow
    }
       
    @IBAction func saveFilterSelectionToAnimalResultFiltersViewController(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.source is AnimalResultFilterSelectionViewController {
            updateFilterLabels()
        }
    }
    
    private func updateFilterLabels() {
        updateFilterButtonLabel(breedFilter, breed.appliedFilters.count)
        updateFilterButtonLabel(ageFilter, age.appliedFilters.count)
        updateFilterButtonLabel(sizeFilter, size.appliedFilters.count)
        updateFilterButtonLabel(genderFilter, gender.appliedFilters.count)
    }
    
    private func updateFilterButtonLabel(_ button: UIButton, _ filteredValueCount: Int) {
        button.setTitle(filteredValueCount > 0 ? String(filteredValueCount) + " selected" : "Select", for: UIControl.State.normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "applyFilters" {
            if let animalSearchResultCollectionViewController = segue.destination as? AnimalSearchResultCollectionViewController {
                // TODO: make new search params with applied filters, pass to searchresultcollectionviewcontroller
            }
        }
        if segue.identifier == "selectFilterValues" {
            if let animalResultFilterSelectionViewController = segue.destination as? AnimalResultFilterSelectionViewController {
                switch sender as! UIButton {
                    case breedFilter:
                        animalResultFilterSelectionViewController.filterOption = breed
                        animalResultFilterSelectionViewController.tableTitleText = "Breed"
                    break
                    case ageFilter:
                        animalResultFilterSelectionViewController.filterOption = age
                        animalResultFilterSelectionViewController.tableTitleText = "Age"
                        break
                    case sizeFilter:
                        animalResultFilterSelectionViewController.filterOption = size
                        animalResultFilterSelectionViewController.tableTitleText = "Size"
                        break
                    case genderFilter:
                        animalResultFilterSelectionViewController.filterOption = gender
                        animalResultFilterSelectionViewController.tableTitleText = "Gender"
                        break
                    default:
                        break
                }
            }
        }
    }
}
