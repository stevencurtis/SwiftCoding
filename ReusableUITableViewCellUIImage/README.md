# Reuse a UITableViewCell as a UIView 
## Mix 'em up!

Roll on the next article!

Difficulty: Beginner | Easy | **Normal** | Challenging
This article has been developed using Xcode 11.4.1, and Swift 5.2.2

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* The article assumes you are comfortable with creating a [UITableViewCell Programmatically](https://stevenpcurtis.medium.com/create-a-uitableviewcell-programmatically-88d453380dcf), and I've used the techniques in [that article](https://stevenpcurtis.medium.com/create-a-uitableviewcell-programmatically-88d453380dcf)

## Terminology
Storyboard: A visual representation of the User Interface of an Application
UITableViewCell: The visual representation of a single row in a table view
UIView: An object that manages the content for a rectangular area on the screen

# The Problem
It would be great to have a `UITableViewCell` and `UIView` to share the same assets - that is have the same backing `UIView` so we can represent the cell in a `UITableView` and in a `UIView` with the same backing `UIView`.

That's not explained well. Let me show you an example. 

We have a `UITableView` with a number of `UITableViewCell` instances which are subclassed.

[](Images/Table.png)<br>
 and when the user clicks on one of the cells they can see a `UIViewController` that contains a `UIView` version of the tableview.
[](Images/detail.png)<br>

Easy, right?

# The opportunity
Reusability is really important. We do not wish to rewrite code to create (effectively) the same `UIView` - that would mean double the amount of maintenance and there are issues around making sure all of the views are the same.

The *solution*? Use the same `UIView` as the backing for both the `UITableViewCell` and the `UIView`. 

# The code
## ViewController
```swift
class ViewController: UIViewController {
    var names: [String] = ["James", "Tom", "Abhay"]
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func loadView() {
        let view = tableView
        self.view = view
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.name = names[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProfileTableViewCell else { fatalError() }
        cell.setup(name: names[indexPath.row])
        return cell
    }
}
```

## ProfileTableViewCell
```swift
class ProfileTableViewCell: UITableViewCell {
    @IBOutlet private var profileView: ProfileView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(name: String) {
        profileView.configure(with: name)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
    }
    
}
```

## ProfileView
```swift
class ProfileView: UIView {

    @IBOutlet var profileView: UIView!
    @IBOutlet weak var chevronImageView: UIImageView!
    
    @IBOutlet weak var circularImageView: CircularView!
    @IBOutlet weak var nameLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("ProfileView", owner: self, options: .none)
        addSubview(profileView)
        profileView.frame = self.bounds
        profileView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        circularImageView.image = UIImage(named: "man")
        let chevron = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        chevronImageView.image = chevron
        chevronImageView.tintColor = .black
    }

    func configure(with name: String) {
        nameLabel.text = name
    }
}
```

## CircularView
```swift
@IBDesignable
class CircularView: UIView {
    var internalUIImageView: UIImageView?
    var shapeLayer: CAShapeLayer?
    var image: UIImage?
    {
        didSet { setupView() }
    }

    // init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // init from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        internalUIImageView = UIImageView()
        self.addSubview(internalUIImageView!)
        let padding: CGFloat = 10
        internalUIImageView?.translatesAutoresizingMaskIntoConstraints = false
        internalUIImageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        internalUIImageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        internalUIImageView?.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        internalUIImageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
        internalUIImageView?.image = image
        shapeLayer = CAShapeLayer()
    }
    
    override func draw(_ rect: CGRect) {
        drawRingFittingInsideSquareView()
    }
    
    internal func drawRingFittingInsideSquareView() {
        let midPoint: CGFloat = bounds.size.width/2
        let lineWidth: CGFloat = 2
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: midPoint, y: midPoint),
            radius: CGFloat(midPoint - (lineWidth/2)),
            startAngle: CGFloat(0),
            endAngle: CGFloat(Double.pi * 2),
            clockwise: true)
        if let sl = shapeLayer {
            sl.path = circlePath.cgPath
            sl.fillColor = UIColor.clear.cgColor
            sl.strokeColor = UIColor.lightGray.cgColor
            sl.lineWidth = lineWidth
            layer.addSublayer(sl)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        shapeLayer?.removeFromSuperlayer()
        drawRingFittingInsideSquareView()
        guard let imgView = self.internalUIImageView else {return}
        imgView.layer.cornerRadius = imgView.frame.size.height / 2
        imgView.clipsToBounds = true
    }
}
```

## DetailViewController

```swift
class DetailViewController: UIViewController {

    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ProfileView()
        view.configure(with: "James")
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.heightAnchor.constraint(equalToConstant: 150),
            view.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
```

This is all in the repo, as is the "problem" code

# Conclusion
That's it! If you want to reuse a view from a `UITableView` in a `UIView` you can do just that by using this code and article.

I hope that this proves of use to you, and you enjoy your coding journey.

All the best!

[Twitter](https://twitter.com/stevenpcurtis) 
