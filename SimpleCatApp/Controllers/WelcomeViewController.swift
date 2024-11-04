//
//  WelcomeViewController.swift
//  ConcerteApp
//
//  Created by Konstantin Kulakov on 27.10.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        statusLabel.text = "Ready for download"
        activityIndicator.hidesWhenStopped = true
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
                self?.catImageView.image = UIImage(data: data)
                self?.statusLabel.text = "Cat was downloaded"
                self?.activityIndicator.stopAnimating()
                self?.generateButton.isEnabled.toggle()
            }
        }
        
        task.resume()
    }

    
    @IBAction func didTapButton(_ sender: Any) {
        activityIndicator.startAnimating()
        statusLabel.text = "Start downloading cat"
        generateButton.isEnabled.toggle()
        downloadCat()
    }
}
