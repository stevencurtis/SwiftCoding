## Cleaner UITableViewControllers

![diagram](Images/clean.jpg)

When Xcode generates a default UITableViewController, and it encourages everything to go into this single view controller. This can mean a large class that is difficult to maintain, and yet this is how production code is often shipped. 

It is possible to separate out the dataSource from the view controller, and should be considered as an approach if the controller starts to get too large.

### Prerequisites:

Creating view controllers
Delegate pattern

A standard table view displays a list of items.

All of the following are presented on GitHub 
 
### Standard table view

You can simply add a TableViewController 


<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/standardtable.png" width="" height="">
</p>

and it is essential for us to add the cell identifier. I call this "cell" for this example.

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/cells1.png" width="600" height="">
</p>

Setting up the view controller as a UITableViewController

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/stv.png" width="600" height="">
</p>

The datasource and delegate are hooked up from Interface Builder. 
The required methods set the number of rows for the table view and return the cell for each row. Since I named the embedded cell "cell" this has to match the one in cellForRowAt.

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/tv1.png" width="1000" height="">
</p>

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/tv2.png" width="1000" height="">
</p>

The data array is populated when the view loads

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/da1.png" width="600" height="">
</p>

The whole view controller is here, I also implemented a headerView to maintain consistency in appearance with the other view controllers. https://github.com/stevencurtis/cleantableviews/blob/master/CleanTableViews/StandardTableViewController.swift

## Embedded table view
	
An alternative approach is to embed the table view in a standard view controller. Note that I have to choose a new identifier for the embedded cell, and here I chose "embeddedcell"

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/cells2.png" width="500" height="">
</p>

Which is set up view controller conforming to UITablveViewDataSource and as a delegate of UITableViewDelegate.

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te1.png" width="1000" height="">
</p>

This means that we need to set up an outlet to hook Interface Builder into the view controller.

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te2.png" width="600" height="">
</p>

and ensure that the data source and delegate are set.

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te3.png" width="600" height="">
</p>

It is debatable how much more flexibility thus gives us over the header (and possibly footer) defined in an ordinary UITableViewController.

What is certain, however, is that we have a large class with things that arguably a view controller should not "know about" 

https://github.com/stevencurtis/cleantableviews/blob/master/CleanTableViews/TableEmbeddedViewController.swift

Let us split that out

## A lighter view controller

Similar to the embedded version above, but of course we need an extra file for the data source, and we require a reference to it from our view controller:

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te4.png" width="600" height="">
</p>

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te5.png" width="600" height="">
</p>

The data source will still require cellForRowAt and numberOfRowsInSection.

We have separated the data source into the separate file.
https://github.com/stevencurtis/cleantableviews/blob/master/CleanTableViews/LighterStaticViewController.swift
	
https://github.com/stevencurtis/cleantableviews/blob/master/CleanTableViews/LighterStaticViewDataSource.swift

However, there might be an issue if you want to pass the data from the view controller to the data source. How would we do that?

## A lighter view controller with data in the view controller	

As an example, we can absolutely pass the data from the view controller to the data source.
Within the view controller we will pass our data

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te7.png" width="600" height="">
</p>

which involves creating an initialiser for our data source: 

<p align="center">
  <img src="https://github.com/stevencurtis/cleantableviews/blob/master/te8.png" width="600" height="">
</p>

The completed code is here:

https://github.com/stevencurtis/cleantableviews/blob/master/CleanTableViews/LighterTableViewController.swift

https://github.com/stevencurtis/cleantableviews/blob/master/CleanTableViews/LighterTableViewDataSource.swift


