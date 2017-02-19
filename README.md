# PlugLife
App for finding plug types around the world

This app uses a CSV of a lsit of regions and plug types. Plug type source data is from the International Electrotechnical Commission.
The data available online does not also reflect the reality on the ground, so eventual user feedback would be nice to incorporate into the app.

The user's base country is selected based onthe device 'Locale.current', meaning the region settings of the phone itself rather than its physical geographical position (GPS)
A user is able to change this base region once in the app. A view of all available regions is presented which the user can browse (UI CollectionView).

On select, a new view controller is loaded displaying the plug types.
