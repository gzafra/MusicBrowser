# MusicBrowser

Simple app that queries iTunes API to display a list of songs and play them.

## Solution

The app features a VIPER architecture with 2 modules (scenes); one for browsing songs and the other to display details and play the track. The first view requests the data from iTunes API when a search is performed and displays the results in a table view. Each item can be navigated to see more details and play the preview of the song as well as share it.

### Considerations

- RequestManager is a simple library to create HTTP requests without much overhead. See: https://github.com/gzafra/SimpleRequestManager

- Pods used: For this app I have decided to only use a pod to load images asynchronously. The pod used is KingFisher. Also note that this pod is not in the .gitignore list and thus will be downloaded from the repo. If more pods were to be added it would be wise to add them to the .gitignore so the repo doesn't grow too much.

- For the project structure I have decided to split it in 3 layers (presentation, domain, data) and within these, for the specific modules and one for common / shared content.

- Audio part of the app is VERY simplified and more logic should be moved into a Player specific class instead of the interactor. Also a shared player would be avisable so we can keep the song playing everywhere.

- For the query I have added a field to specify only music instead of creating different data models for the different type of items that can be returned.

- For the UI I have used both programmatically created Views and Xib files. Both have their advantages and disadvantages.

### TODOs

- UI wise the app could be much better. Data in the cells should be displayed in a better visual way. Maybe using force touch or similar to display additional data in a modal. For this case I have decided to keep it simple.

- More tests are needed as test coverage is still low and some areas of the code left untested.

