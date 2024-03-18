# README

How To Use:

* Make sure that redis and postgres has been installed.

* Run rails server

* Run bundle exec sidekiq

* Open /sidekiq/cron

* Wait until one hour, or click enqueue now on hourly_worker_job

* Open the homepage, there should be numbers of random user data

* Go back to /sidekiq/cron and click enqueue now on daily_worker_job

* Open the daily report records

* The daily report records should be filled with the new data.

* Go back to list users page, try to delete one contact

* Open the daily report, the number and average age for male/female will be changed.
