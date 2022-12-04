# README

## About good_night_api

### Tech side questions you may ask
1. Why grape?
- Lighter than Rails API
- This project will only have API in the future.

2. Why didn't I exclude out the model and migration from this project?
- For the better CI/CD, I think we should. But, this project will not need CI/CD in the future.
 
3. Why do not develop Domain Model?
- It barely contains complicated business logic.

4. Why do I designs API files with three files?
- I imagine this APP will have three main pages.
- And, each file is responsible for each page.  
 
5. Why doesn't have validation for the params?
- I think the validation depends on how the UX design does.
- And, now, there is no clear UX design, so I skip this part first.
  
 ### Function Side
1. click-in operation
  - User can click-in with choosing sleep/wake_up.
  - User can add in a specific time with a specific type. (Not finished)
  - User can destroy last click-in data because of mis-click/regret. (Not finished)

2. Follow/unfollow system
  - User can see all users. (Not finished)
  - User can follow other users. And, when the user starts follow, it generates the connection.
  - User can disconnect the connection
  
3. See friend's record system
  - User can see the friend-list to select whose sleep records he/she is going to check.
  - User can see a specific friend's sleep records.
  

## Other info
* Ruby version
2.4.7

* Database creation
PostgreSQL

* Database initialization
rake db:migrate
bundle exec rake db:seed # test data in local
