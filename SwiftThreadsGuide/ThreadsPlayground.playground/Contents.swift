import UIKit


//func longRunningTask() {
//    for i in 1...100000 {
//        sleep(1)
//    }
//}
//
//longRunningTask()

func downloadFile(from url: URL) {
    guard let data = try? Data(contentsOf: url) else {
        print("Error downloading file")
        return
    }
    // Save or otherwise deal with the downloaded file
    print(data)
}

let urlString = "https://picsum.photos/200/300"
downloadFile(from: URL(string: urlString)!)


DispatchQueue.global(qos: .background).async {

}


