# Actors in Programming
## The concept

In practice Moore's Law, that single-core processor speeds would double every 18 months is dead. The smaller chips got, the more difficult it became to dissipate that heat and avoid hot-spots on chips.
The solution? We've got to a point where you can have thousands of cores on a GPU. 
This means we have a Sega-Saturn style problem to manage the concurrency. Those bugs? They're the cause of confusion in those who are paid to fix the bugs in their code.
It's time for a new model, and one of them is the actor model.
Rather than getting caught in the weeds for this article we are going to look at this in an abstract sense. This helps since in the model we are introducing in any case the programmer would not know about the environment in which their code runs. 
In a multi-core world it makes sense to write code at a higher level of abstraction so it can be adapted at runtime to the current circumstances.
Essentially this is a configuration-based model of computation. We take into account interaction with an open environment.
In this world we are thinking about physics rather than algebra, a model different from the standard Turing machine.
# The Actor model
This is a conceptual model which can deal with concurrency in the model computational world. 
## The Actor Definition
A fundamental unit of computation. It contains:
- Processing (get something done)
- Storage (remember things)
- Communications (send messages)

They are similar in construction to classes in OO programming languages. However, memory can be shared in classes and this is not available to actors. This brings us onto a vital property of actors.
Actors are isolated from each other, and do never share memory. This means that actors have private state (which naturally cannot be modified by other actors.
Actors require an address in order to be sent messages.

# Actors are abstract
Actors come in systems, and send messages to other actors.
Everything in such a system is an actor. This necessitates the use of addresses in the system. This itself is abstract, because how those addresses are actually implemented is not defined by this model.

# Messages
## Single messages
Conceptually actors send and receive one message at a time*

*Messages can be pipelined in certain cases. So for instance factorial can publish an arbitrary number of messages at the same time in order to develop a recursive output with actors. Since factorial would have an address for itself, recursion could be implemented.

## Receive message
Actors receive messages, and they can:
- create more actors
- send messages to existing actors
- designate what it will do when the next message is received

## A quick example
This is a rather classic example. A checking account.
The account has 5 dollars. If you deposit 6 dollars, when the actor processes the next message it will process with a balance of 11 dollars. The change actually applies to the next message that comes in. 

## Futures
A Future is the address for something that might not yet exist. They are also actors within this model. They can be passed around, can be stored and can be sent in messages.
A Future is a promise something will be done in the future. Perhaps you might think of financial markets. A futures contract is a promise to buy a commodity at a certain contracted time. This is a speculation on the price position of a commodity at a certain time, and on expiration of the contract you must buy the underlying asset. The Future, at some point in the future, becomes real.
A Future that calculates the factorial of 10000000 might take some time. However, a future for that answer can be sent and passed around rather than the value itself providing an asynchronous way to use the result (without it yet being known).

## Addresses
**Capability**
Address is analogous for capability. The capability being that you have the ability to send the actor a message.

## Many to many relationship
Many to many relationship between actors and addresses. Each actor has an address you can send messages to. 1 address can represent many actors if you're replicating. One actor can have many addresses which forwards to one another.

**Comparisons**
Cannot compare actors, all you have is addresses. You cannot tell if you have one actor or many actors behind an address. Like Google keeping their servers behind DNS addresses. Therefore you can't tell if you are talking to a forwarding actor (a proxy) or an actor.

**Order**
A message is delivered at most once. Messages are delivered in arbitrary order.
Since messages from one actor to another don't have guaranteed order, this behaves much like in packet switching.
If you don't get an ack back across machines you could resend the message.
Messages can be futures, which can manifest whenever they are needed.

**Data races and determinism**
I've partially covered determinism and data races: https://medium.com/@stevenpcurtis/data-races-in-programming-350fd434798a
Non-determinism is flipping a coin for the non-deterministic Turing machine, and you have a type of behaviour for each coin flip result. 
Indeterminism is by working things out. It is how something works itself out over time. When we build a web page from packets we don't worry about the order the packets are received, rather we are satisfied that the model will work out over time.
In terms of actors, an Actor sends itself a go message and a stop message when start is sent.
When go is received the counter is incremented. When stop is received the state of the counter is revealed.

[Images/counter.png](Images/counter.png)<br>

Since stop can happen after an arbitrary amount of time, we don't know ahead of time what the counter will be. This is something which cannot be modelled on a nondeterministic Turing machine.

# Conclusion

Want to see the source for this article? Take a look at: https://www.youtube.com/watch?v=7erJ1DV_Tlo&ab_channel=jasonofthel33t.

Thank you for reading.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
