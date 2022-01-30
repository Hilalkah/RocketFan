//
//  ListViewController.swift
//  RocketFan
//
//  Created by Hilal on 13.01.2022.
//

import UIKit

protocol ListViewControllerDelegate: AnyObject {
    func updatedViewModel(_ viewModel: ListViewModel?)
}

class ListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cellIdentifier = "RocketListTableViewCell"
    
    private var viewModel = ListViewModel()
    
    weak var delegate: ListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTableViewCell()
        
        viewModel.list.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.delegate?.updatedViewModel(self?.viewModel)
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
        let cellNib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func getRocketsRequest() -> URL? {
        return URL(string: "https://api.spacexdata.com/v4/rockets")
    }
    
    private func fetchData() {
        guard let requestUrl = getRocketsRequest() else { return }
        NetworkManager.shared.fetchData(requestUrl: requestUrl,
                                        model: [ListModel].self,
                                        completion: { model, error in
            if error != nil {
                return
            }
            
            guard let reponseModel = model else {
                return
            }
            
            self.viewModel.list.value = reponseModel.compactMap({
                ListTableViewCellViewModel(id: $0.id,
                                           name: $0.name,
                                           description: $0.description,
                                           flickrImages: $0.flickrImages)
            })
            self.setFavorites()
            
        })
        
    }
    
    func favoriteAction(_ cell: UITableViewCell) {
        guard
            let indexPathTapped = tableView.indexPath(for: cell),
            let item = viewModel.list.value?[indexPathTapped.row]
        else {
            return
        }
        viewModel.list.value?[indexPathTapped.row].isFavorite = !item.isFavorite
        delegate?.updatedViewModel(viewModel)
        if !item.isFavorite {
            Favorites.shared.addItem(item.id)
        } else {
            Favorites.shared.removeItem(item.id)
        }
    }
    
    private func setFavorites() {
        let favoriteIds: [String] = Favorites.shared.items
        for favoriteId in favoriteIds {
            if let value = viewModel.list.value {
                for index in 0..<value.count where value[index].id == favoriteId {
                    viewModel.list.value?[index].isFavorite = true
                }
            }
        }
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as? RocketListTableViewCell
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.listViewController = self
        cell.setValues(viewModel.list.value?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}
