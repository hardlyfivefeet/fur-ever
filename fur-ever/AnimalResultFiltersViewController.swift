import Foundation
import UIKit

class AnimalResultFiltersViewController: UIViewController {
    
    @IBOutlet weak var breedFilter: UIButton!
    @IBOutlet weak var ageFilter: UIButton!
    @IBOutlet weak var sizeFilter: UIButton!
    @IBOutlet weak var genderFilter: UIButton!
    @IBOutlet weak var distanceFilter: UIButton!

    var searchAnimalType = ""
    var breed: Filter!
    var age: Filter!
    var size: Filter!
    var gender: Filter!
    var distance: Filter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFilters()
    }
    
    // TODO: make sure to call this when segmented control is changed
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
        age = Filter(["Baby", "Young", "Adult", "Senior"])
        size = Filter(["Small", "Medium", "Large", "XLarge"])
        gender = Filter(["Male", "Female"])
        distance = Filter(["10", "25", "50", "100"])
    }

    @IBAction func clearFilters(_ sender: Any) {
        initializeFilters()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "applyFilters" {
            if let animalSearchResultCollectionViewController = segue.destination as? AnimalSearchResultCollectionViewController {
                // make new search params with applied filter
            }
        }
        if segue.identifier == "selectFilterValues" {
            if let animalResultFilterSelectionViewController = segue.destination as? AnimalResultFilterSelectionViewController {
                switch sender as! UIButton {
                    case breedFilter:
                        animalResultFilterSelectionViewController.filterOption = breed
                        break
                    case ageFilter:
                        animalResultFilterSelectionViewController.filterOption = age
                        break
                    case sizeFilter:
                        animalResultFilterSelectionViewController.filterOption = size
                        break
                    case genderFilter:
                        animalResultFilterSelectionViewController.filterOption = gender
                        break
                    case distanceFilter:
                        animalResultFilterSelectionViewController.filterOption = distance
                        break
                    default:
                        break
                }
            }
        }
    }
}
