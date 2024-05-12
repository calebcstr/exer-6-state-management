## Han Caleb D. Castro
### 2021-32350 | CMSC23 UV-4L
### Exercise 6: State Management in Flutter

### About
- An online shopping applicatation wherein you can browse within a catalog page of items
- the application includes a cart feature wherein you can review all the items you added within the catalog
- lastly, a checkout feature for which you can purchase all items in the users cart 

### Code
- Created three folders, model, provider, and screens
    - the model folder has all the basic classes for the apps 
        - the item class for example has a name, a price, and a quantity regarding on whether how many times a user adds it into their cart
    - the screens folder has all the visible screens of the application
        - specifically screens for the catalog, cart, and checkout
    - the provider folder has all the methods for transporting items within the screens
        - this includes methods such as adding an item to the cart, while also the method for clearing the items of the cart and after checkout
- the main dart file meshes all the routes and screen of the entire application


### Challenges
- Quite easier than the previous exercise
    - Having a lot of trouble though in checkout, specifically displaying the message "No items in checkout if the cart is empty
