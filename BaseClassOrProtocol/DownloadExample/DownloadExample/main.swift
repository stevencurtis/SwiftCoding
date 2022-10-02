//
//  main.swift
//  DownloadExample
//
//  Created by Steven Curtis on 06/05/2021.
//

import Foundation

print("Hello, World!")

// Base Class
class FileDownloadModel {
    var url: String?
}

class AudioDownloadModel: FileDownloadModel {
    
}

let audio = AudioDownloadModel()
audio.url = "test"
print(audio)
