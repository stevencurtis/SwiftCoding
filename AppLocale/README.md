# Testing Dependent Swift Code
## Actually Quite Tricky

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>


Have you ever made a rather silly mistake? When coding Swift for your users you probably need a way to allow them to display types of data the way **they** want the data to be displayed.

You'll also want that data to go beyond formatting. This can be crucial when we think about testing. 

So on with the article!

# Looking at the code
Look, I've created a super-easy project so we can see what is going on in the simulator. 

# Changing The Location in The Simulator
Location aware? You'll want you App to know where it is if you're using the Measurement Api (for example).

Let us play pretend. We want to have an App that only displays the current temperature (it's only going to display a hardcoded temperature - remember this is a pretend).

I created a viewModel to display the data (this helps unit testing, which I will do later)

```swift
final class ViewModel {
    func temperature() -> String {
        let temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        return formatter.string(from: temperature)
    }
}
```

Quiz question: So how is the measurement displayed?

*That's right! You can't be certain!*

## The locale (the answer to displaying)
My simulator is setup with the `Locale.current` set to be `en_US`. This means that temperature is displayed in Fahrenheit!

If we want to check how this might display we can edit the scheme of the iOS simulator

(Images/scheme.png)[Images/scheme.png]

Under `Run` and the `Options` tab `United Kingdom` can be chosen.

(Images/appregion.png)[Images/appregion.png]

If I do indeed choose United Kingdom the `Locale` is then `en_GB`.

Perhaps unsurprisingly, the temperature is then displayed as 0°C.

We are setting the scheme in the simulator, this is very nice.

BUT...

# Testing
You are able to change the scheme for the test. However, we want a *variety* of test cases (of course we do).

So if I set up my test class like the following:

```swift
@testable import AppLocale
import XCTest

final class ViewModelTests: XCTestCase {
    func testFunction() {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.temperature(), "32°F")
    }
}
```

I hope you can see the potential problem here. 

**The result depends on the machine you are using. If you've a colleague in a different part of the world than the US (or set the scheme to another locale) the test may well not pass.**

Therefore we have to do better!

What about the following test function?

```swift
func testFunctionLocale() {
    let temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
    let formatter = MeasurementFormatter()
    formatter.locale = .current
    let expected = formatter.string(from: temperature)
    
    let viewModel = ViewModel()
    XCTAssertEqual(viewModel.temperature(), expected)
}
```

This function doesn't compare the raw strings, it goes on better! Since we don't know ahead of time which locale the test will be sun in, we can set the locale of the expected value to `.current`. This gives us security that we are testing the right thing.

That's just how it should be!

# Conclusion

I hope this article has been of help to you. Thinking about your user is a very important part of being a technical developer. If this means you're able to *test* your code adequately your're also a step closer to 

Subscribing to Medium using [this link](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fmembership) shares some revenue with me.
You might even like to give me a hand by [buying me a coffee] (https://www.buymeacoffee.com/stevenpcuri).
If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)

