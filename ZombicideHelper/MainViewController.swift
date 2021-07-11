//
//  MainViewController.swift
//  ZombicideHelper
//
//  Created by Артем Соловьев on 08.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var BlackPlague: UIImageView!
    @IBOutlet weak var Wulfsburg: UIImageView!
    
    @IBAction func pressedBP(_ sender: UIButton){
        UIView.animate(withDuration: 0.5, animations: {
            self.Wulfsburg.isHidden = true
            self.BlackPlague.transform = CGAffineTransform(scaleX: 2, y: 2).translatedBy(x: 0, y: 100)
            self.BlackPlague.alpha = 0
        }){ [self] _ in
            performSegue(withIdentifier: "detailSegue", sender: nil)
        }
        }
    @IBAction func pressedW(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.BlackPlague.isHidden = true
            self.Wulfsburg.transform = CGAffineTransform(scaleX: 2, y: 2).translatedBy(x: 0, y: -100)
            self.Wulfsburg.alpha = 0
        }){ [self] _ in
            performSegue(withIdentifier: "detailSegue", sender: nil)
        }
    }
    @IBAction func unwindSegueToMainScreen(segue: UIStoryboardSegue){
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainControl = segue.destination as? ViewController else{return}
        if view.viewWithTag(1)?.isHidden == true{
            mainControl.cards = 54
        } else{
            mainControl.cards = 62
        }
    }
}
