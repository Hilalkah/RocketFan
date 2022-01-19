//
//  HomeViewController.swift
//  RocketFan
//
//  Created by Hilal on 13.01.2022.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = nil
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.tintColor = .systemPurple
        
        viewControllers = [
            createNavController(for: ListViewController(),
                                   title: "Rocket List",
                                   image: UIImage(systemName: "list.bullet.rectangle"),
                                   selectedImage: UIImage(systemName: "list.bullet.rectangle.fill")),
            createNavController(for: UIViewController(),
                                   title: "Favorites",
                                   image: UIImage(systemName: "star.square"),
                                   selectedImage: UIImage(systemName: "star.square.fill"))
        ]
        
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage?,
                                     selectedImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}

