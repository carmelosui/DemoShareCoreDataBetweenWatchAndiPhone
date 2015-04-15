# DemoShareCoreDataBetweenWatchAndiPhone
This is a demo that shows how to share a core data persistent store between watch extension and iPhone app  

You need to have a valid developer ID which is enrolled in iOS developing programme.

You need to fix the compile error in CoreDataManager.swift by turn on the "App Group" capability in both target:  

- ShareCoreDataBetweenWatchAndiPhone  
- ShareCoreDataBetweenWatchAndIPhone WatchKit Extension

Be sure to use the same app group name and paste the name to CoreDataManager.swift  

Then you can build and run, use the iPhone app to fill some data, and then launch the watch app to see the data appears in watch.

All is done!