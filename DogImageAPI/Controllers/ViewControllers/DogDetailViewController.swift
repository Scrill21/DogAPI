//
//  DogDetailViewController.swift
//  DogImageAPI
//
//  Created by anthony byrd on 5/5/21.
//

import UIKit

class DogDetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var searchDogBreedTextField: UITextField!
    @IBOutlet weak var dogBreedImageView: UIImageView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    //MARK: - Properties
    var dog: Dog?
    
    //MARK: - Actions
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let searchTerm = searchDogBreedTextField.text, !searchTerm.isEmpty else {return}
        DogController.fetchRandomDogImage(with: searchTerm.lowercased()) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let dog):
                    self.fetchImage(from: dog)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK: - Helper Methods
    func updateViews(with image: UIImage) {
        dogBreedImageView.image = image
    }
    
    func fetchImage(from dog: Dog) {
        DogController.fetchImageForDog(with: dog) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.updateViews(with: image)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of class
