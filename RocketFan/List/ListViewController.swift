//
//  ListViewController.swift
//  RocketFan
//
//  Created by Hilal on 13.01.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private enum Constants {
        static let cellId = "RocketListTableViewCell"
        typealias CellType = RocketListTableViewCell
    }
    
    private var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewCell()
        
        viewModel.list.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    private func setupTableViewCell() {
        let nib = UINib(nibName: Constants.cellId, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellId)
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode([ListModel].self, from: data)
                
                self.viewModel.list.value = model.compactMap({
                    ListTableViewCellViewModel(name: $0.name, description: $0.description, flickr_images: $0.flickr_images)
                })
            }
            catch {
                print("error", error)
            }
        }
        
        task.resume()
    }
    
    func favoriteAction(_ cell: UITableViewCell) {
        guard
            let indexPathTapped = tableView.indexPath(for: cell),
            let isFavorite = viewModel.list.value?[indexPathTapped.row].isFavorite
        else {
            return
        }
        viewModel.list.value?[indexPathTapped.row].isFavorite = !isFavorite
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? Constants.CellType else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.vc = self
        cell.setValues(viewModel.list.value?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}
