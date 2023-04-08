# The Readers-Writers Problem
## Deadlocked!

![Photo by Ricky  Kharawala on Unsplash](Images/0*z4aBupDI_gf6M0uO.jpeg)<br/>
<sub>Photo by Ricky Kharawala on Unsplash<sub>

# At the same time? Concurrency?
Threads contain processes and run concurrently. Concurrency means that two tasks can start, run and complete in overlapping time periods. Parallelism is about performing work at the same time.

[Concurrency as a diagram](Images/concurrency.png)<br>
[Parallelism as a diagram](Images/parallelism.png)<br>

Time slicing can enable *concurrency* if only one thread or core is available, or *concurrency* could benefit from parallelism. Software needs to work concurrently with other task (for example system tasks, or multitasking Apps) whether it truly works in parallel or not.

If tasks did not support concurrency they could not be stopped and restarted, which might be a rather large problem for computers that run web browsers (or have applications that make several [API](https://medium.com/@stevenpcurtis.sc/endpoint-vs-api-ee96a91e88ca) calls).

# At the same time? A disaster
What if we have a constraint on a resource - something like a disk. So we want to access this disk as we run processes in parallel (perhaps through several **threads**).

Now imagine we represent our tasks through **threads** that access these resources. One thread reading while another one is writing.

To put the problem succinctly - what should happen when one thread wants to write to a resource while another thread wishes to read from the same resource? 

This is known as the **readers–writers problem**.

# Solving the problem
Theoretically, the solution to the readers-writers problem is as follows: 

A writer should have exclusive access to the object in question when writing, meaning that no other readers nor writers should access the object during writing.

A reader has non-exclusive access to the object - meaning that multiple readers can operate at the same time.

# The result
No reader is ever kept waiting - unless a writer is in control of the object.

The solution should be deadlock-free (that is when each member of a group is waiting for another member of the group to take an action, resulting in a locked resource).

# Conclusion
This article has rather briefly covered the Reader-Writers problem.

I can almost hear you - You want a practical example. Well here is an [article about thread-safe arrays](https://medium.com/@stevenpcurtis.sc/swift-thread-safe-arrays-ed1541301eb3). Isn't that nice!

Any questions? You can get in touch with me here
