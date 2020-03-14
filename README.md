# CSC 308/309: Feather
For individuals who are concerned with their facial skin, especially young adults, _Feather_ is an innovative, groundbreaking AI-powered software that recommends personalized selections of products, and logs the progression of facial health; unlike Curology, _Feather_’s recommendations are not subscription-based and allow the user to pick and choose their favorite products and routines.
### Setting up Environment for Development
1. Make sure you have a Mac and have installed Xcode
2. Clone this repo and build 

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

1. User Log-In  
As a user, I want to be able to save my profile in an account so that I can save and potentially transfer my information.  
Acceptance Criteria  
The system should take users to the conditions questionnaire if it is their first time signing up.  
The system allows users to login using either Google or Facebook.  
The system remembers users and builds a profile for a user so their information is saved after finishing the                 questionnaire.  

Scenario: I am a new user with a different device.   
GIVEN: I access app on a new device   
WHEN: I log into my account  
THEN: I should be able to transfer my information  

Scenario: I am a returning user, and have previously logged out.   
GIVEN: I access app on my usual device.  
WHEN: I log into my account  
THEN: I should skip the profile setup and go directly to the main menu.  

Scenario: I am a returning user opening the app again.  
GIVEN: I access app on my usual device and am still logged in.  
WHEN: I open the app.  
THEN: I should be taken to the last screen I was on, or the main menu.  

Scenario: I am a new user.  
GIVEN: I access the app on my device and there is no existing data for me in Firebase.  
WHEN: I open the app.  
THEN: I should be taken to the profile setup.  
  
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
AND: I should be able to see the picture of my face along with any old pictures in the journal screen.

3. Product details  
As an app user, I want to see specific use instructions and ingredient details for products that are recommended to me.  
Acceptance Criteria:  
The system should show the product with the use instructions and ingredient details.  
The system should direct a user where to buy a product.   

Scenario: Recommendation Questionnaire Completed  
GIVEN: I have filled out the recommendation questionnaire   
WHEN: I access the reccomendation feature from the main menu
THEN: I am shown the reccomendations tailored to my preferences.

4. Firebase  
As an app user, I want my information to reside on an external server instead of on my phone. 
Acceptance Criteria:  
The system should add a user's profile information to a specific document in Firebase.
The system should be able to overwrite, read, and write the user's information in Firebase.

Scenario: Profile completed    
GIVEN: I have filled out the intitial profile while making a new account  
WHEN: I finish the profile and am shown to the main menu  
THEN: The system should push my profile data to the Firebase along with my unique ID.  


Scenario: Restart profile  
GIVEN:  I have filled out the initial profile and my information is in Firebase  
WHEN: I click the restart profile button on the main menu  
THEN: I should be taken to the profile setup screen again  
AND:  The system should overwrite my existing profile data in the Firebase  
## Continuous Integration
Project CI page can be found [here](https://travis-ci.org/mmachiya/feather)

