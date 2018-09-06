
//
//  ListFilterViewController.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class ListFilterViewController: UIViewController {
    
     static let identifier = "ListFilterView"
    
    @IBOutlet weak var ViewNav: NavigationView!
    @IBOutlet weak var DataTableView: UITableView!
    var propDisplayName:String = ""
    var dataList = [Dictionary<String, Any>]()
    var selectedCallBack : ((_ itemSelect:Dictionary<String, Any>) -> Void)?
    var titleView:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewNav.navTitle(title: titleView)
        ViewNav.leftButtonBack(state: true)
        ViewNav.LeftCallBack = {state in
            self.dismiss(animated: true, completion: nil)
        }
        
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        DataTableView.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: FilterTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension ListFilterViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = DataTableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as! FilterTableViewCell
        
        cell.LblName.text = dataList[indexPath.row][propDisplayName] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCallBack?(dataList[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
