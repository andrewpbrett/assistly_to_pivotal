UPDATE 2/23/2012: Assistly is moving their endpoints to desk.com. If you've already installed this app prior to 2/23, you'll need to update and push the new code to Heroku:

    cd myapp
    git pull origin master
    bundle update
    git push heroku master

This is a little Sinatra app that allows you to integrate your Assistly tickets into Pivotal. 

Inspired by [airbrake_to_pivotal](https://github.com/steveh/airbrake_to_pivotal).

Uses the excellent assistly gem by [zencoder](https://github.com/zencoder/assistly) though right now we're on my fork of the fork by [bobbytables](https://github.com/bobbytables/assistly) - only diff is that we use desk.com instead of assistly.com so we don't get shut down when they complete the transition. 

1. Grab a copy of the source

        git clone git://github.com/andrewpbrett/assistly_to_pivotal.git

2. Create a Heroku app

        heroku create myapp

3. Add required config from your assistly API page.

				heroku config:add ASSISTLY_SUBDOMAIN=mysubdomain
				heroku config:add CONSUMER_KEY=your_key
				heroku config:add CONSUMER_SECRET=your_secret
				heroku config:add OAUTH_TOKEN=your_token
				heroku config:add OAUTH_TOKEN_SECRET=your_token
				
4. Add optional config to filter on only certain channels or labels

				heroku config:add ASSISTLY_LABELS=labels				# default is "" - retrieves all labels
				heroku config:add ASSISTLY_CHANNELS=channels		# default is "email"
				heroku config:add ASSISTLY_DAY_COUNT=count			# number of days of cases to retrieve; default is 7 to avoid timeout errors
				
5. Pick a username and password for Pivotal to use

        heroku config:add HTTP_BASIC_USERNAME=pivotal
        heroku config:add HTTP_BASIC_PASSWORD=password

6. Deploy to Heroku

        git push heroku master

7. Test you're getting XML back

        open http://myapp.heroku.com/

8. Add the integration to Pivotal. From the "Configure Integrations" page, add an "Other" integration.

    * **Name:** Assistly
    * **Basic Auth username:** What you picked for HTTP_BASIC_USERNAME
    * **Basic Auth password:** What you picked for HTTP_BASIC_PASSWORD
    * **Base URL:** https://[your_subdomain].assistly.com/agent/case/
    * **Import API URL:** http://myapp.heroku.com/
    * **Active: Yes**

9. From the "More" menu of Pivotal Tracker you should see "Assistly"

10. Buy me a beer.
