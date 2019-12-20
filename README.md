# Fur-ever

## Application Description

Fur-ever is an iOS application that implements the [Petfinder API](https://www.petfinder.com/developers/).\
The web services that are used in the application are as follow:

* getAnimals
```
GET https://api.petfinder.com/v2/animals
```
This API call returns a list of animals in the Petfinder database that fit the criteria given in the query parameters, and is used to return a list of adoptable pets based on the search queries provided by the user.

* getAnimal
```
GET https://api.petfinder.com/v2/animals/{id}
```
This API call returns details for a specific animal with the given ID in the path, and is used in the application to display information on a single pet that the user selects from the list of adoptable pets.

* getOrganizations
```
GET https://api.petfinder.com/v2/organizations
```
This API call is used to display a list of organizations based on the user's search parameters.

Fur-ever allows users to search for adoptable pets in two scenarios:
1. **Search by Location**: A user selects a type of pet and input a location to do the search on. Then, the application will return a list of adoptable pets (with an image and name for each animal) that fit these search parameters. The user can then change their search location or apply filters on these results.

  By selecting one of the animals on the list, the user will be redirected to a page that contains detailed information about that animal, including:
  * gender
  * size
  * age
  * coat length
  * breed(s)
  * how well the pet does in its environment, i.e. whether the pet is
    - good with children
    - good with other dogs
    - good with other cats
  * attributes, i.e. whether the pet is
    - house-trained
    - spayed/neutered
    - declawed
    - has special needs
    - up to date with shots
  * distance from the pet's location to the user's location
  * contact information for the shelter/organization that the animal is currently housed at
  * a link to the animal's full profile on the Petfinder website


2. **Search by Organization**: A user can search for an organization or a shelter based on keywords in the name or location. The application will then return a list of organizations/shelters that fit the user's search parameters. If the user selects one of the organizations in the list, they will be redirected to a page that contains the specific organization's information, including:
  * contact information
  * distance from the organization's location to the user's location (if given)
  * a link to the organization's full profile on the Petfinder website

A notable feature in Fur-ever is the filter functionality in the animal results. When users are presented with a list of adoptable pets from the `Search by Location` scenario, they can filter these results by the size, gender, age, breed or distance of the pets. Users can also change the type of animal they're doing the search on in the filters page. If the filters are applied, the application will return a new list of animals that match the newly-applied filters. If the user changes their mind and decides not to apply new filters or change any existing filters, they can opt to cancel the filter selection, and they will be redirected back to the original, unmodified search results.

Another useful feature in the app is that user can contact an organization/shelter directly from within the app, by:
* calling their number,
* getting directions to their address, and/or
* sending an email to their email address.

## Evaluation

### Heuristic Evaluation

In his book _Designing the User Interface: Strategies for Effective Human-Computer Interaction_, Shneiderman defined eight golden rules, one of which is "Strive for consistency"<sup>1</sup>. I believe that my front end complies well with this principle. There is consistency between the two different search flows such that users perform a similar sequence of actions in both. There is also consistency between the app and other standard iOS applications to reinforce the learnability metric. Besides, there are clear instructions on actionable buttons so that new users would not have to spend a long time trying to figure out what they can do on each page.

In addition, the overall look and feel of the design is uniform, which is also in accordance with the "Strive for consistency" golden rule. Shneiderman encouraged the use of consistent color<sup>1</sup> throughout the design and the _iOS Human Interface Guidelines_ suggested the use of complementary colors throughout the app<sup>3</sup>. While designing my front end, I made sure that it follows these guidelines. I believe that accompanied by the cuteness of the pets, the use of the same color scheme throughout the app makes it aesthetically pleasing to the average user.

Another important principle that both Nielson<sup>2</sup> and Shneiderman<sup>1</sup> emphasize is the "Prevent Errors" golden rule. The Fur-ever front end generally follows this principle well. When text fields are empty, search buttons are disabled to avoid any unpredictable errors in the API calls. In the two different flows, different error messages are shown when the list of results from the API calls is empty to help users realize ways to obtain more results. For example, when there are no animals shown in the `Search by Location` scenario, users are asked to either reduce the number of filters they have or change their search location. On the other hand, if there are no animals for a specific organization in the `Search by Organization` scenario, users are informed that there are simply no adoptable pets at that organization.

Furthermore, there are clearly marked exits throughout the app such that the app complies with one of Shneiderman's golden rule to "permit easy reversal of actions"<sup>1</sup>. The "back" and "cancel" buttons on many pages of the app allow users to undo any previous actions or discard any current changes quickly and efficiently.

Nevertheless, the Fur-ever app is not without flaws. The most notable flaw is that due to the Petfinder API's restrictions, users can only enter their location by either zipcode or in the form of _city, state_. Although this is hinted at via the text field's placeholder text, the _city, state_ format might not be intuitive to the average user. When a user inputs the wrong format, the app throws a generic API `Network error`. Therefore, it is impossible to predict the error and provide a better error message to the user, and this is a clear violation of Nielson's "Good error messages" principle<sup>2</sup>. An alternative would be allowing the user to simply input a city, and appending the state abbreviation to the query in the API call, based on where the city is. I determined that this would be beyond the scope of this assignment, and therefore did not attempt to resolve this potential issue.

Overall, I believe that the Fur-ever app has good usability. The app is effective in conveying my mental model of the system to the end user via clear instructions for each action and search flow. There are minimal opportunities for the user to commit an unexpected error, and even when an error is encountered, the user can easily dismiss the error and reverse their actions to continue using the app.

### Usability Metrics

#### Learnability

To measure the learnability metric, I chose four users with ages ranging from 11 to 20, who have not seen or used the app before, and are unfamiliar with iOS applications. I asked them to complete the following two tasks on the app without giving them any further instructions.

<!-- Times: 44, 21, 25, 24-->
* Search for an adoptable dog in their local area, and find the contact information of the shelter where the dog is housed at - Average time taken: **28.5 seconds** (Standard deviation: 9.07 seconds)

<!-- Times: 21, 17, 16, 53-->
* Search for adoptable pets at an _SPCA_ closest to them - Average time taken: **26.75 seconds** (Standard deviation: 15.27 seconds)

#### Satisfaction

To measure the satisfaction metric, at the end of completing their tasks, I asked the four users to rate, on a scale of 1 to 10, how much they enjoyed performing the tasks on the app. Below are the scores obtained:

Scores: 8, 9, 10, 9.5\
Average satisfaction: **9.125**

Based on the measurements taken above, I believe that my front end performed well for my chosen metrics. In my original usability metric forecast, I predicted that learnability will be the strongest metric for my design and I believe that this holds true in the final product. When performing the tasks above, the four users were consistently presented with clear choices of action so they did not spend a long time trying to figure out what they can do on each page. Therefore, even though they had not used or seen the app before, they spent a short time on average to perform the two tasks. The standard deviation for the second task is comparatively large due to an outlier in the test users. One of the users, perhaps due to their unfamiliarity with mobile applications, did not know to tap on one of the results in the list of organizations in order to be redirected to its profile. This is, however, unlikely to happen with the average user that has basic knowledge of mobile applications.

The satisfaction scores given by the four users are all on the high end of the scale. I believe that this is due to the overall aesthetic of the app and the general purpose of its functionality. Adopting a pet is generally an action that provides joy and a sense of fulfillment. While performing this action, the users were presented with a consistent color scheme throughout the app and a myriad of adorable animal pictures. I believe that both the pleasing aesthetic of the app and the action of helping animals in need generated a great sense of satisfaction for all four of the users.

It should be noted that all four of the users chosen above put in their zipcode while typing in the location search field and thus did not encounter an error for not following the _city, state_ format that was mentioned in [Heuristic Evaluation](#heuristic-evaluation).

I believe that the process of designing, evaluating the design then implementing it helped me improve on the weaker metrics of my initial design. For example, in my first usability metric forecast, I predicted that my design's weakest metric will be efficiency. My original design did not incorporate native iOS functionalities into the app so that users can call or email shelters directly from within the app, instead of having to copy and paste the phone number/email. Keeping this in mind, I strived to improve this metric when I was implementing my front end. I ended up integrating these functionalities into the app, and I believe that this drastically improves the efficiency metric for my app.

### Recap

Overall, I believe that my front-end performs well on the usability metrics defined by Nielson<sup>2</sup>, especially on the learnability and satisfaction metrics that I measured. The app performs well in the two tasks that a user can carry out and requires minimal time for a new user to get accustomed to the app and perform any useful work. The filter feature also allows for expanded use of the app for the more experienced users.

I believe that the functionalities of this app for the two primary tasks, given the scope of the Petfinder API, are at its full potential. Therefore, potential improvements for the app, aside from removing the location format restriction previously mentioned, could include new features that further appeal to the average user by improving the efficiency and errors metrics.

## References
1. Shneiderman, Ben. Designing the User Interface: Strategies for Effective Human-Computer Interaction. Addison-Wesley, 2010.
2. Nielsen, Jakob. Usability Engineering. Morgan Kaufmann, 1994.
3. "Color". _iOS Human Interface Guidelines - Apple Developer_, Apple Inc, https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/. Accessed 1 December 2019.
