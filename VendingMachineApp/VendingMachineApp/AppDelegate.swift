//
//  AppDelegate.swift
//  VendingMachineApp
//
//  Created by joon-ho kil on 6/25/19.
//  Copyright © 2019 길준호. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vendingMachine = VendingMachine()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let stock = UserDefaults.standard.object(forKey: "stock") as? [Int]
        let balance = UserDefaults.standard.object(forKey: "balance") as? Int
        
        if let stock = stock {
            for (index, amount) in stock.enumerated() {
                vendingMachine.supply(index, amount: amount)
            }
        }
        
        if let balance = balance {
            vendingMachine.insertCoin(balance)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        let stock = vendingMachine.getStockList()
        let ableDrinks = vendingMachine.getAbleDrinks()
        let balance = vendingMachine.getBalance()
        
        let stockToSave = ableDrinks.map { (drink) -> Int in
            return stock[drink] ?? 0
        }
        
        let balanceToSave = Int("\(balance)")
        UserDefaults.standard.set(stockToSave, forKey: "stock")
        UserDefaults.standard.set(balanceToSave, forKey: "balance")
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

