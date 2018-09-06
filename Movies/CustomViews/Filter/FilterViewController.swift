//
//  AlertOptionViewController.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    static let identifier = "FilterView"
    
    @IBOutlet weak var ViewNav: NavigationView!
    @IBOutlet weak var BtnDate: UIButton!
    @IBOutlet weak var BtnGenres: UIButton!
    @IBOutlet weak var LblDateSelect: UILabel!
    @IBOutlet weak var LblGenre: UILabel!
    @IBOutlet weak var BtnFilterOk: UIButton! {
        didSet{
            BtnFilterOk.layer.cornerRadius = 5
        }
    }
    
    let years:[Dictionary<String, Any>] = [["year":"2000"],["year":"2001"],["year":"2002"],["year":"2003"],["year":"2004"],["year":"2005"],["year":"2006"],["year":"2007"],["year":"2008"],["year":"2009"],["year":"2010"],["year":"2011"],["year":"2012"],["year":"2013"],["year":"2014"],["year":"2015"],["year":"2016"],["year":"2017"],["year":"2018"]]
    
    var genres = [Dictionary<String, Any>]()
    
    var genreSelect:Dictionary<String, Any> = [:]
    var yearSelect:Dictionary<String, Any> = [:]
    
    var selectedItemsCallBack : ((_ itemsSelect:[Dictionary<String, Any>]) -> Void)?
    
    
    //    var ActionOk: ((() -> genre)?) = ("ok", {
    //        return true
    //    })
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewNav.navTitle(title: "Filter")
        ViewNav.leftButtonBack(state: true)
        ViewNav.LeftCallBack = {state in
            self.dismiss(animated: true, completion: nil)
        }
        
        view.isOpaque = false
        
        
        BtnFilterOk.addTarget(self, action: #selector(OkAction), for: .touchUpInside)
        
        BtnDate.addTarget(self, action: #selector(dateAction), for: .touchUpInside)
        BtnGenres.addTarget(self, action: #selector(GenresAction), for: .touchUpInside)
        
        self.loadGenres()
        // Do any additional setup after loading the view.
    }
    
    func loadGenres(){
        
        let dataGenres = Array(RealmService.shared.realm.objects(Genre.self))
        
        for index in dataGenres{
            genres.append(["id":index.id,"name":index.name])
        }
    }
    
    @objc func OkAction(_ sender: UIButton) {
        if self.LblGenre.text != "" && self.LblDateSelect.text != "" {
            self.selectedItemsCallBack?([self.yearSelect,self.genreSelect])
            self.dismiss(animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Alert", message: "You have not selected any filter.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // ... Do something
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func dateAction(_ sender: UIButton) {
        
        let filterListView = FilterHelper.openListFilter()
        filterListView.dataList = years
        filterListView.propDisplayName = "year"
        filterListView.selectedCallBack = {(item) in
            print("item select",item)
            self.yearSelect = item
            self.LblDateSelect.text = item["year"] as? String
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.present(filterListView, animated: true, completion: nil)
        }
        
    }
    
    @objc func GenresAction(_ sender: UIButton) {
        let filterListView = FilterHelper.openListFilter()
        filterListView.dataList = genres
        filterListView.propDisplayName = "name"
        filterListView.selectedCallBack = {(item) in
            print("item select",item)
            self.genreSelect = item
            self.LblGenre.text = item["name"] as? String
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.present(filterListView, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
