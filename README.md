# PlugLife
App for finding plug types around the world

This app uses a CSV of a lsit of regions and plug types. Plug type source data is from the International Electrotechnical Commission.
The data available online does not always reflect the reality on the ground, so eventual user feedback would be nice to incorporate into the app.

The user's base country is selected based onthe device 'Locale.current', meaning the region settings of the phone itself rather than its physical geographical position (GPS)
A user is able to change this base region once in the app. A view of all available regions is presented which the user can browse (UI CollectionView).

On select, a new view controller is loaded displaying the plug types in a UIScrollView and recommendations pertaining to a user's home plugs are presented in a UITableView.

On selecting any of the items in the ScrollView, a pop-up view controller is displayed with more information about the plug as as well as a list of other regions where the plug is used. The user can select any of these regions which will return to the previous view controller with the new region now being displayed. This can continue indefinitely. 

On the App Store at https://itunes.apple.com/us/app/plug-life/id1200284392?ls=1&mt=8
