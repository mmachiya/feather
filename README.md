# CSC 308/309: Feather
For individuals who are concerned with their facial skin, especially young adults, _Feather_ is an innovative, groundbreaking AI-powered software that recommends personalized selections of products, and logs the progression of facial health; unlike Curology, _Feather_’s recommendations are not subscription-based and allow the user to pick and choose their favorite products and routines.
### Setting up Environment for Development
1. Need to add steps here
2. insert steps

### Running Project Components

### Running Tests

Developers should follow the following style guide:
https://github.com/linkedin/swift-style-guide

## Static Source Code Analysis Report
Static Source Code Analysis Report can be found [here](https://github.com/mmachiya/feather/wiki/Static-Source-Code-Analysis-Report)
## Software Tests
### Testing Strategy Document
Testing Strategy Document can be found [here](https://github.com/mmachiya/feather/wiki/Testing-Strategy-Document)
### Unit/Integration Tests
   An attempt was made to complete unit testing for this project. However, we discovered that much of our business logic relies on built in functions provided and/or required by Swift. Most of our Swift code involves feeding data pulled from the database or inputted by the user into a Swift function. We realized that it is very difficult and almost counter-intuitive to be testing such functions because it is not our logic, but Swift logic. When left without such functions, we determined it was impossible to reach 50% code coverage. 
### Acceptance Tests
wiki link -> tests in github

1. User Log-In
As a user, I want to be able to save my profile in an account so that I can save and potentially transfer my information.
Acceptance Criteria
The system should take users to the conditions questionnaire if it is their first time signing up. 
The system allows users to login using either Google or Facebook.
The system remembers users and builds a profile for a user so their information is saved after finishing the                 questionnaire. 

Scenario: I want to be a new user 
GIVEN: I access app on a new device
WHEN: I log into my account
THEN: I should be able to transfer my information

2. Keep Track of my Progress
As a novice to skin care, I want to have a journal feature so that I am able to keep track of my progress with different products.
Acceptance Criteria: 
The system should store a gallery of photos that you uploaded.
The system should showcase the photos in chronological order.
Users should be able to see what products were in use when the photo was taken.
Users should be able to make free notes about their day on the journal entry

Scenario: creating a daily journal entry
GIVEN: I am logged into the app
WHEN: I finished my skincare routine
THEN: I should be able to take a picture of my face and have the entry be associated with my current routine
AND: I should be able to make notes about any other factors that affect my skin that day

Scenario: editing a daily journal entry
GIVEN: I am logged into the app
WHEN: I made a mistake on my prior entry
THEN: I should be able to click on the incorrect entry and make edits to it

3. Product details
As an app user, I want to see specific use instructions and ingredient details for products that are recommended to me.
Acceptance Criteria:
The system should show the product with the use instructions and ingredient details.
The system should direct a user where to buy a product. 

Scenario: Recommendation Questionnaire Completed
GIVEN: I have filled out the recommendation questionnaire 
WHEN: I access a specific product from the recommendations
THEN: I am shown the specific use and instructions and ingredient details
AND: I am offered an option to check out other products

Scenario: Incomplete Questionnaire
GIVEN: I have not completed or done the questionnaire
WHEN: I check my list of recommended products
THEN: I am shown that I have not completed the questionnaire
AND: I am offered the option to complete the questionnaire


## Continuous Integration
Project CI page can be found [here](https://travis-ci.org/mmachiya/feather)

