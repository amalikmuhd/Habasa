//
//  Networking.swift
//  Habasa
//
//  Created by Mo Abdulmalik on 26/06/2019.
//  Copyright © 2019 Abdulmalik Muhammad. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingWithAlamofire {
    private static let _instance = NetworkingWithAlamofire()
    
    
    static var instance: NetworkingWithAlamofire {
        return _instance
    }
    
    func downloading(mediaUrl: String, downloadfileName: String, downloadProgress: UIProgressView) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let fileUrl = docUrl.appendingPathComponent("\(downloadfileName).mp4")
            
            return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
            
        }
        
        Alamofire.download(mediaUrl, to: destination).responseData { (resp) in
            if let mediaData = resp.value {
                //get the data and now something with it
                print(mediaData)
            }
            }.downloadProgress { (progress) in
               downloadProgress.progress = Float(progress.fractionCompleted)
                
        }
    }
    
}
