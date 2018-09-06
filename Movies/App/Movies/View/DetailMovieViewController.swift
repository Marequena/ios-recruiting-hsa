//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Daniel Crespo on 2/09/18.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet weak var NavBar: NavigationView!
    @IBOutlet weak var ImgViewMovie: UIImageView!
    @IBOutlet weak var LblName: UILabel!
    @IBOutlet weak var LblModel: UILabel!
    @IBOutlet weak var LblGenre: UILabel!
    @IBOutlet weak var TxtViewDescription: UITextView!
    @IBOutlet weak var BtnIsFavorite: UIButton!
    
    let presenter = DetailMoviePresenter()
    var movie = Movie()
    var genres = [Genre]()
    var stateIsFavorite:Bool = false
    static let identifier = "DetailMovie"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavBar.navTitle(title: "Movie")
        NavBar.leftButtonBack(state: true)
        NavBar.LeftCallBack = {state in
            self.goBack()
        }
        
        presenter.attachView(view: self)
        
        presenter.getGenres(genres: movie.genreids)
        Utils.downloadImage(Url: "\(Server.baseImg)\(movie.posterpath)") { (data) in
            self.ImgViewMovie.image = UIImage(data: data)
            self.LblName.text = self.movie.title
            self.LblModel.text = self.movie.releasedate
            self.TxtViewDescription.text = self.movie.overview
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func TouchUpAddFavorite(_ sender: Any) {
        
        stateIsFavorite = !stateIsFavorite
        
        var imageFavorite = ""
        if(stateIsFavorite){
            imageFavorite = "favorite_full_icon"
            if(movie.title != ""){
                RealmService.shared.add(movie)
            }
        }else{
            imageFavorite = "favorite_gray_icon"
        }
        BtnIsFavorite.setImage(UIImage(named: imageFavorite), for: .normal)
        BtnIsFavorite.isUserInteractionEnabled = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailMovieViewController :DetailMovieContract{
    func setGenres(genres: [String]) {
        let genreString = genres.joined(separator: ",")
        
        self.LblGenre.text = genreString
    }
    
    func setEmptyGenres() {
        
    }
    
    func startLoading() {
        self.view.showBlurLoader()
    }
    
    func finishLoading() {
        self.view.removeBluerLoader()
    }
    
}
