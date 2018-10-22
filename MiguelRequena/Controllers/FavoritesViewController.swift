//
//  FavoritesViewController.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    
    @IBOutlet var tableFavorites: UITableView!{
        didSet{
            tableFavorites.dataSource = self
            tableFavorites.delegate = self
            
            tableFavorites.register(UINib(nibName: "FavoriteViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteViewCell")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableFavorites.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favoritesClass.listFavorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell") as! FavoriteViewCell
        cell.configure(idMovie: favoritesClass.listFavorites[indexPath.row])
        //cell.subjects
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //                presenter?.loadHelpCenterDetail(orderObject: helpOption)
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "UnFavorite", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            favoritesClass.markFavorite(id:favoritesClass.listFavorites[indexPath.row] )
                self.tableFavorites.reloadData()
            success(true)
        })
        
        modifyAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
    
    
    
    
    
    
    
}
