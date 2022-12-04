# README

## About GoodNightApi

### How to use GoodNightApi?
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

** You can check the path, action, and params in all specs easily.

### Tech side questions you may ask
1. Why grape?
- Lighter than Rails API
- This project will only have API in the future.
- Ref: https://scoutapm.com/blog/rails-api-vs-sinatra-vs-grape-which-ruby-microframework-is-right-for-you

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
  
## Other info
* Ruby version
2.4.7

* Database
PostgreSQL
rake db:migrate
rake db:seed # test data in local


## Other Refs
1. About how to decdie the index column
https://stackoverflow.com/questions/1449459/how-do-i-make-a-column-unique-and-index-it-in-a-ruby-on-rails-migration

2. How to build Grape API in your project?
https://qiita.com/Esfahan/items/90feb3ae39dde51f95fa
https://www.toptal.com/ruby/grape-gem-tutorial-how-to-build-a-rest-like-api-in-ruby

3. About the Concern Class in Rubt
https://www.akshaykhot.com/how-rails-concerns-work-and-how-to-use-them/

4. About CQRS
https://medium.brobridge.com/%E6%B7%BA%E8%AB%87-cqrs-%E5%AF%A6%E7%8F%BE%E6%96%B9%E6%B3%95-3b4fcb8d5c86

5. About divding layers
https://ithelp.ithome.com.tw/articles/10222162
