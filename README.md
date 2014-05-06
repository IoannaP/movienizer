Movienizer 
==========

Your online movie organizer

Unix Install Guide
=================

Get the project from GitHub
--------------------

* Install git

        sudo apt-get install -y git

* Create a local directory for the project

        mkdir Movienizer
    
* Configure git inside the directory

        git init
        git remote add origin https://github.com/IoannaP/movienizer.git
        git checkout -b version-0.1

* Pull the project

        git pull origin version-0.1


Install and configure dependecies
--------------------

* Install dependecies

        bundle install
    
* Create and configure the database

        rake db:migrate

* Configure dependecies

        rails generate bootstrap:install static
        rails generate devise:install
        
  * Press **Y** if you are raised a conflict

Usage
-----

* Start server

        rails server
        
* Start your favourite browser and access the local server

        localhost:3000
