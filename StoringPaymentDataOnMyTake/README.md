# Storing Payment Data On iOS: My Take
## Do you know what I'll say

In an interview or during your usual work, you might need to think about how you would store user credentials. You might even go so far as to consider how you might store payment data. 
Let's take a look at this in a little bit of detail.

# The ideas
My intuition for most security questions on the device is this:
don't store it unless you really have to

Particularly when it comes to payment data. In terms of retail Apps I would encourage most product owners to look at using a third-party payment solution (Stripe is excellent) and although the payment process can look native (you're not sending a user to a website for example) you aren't actually processing the payment on device and certainly shouldn't be storing the details on the device at all.
This removes the security aspects of needing to store payment data on a device (and answers further questions about transportation if the user has several iOS devices or an iPhone and an iPad, for example).
I will concede that there is some data you might want to store on device and keep secure. There might even be some cases where you want to store payment details and the like in your App and you are responsible for making those calls (you're the programmer!).
Just make sure you make the best choice you possibly can with the available information
So here are the choices when you wish to store data securely on a user's device. 
[Keychain](https://medium.com/swlh/secure-user-data-with-keychain-in-swift-337684d6488c): This is an encrypted storage container for storing data like passwords and crypto keys. This is secure, but is only generally used for small pieces of data.
Encryption: To add an extra layer of security, you can also encrypt small pieces of data before storing it in the Keychain. For encryption, you can use a strong symmetric encryption algorithm like [AES](https://medium.com/@stevenpcurtis/aes-for-ios-developers-using-swift-8e9988cfb312) with a unique key for each user.
[Files](https://medium.com/@stevenpcurtis/ios-data-protection-apis-using-swift-fde1d88a806c): You could use encryption for files in the iOS secure enclave, using the secure Data APIs.

These are competing ideas to storing the data securely (say Apple Pay on the device) and then send the data to a payment server using HTTPS and TLS to make sure that the data is not intercepted over a network.

# My thoughts
It is tempting to store such data in the keychain. If you really want to feel like the data is secure you might want to use [AES](https://medium.com/@stevenpcurtis/aes-for-ios-developers-using-swift-8e9988cfb312) before storing the data in the keychain. Since the amount of data to be stored is small, storing the data is files is likely overkill. 
However, since storing credit card information is sensitive generally I'd use a payment gateway rather than writing something bespoke myself. This can handle payment information without storing the sensitive data on the App. 
If I worked for a company where the card is part of the product I might expect the data to be returned from the server. I'd treat this information securely and make sure we would have appropriate protections against Man in the Middle attacks (something like [App Pinning](https://betterprogramming.pub/secure-ios-apps-through-app-pinning-4106d31c5d7d)) and other security features.
Of course, depending on what the end-goal of the software actually is.
As usual…choices mean "it depends".

# Conclusion
Everything in terms of development becomes an answer of it depends. However, there are some concrete coding skills and knowledge that is important when progressing as an iOS developer.
I hope this article helps you in achieving your goals.
