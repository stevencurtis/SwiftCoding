# All Your Outlets Should Be Private
## All your bases are belong to us

The story
Everytime I create a UITableView Xcode helps me out. I create the UITableView and control-drag the Storyboard constraint for the UITableView.
It looks something like this:
@IBOutlet public var tableView: UITableView!
Nice right!
This is the recommended version from the people with clipboards at Apple. It MUST BE RIGHT.
Then, the code review comes. Why are you using private access control here?
I dunno. I clicked and dragged and it came out itself (CLANG).
The Reasoning
It is a good idea to use access control to prevent users of your API misusing your properties.
A good example is if you have a UITableViewCell subclass you might well choose to expose a UILabel.
class MyTableViewCell: UITableViewCell {
@IBOutlet public var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
There’s no problem with this. Except that wherever the MyTableViewCell is used there is direct access to myLabel. That is, other programmers can change the font (including the colours) and in fact any of the properties of the UILabel as they see fit.
You should trust your colleagues, but not that much.
The solution
Make those outlets private. That is:
@IBOutlet private var tableView: UITableView!
and in your view controller nothing bad will (usually) happen — and this will stop bad and unexpected things happening to you.
If you do this on you UITableViewCell subclass you might get something like the following:
class MyTableViewCell: UITableViewCell {
@IBOutlet public var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(text: String) {
         myLabel.text = text
    }
}
see that last function? This is how you can change the text on that lovely UILabel.
This can then be set from your view controller, or UITableViewDataSource by using the following:
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell {
        cell.configure(text: data[indexPath.row])
        return cell
    }
    fatalError()
    }
}
That’s not so easy to read, so hop to the conclusion for a link to the repo. But in any case, I hope you can see you can only access the internal properties using our chosen API. In this case, the function we have chosen for users to use is the only way that the users of our API (and, in this example a UITableViewCell can use the wonderful functionality we provide).
Won’t that be nice?
Conclusion
I hope that this article has helped you out.
So when Xcode work and makes our outlets private they really aren’t helping us out, but rather are making things a bit tricky for us to understand in terms of keeping our API under control, and only visible to users when we chose so.
This means that WE the programmers need to be in control over what the API users of our code (and frameworks) use. Remember that, and code carefully!
This article is backed by a YouTube Video, and a repo link

