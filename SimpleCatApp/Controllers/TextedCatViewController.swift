//
//  TextedCatViewController.swift
//  ConcerteApp
//
//  Created by Kovalev Gleb on 03.11.2024.
//

import UIKit

class TextedCatViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var catText: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catText.text = ""
        descriptionLabel.text = "Generate your cat"
        activityIndicator.layer.opacity = 0
    }
    
    private func downloadCat() {
        guard let url = URL(string: "https://cataas.com/cat") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = UIImage(data: data)
                self?.descriptionLabel.text = "Cat was downloaded"
                self?.activityIndicator.layer.opacity = 0
                self?.button.isEnabled.toggle()
                self?.catText.text = self?.textField.text ?? ""
                self?.textField.text = ""
                self?.textField.isEnabled.toggle()
            }
        }
        
        task.resume()
    }
    
    
    @IBAction func didTapButton(_ sender: Any) {
        if textField.text?.isEmpty ?? false {
            let alert = UIAlertController(title: "Error", message: "Please enter text", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        catText.text = ""
        descriptionLabel.text = "Loading..."
        activityIndicator.layer.opacity = 1
        button.isEnabled.toggle()
        textField.isEnabled.toggle()
        descriptionLabel.text = "Start downloading cat"
        downloadCat()
    }
}


