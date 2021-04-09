//
//  CharacterTableViewCell.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 09.04.2021.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet var characterImgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    var character : Character? {
        didSet {
            nameLabel.text = character?.name
            
            if let descr = character?.status {
                statusLabel.text = descr
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
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
