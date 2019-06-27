//
//  Downloader.swift
//  Habasa
//
//  Created by Mo Abdulmalik on 26/06/2019.
//  Copyright © 2019 Abdulmalik Muhammad. All rights reserved.
//

import UIKit

class Downloader: UIViewController {
    
    let downloadSegue = "Downloader"
    var filename = ""
    var path = ""
    var downloadLoading = UIProgressView()
    
    override func viewDidLoad() {
        print("Is working")
        print(filename)
        print(path)
    }
}
