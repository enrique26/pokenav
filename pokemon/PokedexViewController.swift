//
//  PokedexViewController.swift
//  pokemon
//
//  Created by Enrique Gachuz on 19/03/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    var caughtPokemon : [Pokemon] = []
    var uncaughtPokemon : [Pokemon] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        caughtPokemon =  getAllCaughtPokemon()
        uncaughtPokemon =  getAllUnCaughtPokemon()
        
        tableView.dataSource=self;
        tableView.delegate=self;
        
    }

    @IBAction func mapTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CAUGHT"
        }else{
            return "UNCAUGHT"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return caughtPokemon.count
        }else{
            return uncaughtPokemon.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let pokemon : Pokemon;
        if indexPath.section == 0 {
            pokemon =  caughtPokemon[indexPath.row]
        }else{
            pokemon =  uncaughtPokemon[indexPath.row]
        }
        cell.textLabel?.text=pokemon.name;
        cell.imageView?.image=UIImage(named:pokemon.imageName!)
        return cell
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
