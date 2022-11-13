//
//  PokeDetailViewController.swift
//  PokeApp
//
//  Created by Caroline Chan on 13/11/22.
//

import UIKit
import Alamofire
import SDWebImage

class PokeDetailViewController: UIViewController {

    @IBOutlet weak var pokeImageDetail: UIImageView!
    @IBOutlet weak var pokeLabelDetail: UILabel!
    
    @IBOutlet weak var baseExperienceLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var HPLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var pokemon: Pokemon?
    var detail: PokemonDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokeDetail()
        setDesc()
    }
    
    func setDesc() {
        self.title = pokemon?.name?.capitalized
        self.pokeLabelDetail.text = pokemon?.name?.uppercased()
        self.pokeImageDetail.sd_setImage(with: URL(string: pokemon?.imageURL ?? ""))
    }
    
    func getPokeDetail() {
        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: URL(string: pokemon?.url ?? "")!)
        AF.request(urlRequest).responseDecodable(of: PokemonDetail.self) { response in
            switch response.result {
            case .success(let result):
                //MARK: Set description
                self.baseExperienceLabel.text = "Base experience: \(result.baseExperience ?? 0)"
                self.heightLabel.text = "Height: \(result.height ?? 0)"
                self.weightLabel.text = "Weight: \(result.weight ?? 0)"
                
                //MARK: Set status
                self.HPLabel.text = "HP: \(result.stats?[0].baseStat ?? 0)"
                self.attackLabel.text = "Attack: \(result.stats?[1].baseStat ?? 0)"
                self.defenseLabel.text = "Defense: \(result.stats?[2].baseStat ?? 0)"
                self.speedLabel.text = "Speed: \(result.stats?[5].baseStat ?? 0)"
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
