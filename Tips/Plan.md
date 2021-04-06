# System Design

# Criteria
Defining components in order to provide the required functionality, solving the problem of repeated code.
Do not allow massive view controllers!
Allow code to be tested
Cope with Intermittent connection issues

# Code smells
Regidity, fragility


**Pagination**
If we download messages over an API. This can be implemented either within a REST or a GraphQL API.

We can use a system like `messages(first: 2, offset:2)` which would as for the next two items in a list.

However what about the case where messages keep being sent? 
**ID-based**
We can improve and use and ID to as for the next two messages after a particular message
`messages(first:2 after:$messageID)`
**Time-based**
We can perform a similar trick with a timestamp
`messages(first:2 after: now()`

**Cursor**
Using a cursor is the most powerful of these options.
`messages(first:2 after:$messageCursor)`
This gives a further abstraction, if the pagination model changes in the future we will still be compatible. We should remember that cursors are opaque and the format should not be relied upon (suggesting a base64 encoding).

![Images/socketapi.png](DeleteImages/socketapi.png)<br>

![Images/apidesign.png](DeleteImages/apidesign.png)<br>


## Non-Domain Specific functionality
Services sit of top of the UI and MVC (or other App architecture), and frequently consist of services such as storage and networking. Using these services we can avoid duplicated code.

Frameworks can be used across applications.

Other examples of frameworks that can be created are:
* Login services
* Analytics
* Location services

However care should be take on more-domain independent functionality such as handling notifications and storage. It should also be noted that this isn't the only solution to making your App modular (by any means), and usually only makes sense when Applications become larger
