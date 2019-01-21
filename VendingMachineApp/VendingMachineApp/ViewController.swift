//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 윤동민 on 15/01/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension UIImageView {
    func setCornerRadius() {
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
    }
}


class ViewController: UIViewController {
    var machine: VendingMachine?
    
    @IBOutlet var drinkImages: [UIImageView]!
    @IBOutlet var drinkLabels: [UILabel]!
    @IBOutlet var addButtons: [UIButton]!
    @IBOutlet var insertButtons: [UIButton]!
    @IBOutlet weak var currentCoin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        machine = appDelegate.machine
        
        initialImage()
        initialLabel()
        initialAddButtonTag()
        initialInserButtonTag()
    }
    
    private func initialImage() {
        for image in drinkImages { image.setCornerRadius() }
    }
    
    private func initialLabel() {
        let menuCount = 6
        let machine: DrawAbleView? = self.machine
        for menu in 1...menuCount {
            machine?.setDrinkLabel(menu, view: self)
        }
        machine?.setCoinLabel(view: self)
    }
    
    private func initialAddButtonTag() {
        var tag = 1
        for button in addButtons {
            button.tag = tag
            tag += 1
        }
    }
    
    private func initialInserButtonTag() {
        var tag = 1
        for button in insertButtons {
            button.tag = tag
            tag += 1
        }
    }
    
    @IBAction func addStock(_ sender: Any) {
        let menu: DrinkCategory
        guard let button = sender as? UIButton else { return }
        switch button.tag {
        case 1: menu = DrinkCategory.bananaMilk
        case 2: menu = DrinkCategory.chocoMilk
        case 3: menu = DrinkCategory.cola
        case 4: menu = DrinkCategory.fanta
        case 5: menu = DrinkCategory.cantata
        case 6: menu = DrinkCategory.top
        default: return
        }
        addEachDrink(of: menu.rawValue)
    }
    
    private func addEachDrink(of menu: Int) {
        let managerMode: ManageableMode? = machine
        if managerMode?.isAbleToAdd(menu: menu) == .success {
            managerMode?.addStock(menu: menu)
            managerMode?.setDrinkLabel(menu, view: self)
        }
    }
    
    @IBAction func insertCoin(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        switch button.tag {
        case 1: insertEach(coin: 1000)
        case 2: insertEach(coin: 5000)
        default: return
        }
    }
    
    private func insertEach(coin: Int) {
        let userMode: UserAvailableMode? = machine
        userMode?.insert(coin: coin)
        userMode?.setCoinLabel(view: self)
    }
}





