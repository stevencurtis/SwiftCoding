# Play Video in a UICollectionView
## Right in the cell

I thought I'd make a project. 

Can I play a video in a UICollectionViewCell? You know what? I can!

This is a video about how to do just that!

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br>
This article has been developed using Xcode 12.5, and Swift 5.4

## Prerequisites
* You'll need to either be able to write [an iOS application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) or write some Swift code in [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)

## Keywords and Terminology
UICollectionView: An object that manages an ordered collection of data items and presents them using customizable layouts
UICollectionViewCell: The on-screen cell for the UICollectionView type

# This Article
Wouldn't it be great if you could play video in a `UICollectionViewCell`, you know, like Instagram does it (and I have written an [article about](https://stevenpcurtis.medium.com/create-instagrams-pinch-to-zoom-using-swift-16084415b186))

This article shows you how to do just that!
[rec.mp4](Images/rec.mp4)<br>

# This Implementation
It is pretty much an ordinary `UICollectionView`, and in this implementation I've implemented this programatically. 

## Playing a video in a cell
We use a `PlayerView` class that is responsible for instantiating the `AVPlayerLayer`, and this is implemented as:

```swift
class PlayerView: UIView {

    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
    
        return layer as! AVPlayerLayer
    }

    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
    
        set {
            playerLayer.player = newValue
        }
    }
}
```

which is then called in the subclassed collection view, which I've called `SubclassedCollectionViewCell`:

```swift
class SubclassedCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    var playerView: PlayerView = {
        var player = PlayerView()
        player.backgroundColor = .lightGray
        return player
    }()
    
    var videoPlayer: AVPlayer? = nil

    func playVideo() {
        guard let path = Bundle.main.path(forResource: "AppInventorL1Setupemulator", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        videoPlayer?.playImmediately(atRate: 1)
        playerView.player = videoPlayer
    }
    
    func stopVideo() {
        playerView.player?.pause()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
```

## Only play a video when it is visible
The magic here takes place in `func scrollViewDidScroll(_ scrollView: UIScrollView)`, where we can use `indexPathsForVisibleItems`.

Effectively what is happening here is I want to only play the video if the `CollectionViewCell` is wholly visible in the `UICollectionView`.  

Yes, magic is a bit an an exaggeration, but here is the code:

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let visibleCells = self.collectionView.indexPathsForVisibleItems
        .sorted { top, bottom -> Bool in
            return top.section < bottom.section || top.row < bottom.row
        }.compactMap { indexPath -> UICollectionViewCell? in
            return self.collectionView.cellForItem(at: indexPath)
        }
    let indexPaths = self.collectionView.indexPathsForVisibleItems.sorted()
    let cellCount = visibleCells.count
    guard let firstCell = visibleCells.first as? SubclassedCollectionViewCell, let firstIndex = indexPaths.first else {return}
    checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
    if cellCount == 1 {return}
    guard let lastCell = visibleCells.last as? SubclassedCollectionViewCell, let lastIndex = indexPaths.last else {return}
    checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
}
func checkVisibilityOfCell(cell: SubclassedCollectionViewCell, indexPath: IndexPath) {
    if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
        let completelyVisible = collectionView.bounds.contains(cellRect)
        if completelyVisible {cell.playVideo()} else {cell.stopVideo()}
    }
}
```

# Conclusion
I hope this article has been of help to you. If you wish to write an Instagram clone, you could combine this article with my [Instagram article](https://stevenpcurtis.medium.com/create-instagrams-pinch-to-zoom-using-swift-16084415b186)).

Yes, playing video is not necessarily the easiest thing to place in a `UICollectionViewCell`, but also make sure that it only does so when visible within the collectionview. The solution? That's this guide. I hope that it's been of help to you in some way.

You've also got my stuttering video as part of the repo, but that's another thing right?

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
