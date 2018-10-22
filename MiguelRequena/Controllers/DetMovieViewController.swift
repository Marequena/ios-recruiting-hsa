//
//  DetMovieViewController.swift
//  MiguelRequena
//
//  Created by Consultor on 21-10-18.
//  Copyright © 2018 marequena. All rights reserved.
//

import UIKit

class DetMovieViewController: UIViewController {

    
    @IBOutlet var imageMovie: UIImageView!
    
    @IBOutlet var titleMovie: UILabel!
    
    @IBOutlet var yearMovie: UILabel!
    
    @IBOutlet var genreMovie: UILabel!
    
    @IBOutlet var iverviewMovie: UILabel!
    
    @IBOutlet var favoriteBtn: UIButton!
    
    var idMovie = 0
    
    var ServiceMovie = MovieService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func markFavorite(_ sender: UIButton) {
    }
    
    
    func configure(){
        ServiceMovie.getMovieDet( idMovie: self.idMovie) { data, error in
            self.titleMovie.text = data?.original_title
            let url = URL(string: "https://image.tmdb.org/t/p/original" + (data?.poster_path)! ?? "")
            let dataimg = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            self.imageMovie.image = UIImage(data: dataimg!)
            self.iverviewMovie.text = data?.overview
            self.yearMovie.text = data?.release_date.prefix(4).description
            if favoritesClass.markFavorite(id: (data?.id)!) {
                self.favoriteBtn.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            }else{
                self.favoriteBtn.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            }
            var generos = ""
            for gene in (data?.genres)!{
                generos += gene.name + " "
                
            }
            self.genreMovie.text = generos
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
