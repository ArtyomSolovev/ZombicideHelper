//
//  ViewController.swift
//  ZombicideHelper
//
//  Created by Артем Соловьев on 04.02.2021.
//

import UIKit

class ViewController: UIViewController {
    var levelGame = 0
    var deck = Array<Int>()
    var cards: Int!
    var breakpoint = 0

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var rectangle1: UIImageView!
    @IBOutlet weak var breakpointIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breakpointIcon.alpha = 0
        image.layer.cornerRadius = 40
        image2.layer.cornerRadius = 40
        rectangle1.isHidden = false
        deck = stirDeck(into: cards)
        image.image = UIImage(named: "Зомби0\(deck[i - 1])")
        image2.image = UIImage(named: "Зомби0\(deck[i])")
        checkRectangle(delta: 1)
        swipesObservers()
    }
    func checkRectangle(delta: Int){
        UIView.animate(withDuration: 0.3) {
            if 40 < self.deck[self.i - delta] && self.deck[self.i - delta] <= 54{
                self.rectangle1.alpha = 0.0
            } else{
                self.rectangle1.alpha = 1.0
            }
        }
    }
    func stirDeck(into: Int) -> [Int] {
        var array = Array(1...into)
        array.shuffle()
        return array
    }
    func checkLevel(levelGame: Int) {
        switch levelGame {
        case 1:
            UIView.animate(withDuration: 0.5){
                self.rectangle1.transform = CGAffineTransform(translationX: 0, y: 0)
                self.rectangle1.tintColor = .white
                }
        case 2:
            UIView.animate(withDuration: 0.5){
                self.rectangle1.transform = CGAffineTransform(translationX: 0, y: -100)
                self.rectangle1.tintColor = .yellow
                }
        case 3:
            UIView.animate(withDuration: 0.5){
                    self.rectangle1.transform = CGAffineTransform(translationX: 0, y: -200)
                    self.rectangle1.tintColor = .orange
                }
        case 4:
            UIView.animate(withDuration: 0.5){
                    self.rectangle1.transform = CGAffineTransform(translationX: 0, y: -300)
                    self.rectangle1.tintColor = .red
                }
        default:
                    break
            }
    }
    func swipesObservers(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)

    }
    var upper = false
    var downer = false
    var i = 1
    @objc func handleSwipes(gester: UISwipeGestureRecognizer){
        switch gester.direction {
        case .right://назад
            if i > 1 + breakpoint{
                checkRectangle(delta: 2)
                UIView.animate(withDuration: 0.5) {
                    self.image.transform = CGAffineTransform(rotationAngle: .pi/8).translatedBy(x: 600, y: -100)
                }
                self.image.transform = .identity
                image.image = UIImage(named: "Зомби0\(deck[i - 2])")
                image2.image = UIImage(named: "Зомби0\(deck[i - 1])")
                i-=1
                upper = false
                downer = false
            }
        case .left://вперед
            if i < cards{
                checkRectangle(delta: 0)
                UIView.animate(withDuration: 0.5, animations: {
                    self.image.transform = CGAffineTransform(rotationAngle: -.pi/8).translatedBy(x: -600, y: 100)
                }){ [self] _ in
                    image.transform = .identity
                    image.image = UIImage(named: "Зомби0\(deck[i - 1])")
                    if i != cards{
                        image2.image = UIImage(named: "Зомби0\(deck[i])")
                    }
                }
                i+=1
                upper = false
                downer = false
            }
        case .up:
            if upper == true && levelGame < 4{
                levelGame += 1
                checkLevel(levelGame: levelGame)
                upper = false
            } else {
                upper = true
            }
            downer = false
        case .down:
            if downer == true && levelGame > 1{
                levelGame -= 1
                checkLevel(levelGame: levelGame)
                downer = false
            } else {
                downer = true
            }
            upper = false
        default:
            break
        }
        
    }
    @IBAction func swipe(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            UIView.animate(withDuration: 0.5, animations: {
            self.view.transform = CGAffineTransform(translationX: 400, y: 0)
        }){ [self] _ in
            performSegue(withIdentifier: "back", sender: nil)
        }
        }
    }
    @IBAction func pressedBreakpoint(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
        breakpointIcon.alpha = 1
        UIView.animate(withDuration: 1.0){
            self.image.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.breakpointIcon.transform = CGAffineTransform(rotationAngle: .pi)
            self.breakpointIcon.alpha = 0
        }
        breakpointIcon.transform = .identity
        breakpoint = i - 1
        }
        image.transform = .identity
    }
    @IBAction func reset(_ sender: UIRotationGestureRecognizer) {
        if sender.state == .ended {
        breakpoint = 0
        UIView.animate(withDuration: 1.0, animations: {
                self.rectangle1.alpha = 0.0
        self.image.transform = CGAffineTransform(rotationAngle: .pi).scaledBy(x: 0.1, y: 0.1)
        self.image2.transform = CGAffineTransform(rotationAngle: -.pi).scaledBy(x: 0.1, y: 0.1)
            }){[self] _ in
                i = 1
                deck = stirDeck(into: cards)
                image.image = UIImage(named: "Зомби0\(deck[i - 1])")
                image2.image = UIImage(named: "Зомби0\(deck[i])")
                UIView.animate(withDuration: 1.0, animations:{
                    self.image.transform = .identity
                    self.image2.transform = .identity
                })
                checkRectangle(delta: 1)
            }
    }
    }
}

