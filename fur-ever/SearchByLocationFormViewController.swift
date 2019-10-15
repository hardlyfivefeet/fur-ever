//
//  SearchByLocationFormViewController.swift
//  fur-ever
//
//  Created by Merissa Tan on 10/14/19.
//  Copyright © 2019 Dondi. All rights reserved.
//

import Foundation
import UIKit

class SearchByLocationFormViewController: UIViewController {
    
    @IBOutlet weak var petType: UISegmentedControl!
    @IBOutlet weak var searchLocation: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.isNavigationBarHidden = true
     }

     override public func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         navigationController?.isNavigationBarHidden = false
     }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
//        if let animalsSearchResultCollectionViewController = segue.destination as? AnimalsSearchResultCollectionViewController,
//           let query = searchLocation.text {
//            animalsSearchResultCollectionViewController.searchParams = SearchParams(rating: .PG13, query: query)
//        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let searchFieldYLocation = searchLocation.frame.origin.y
            let screenBottomYLocation = self.view.frame.height
            var viewOrigin = self.view.frame.origin.y
            if viewOrigin == 0 && searchFieldYLocation > (screenBottomYLocation - keyboardSize.height - 80) {
                viewOrigin = screenBottomYLocation - searchFieldYLocation - keyboardSize.height - 80
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func keyboardSearchReturn(_ sender: Any) {
        searchButton.sendActions(for: .touchUpInside)
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        updateViews()
    }
    
    private func updateViews() {
        searchButton.isEnabled = (searchLocation.text ?? "").count > 0
    }
}
