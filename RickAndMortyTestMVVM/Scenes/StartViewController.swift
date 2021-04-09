//
//  ViewController.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 07.04.2021.
//

import UIKit

class StartViewController: UIViewController {

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    @IBAction func startBtnPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToList", sender: nil)
    }
 }

