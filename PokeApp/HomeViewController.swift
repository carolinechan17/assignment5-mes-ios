//
//  HomeViewController.swift
//  PokeApp
//
//  Created by Caroline Chan on 12/11/22.
//

import UIKit
import Alamofire
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var pokeCollectionView: UICollectionView!
    
    var pokeData: [Pokemon]? {
        didSet {
            self.pokeCollectionView.reloadData()
        }
    }
    
    let imageURL = "https://img.pokemondb.net/artwork/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPokeData()
    }
    
    func getPokeData() {
        AF.request("https://pokeapi.co/api/v2/pokemon").responseDecodable(of: PokemonModel.self) { response in
            switch response.result {
            case .success(let result):
                self.pokeData = result.pokemons
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPokeDetail":
            let vc = segue.destination as? PokeDetailViewController
            if let pokemon = sender as? Pokemon {
                vc?.pokemon = pokemon
            }
        default:
            break
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokeData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = pokeCollectionView.dequeueReusableCell(withReuseIdentifier: "PokeViewCell", for: indexPath) as? PokeViewCell else { return UICollectionViewCell(frame: .zero)}
        
        if let pokemon = self.pokeData?[indexPath.item], let name = pokemon.name {
            cell.pokeLabelView.text = name.capitalized
            cell.pokeImageView.sd_setImage(with: URL(string: self.imageURL + name + ".jpg"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = pokeCollectionView.frame.size.width/3 - 15
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if var pokemon = self.pokeData?[indexPath.item], let name = pokemon.name {
            pokemon.imageURL = self.imageURL + name + ".jpg"
            performSegue(withIdentifier: "showPokeDetail", sender: pokemon)
        }
    }
}
