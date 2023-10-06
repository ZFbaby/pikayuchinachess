//
//  ViewController.swift
//  Example
//
//  Created by hengyu on 2017/2/13.
//  Copyright © 2017年 hengyu. All rights reserved.
//

import UIKit


let someGameFen: String = "position fen 9/9/3k5/9/9/9/4R4/3A5/4K4/8r b - - 0 1 moves i0i1 e1e0 i1i0 e0e1 i0i1 e1e0 i1i0 e0e1 i0i1 e1e0";
let someGameUCI: String = "position fen rnbakabnr/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/RNBAKABNR w - - 0 1"
let someGameUCI1: String = "position fen rnbakab2/9/1c5c1/p1p1p1p1p/9/9/P1P1P1P1P/1C5C1/9/2BAKAB2 w - - 0 1"

class ViewController: UIViewController, EngineManagerDelegate {
    
    let engineManager: EngineManager = EngineManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        engineManager.delegate = self
        engineManager.gameFen = someGameFen
        engineManager.startAnalyzing()

        let time = DispatchTime.now() + DispatchTimeInterval.seconds(2)
        DispatchQueue.global().asyncAfter(deadline: time, execute: {
            self.engineManager.gameFen = someGameUCI
            self.engineManager.startAnalyzing()
        })
        
        let time1 = DispatchTime.now() + DispatchTimeInterval.seconds(4)
        DispatchQueue.global().asyncAfter(deadline: time1, execute: {
            self.engineManager.gameFen = someGameUCI1
            self.engineManager.startAnalyzing()
        })
        
//        Timer.scheduledTimer(withTimeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>, block: <#T##(Timer) -> Void#>)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: EngineManagerDelegate
    
    func engineManager(_ engineManager: EngineManager, didReceivePrincipalVariation pv: String) {
        print("PV: \(pv)")
    }
    
    func engineManager(_ engineManager: EngineManager, didUpdateSearchingStatus searchingStatus: String) {
        print("Searching status: \(searchingStatus)")
    }
    
    func engineManager(_ engineManager: EngineManager, didReceiveBestMove bestMove: String?, ponderMove: String?) {
        if let bestMove = bestMove {
            print("======Best move is \(bestMove)=====")
        } else {
            print("No available moves")
        }
    }
    
    func engineManager(_ engineManager: EngineManager, didAnalyzeCurrentMove currentMove: String, number: Int, depth: Int) {
        
    }
}

