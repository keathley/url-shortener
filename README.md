# STORD URL Shortener Exercise
The goal of this exercise is to create a URL shortener web application in the same vein as [bitly](https://bitly.com/), [TinyURL](https://tinyurl.com/), or the now defunct [Google URL Shortener](https://goo.gl/). It is intentionally open-ended and you are welcome to implement your solution using the language and tech stack of your choice, but the core functionality of the application should be expressed through your own original code. This is your opportunity to show off your design and development strengths to our engineering team.

## Application Requirements

- When navigating to the root path (e.g. `http://localhost:8080/`) of the app in a browser a user should be presented with a form that allows them to paste in a (presumably long) URL (e.g. `https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8`).
- When a user submits the form they should be presented with a simplified URL of the form `http://{domain}/{slug}` (e.g. `http://localhost:8080/h40Xg2`). The format and method of generation of the slug is up to your discretion.
- When a user navigates to a shortened URL that they have been provided by the app (e.g. `http://localhost:8080/h40Xg2`) they should be redirected to the original URL that yielded that short URL (e.g `https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8`).


## Deliverable

- Fork or clone this repository
- Implement your solution, including test cases for your application code. 
- We will execute your code using the `make` targets specified in `Makefile`. Edit the contents of `Makefile` to provide an interface for running and testing your application.
- Include any other notes for our engineering team that you would like regarding your approach, assumptions you have made, how to run your code, how to use your application, etc in a file named `notes.txt`.
- E-mail the point of contact that sent you this exercise. 
  * Include the `Makefile` and
  * A link to a public GitHub or GitLab repository. Note: if your github account is monitored, then create a new github account

## Evaluation
Your submission will be evaluated along the following criteria by the Reviewer
- Completeness - Does your submission meet the Application Requirements and Deliverables specified above?
- Testing - evaluate your use of test coverage to allow for iterative development
- Ease of setup - how easy was it for the Reviewer to setup and run your app
- Front end design - what is your familiarity with html, css, and front-end javascript frameworks; how thoroughly did you consider the User Experience for this application?
- Technical design - separation of concerns, adherence to certain 12 factor App principles, knowledge of backend frameworks, security concerns, etc.
-- Note on the Database-  We would like you to use a persistent datastore. Please be ready to speak to your choices here.
### Notes:  
- The hope is that this exercise will take a qualified candidate 2-4 hours.  Please let us know how much time you spent so that we can iterate based on your feedback.  
- The good news is that we will not subject you to a code exercise on a whiteboard when you are on-site!
- You can use any language because we are looking for your strengths as an engineer, more so than your strengths with any particularly technology.  Please show us your strengths for coding, testing, user experience, technical design, and attention to detail. 
- Curious about the performance requirements for this exercise?  This should be able to handle at least 5 requests per second.  During the on-site interview, you can talk about how you might change your design if the system had to scale beyond that
- Thank you for the time you are spending as a candidate with STORD!
