//
//  DetailTableViewController.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 09.04.2021.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    
    @IBOutlet weak var characterImgView: UIImageView!
    
    //MARK: - Vars
    var character: Character?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - Funcs
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func setupUI() {
        
        tableView.separatorStyle = .none
        
        self.navigationItem.title = character?.name
        
        if let species = character?.species {
            speciesLbl.text = species
        }
        
        if let gender = character?.gender {
            speciesLbl.text = gender
        }
        
        if let status = character?.status {
            statusLbl.text = status
        }
        
        if let location = character?.location.name {
            locationLbl.text = location
        }
        
        if let origin = character?.origin.name {
            originLbl.text = origin
        }
        
        if let imgUrl = character?.image {
            getData(from: imgUrl) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.characterImgView.image = UIImage(data: data)
                }
            }
        }
    }
}
