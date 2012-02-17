* Use postgres in development and test
* Remove iphone_user_agent? helper if no view uses it
* Searching 2x gives an error
* Move float.rb to a patches or hacks directory

Debt
=======
+ recipes/show.html.erb splits on \n and looks like crap

Stories (+ means higher priority, - is lower, initials are for who requested it)
============================================

In Progress
+ Ingredients separate from directions
  - form for adding ingredients, showing parsed value afterwards
  - allow specifying ingredients that are parsed, or the old way where they are added to preparation

Backlog
AS + Email recipe to friend (no access to app necessary, just nicely formatted in an email)
BW + I'd like to be able to select a few recipes and organize them into a "weekly menu"
BW + I'd like to be able to generate a well organized "shopping list" from the weekly menu.
AS - Add a picture to a recipe (there is just an image url, which isn't shown or anything)
AS - Print on recipe card
AS - Print all (sorted by category, alpha within category)
JS - Add iphone templates for login
JS - Make sure "Using an iPhone?" links work both local and in production
JS - user management, including changing password, adding users

Database Backup
+ heroku pgbackups:capture

