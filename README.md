Synap Weighin
=============

As requested, here is my completion of the Synap coding challenge.  The updated application can be found [here on Heroku](https://gentle-cliffs-67283.herokuapp.com/).

### Discussion
You will likely notice that I've added a number of comments to the model, controller and interactor files.  Upon opening the repo the first thing I did was go through these files and make my own annotations.  I like to do this as it helps my understanding of what does what, and serves as a reference.

The next step was to study the schema, migrations and models to build a UML diagram of the database.  This was not a complete model as there were some attributes which were not important (mostly in the user table) but it gave me a good place to start from.  Throughout building the app I used this as a reference, adding and modifying it in order to keep the various aspects clear.

Perhaps the most difficult part of this for me was building the seed file.  The various database tables were not always clear and I found myself having to experiement with what went where.  I'm not certain that I have it correctly setup even now, and I've no doubt that there are faster ways to implement the seed.

Finally, there are my modifications.  The first thing I did was add some basic navigation to the header, this was so I could get around easilly.  Next I created the neccessary migrations and models for the League feature and implemented a decorator to sort the records by 'up by' value.  After that came building the views and hooking the various pieces together to produce what you see here.

![Database Diagram](https://github.com/cugamer/weighin/blob/master/DB%20Diagram.png)

### Next steps
* First thing would be to add tests for the new features.  A good amount was changed here and it needs to be covered.
* Next would be to refactor the implementation.  This is an initial build and I'd want to clean the code up prior to sending it into the world.
* Additional features
    * Some extra styling, even if it's just getting the nav menu all in a row.
    * Implement an interface so that individual players can be added to and moved between leagues.
    * Bugfixes.  I can see at least one issue where in the various player names appear repeatedly in the checkin dropdown box.  This would require investigation and elimination, as well as stakeholder input to clarify desired behavior.
* Feedback.  I'd want as much input from as many sources as possible as to hwo to make this a better application with a cleaner implementation.  

And with that, I'm looking forward to hearing your feedback.  Thank you for a good challenge that got me out of my normal routine and allowed me to improve as a developer.
