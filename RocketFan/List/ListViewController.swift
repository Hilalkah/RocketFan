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
    
    private var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        viewModel.list.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        fetchData()
    }
    
    private func fetchData() {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode([ListModel].self, from: data)
                
                self.viewModel.list.value = model.compactMap({
                    ListTableViewCellViewModel(name: $0.name)
                })
            }
            catch {
                print("error", error)
            }
        }
        
        task.resume()
    }

}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.list.value?[indexPath.row].name
        return cell
    }
    
}
