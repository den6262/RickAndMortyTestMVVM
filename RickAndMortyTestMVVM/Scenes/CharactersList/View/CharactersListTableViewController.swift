//
//  CharactersListTableViewController.swift
//  RickAndMortyTestMVVM
//
//  Created by _deniro0001_ on 09.04.2021.
//

import UIKit

class CharactersListTableViewController: UITableViewController {
    
    //MARK: - Vars
    lazy var viewModel: CharactersListViewModel = {
        return CharactersListViewModel()
    }()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.isLoaded {
            setupUI()
            initViewModel()
        }
    }
    
    //MARK: - Funcs
    private func setupUI() {
        
        self.navigationItem.title = "All Characters"
    }
    
    private func initViewModel() {
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "goToDetail":
            let destination = segue.destination as! DetailTableViewController
            destination.character = viewModel.selectedCharacter
        default:
            break
        }
    }
    
    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if viewModel.isLoaded {
            return viewModel.sortedFirstLetters[section]
        } else {
            return "X"
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.viewModel.sortedFirstLetters
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.selectedCharacter = self.viewModel.getData(at: indexPath)
        performSegue(withIdentifier: "goToDetail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        cell.character = self.getData( at: indexPath )
        
        return cell
    }
}

//MARK: - CharactersListProtocol
extension CharactersListTableViewController: CharactersListProtocol {
    
    func getData(at: IndexPath) -> Character {
        
        return self.viewModel.getData(at: at)
    }
}
