Movienizer 
==========

MDS Project

Get project from GitHub
--------------------

* Install git if you don't already installed

        sudo apt-get install -y git

* Create a locat directory for the project

        mkdir Movienizer
    
* Configure git in this directory

        git init
        git remote add origin https://github.com/IoannaP/movienizer.git
        git checkout -b version-0.1

* Download the project from GitHub

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
        
  * Press **Y** if a conflict error raised

Usage
-----

* Start server

        rails server
        
* Start your favourite browser and open this address

        localhost:3000
