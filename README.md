# GSC Docs
## Project Setup
### Architecture
Our solution, GrubGenie, addresses the challenge of food waste and hunger by facilitating the sale of surplus or nearing expiration food products from smaller-scale vendors to individuals in need. The architecture comprises several high-level components:
- **Frontend:** Flutter was chosen for its exceptional cross-platform compatibility, enabling smooth user experiences on both Android and iOS devices. It handles UI/UX and interactions, utilizing Dart programming language.
- **Backend:** Node.js with Express.js manages server-side operations, handling requests related to the Firestore Database. Firestore, a Google product, offers scalability and real-time data synchronization, following a NoSQL approach for adaptability.
- **Chatbot:** A Flask-based microserver hosts the Gemini API-based chatbot, enhancing user interactions and support capabilities, seamlessly integrated into the system.

### Technologies
- **Frontend:** Flutter, Dart
- **Backend:** Node.js, Express.js
- **Database:** Firestore
- **Chatbot:** Flask, Gemini API

### Platforms
- **Database:** Firestore for scalability and real-time data sync
- **Mapping:** Google Maps API for visual representations and advanced functionalities
- **Chatbot:** Gemini API for enhancing user interactions

## Feedback / Testing / Iteration
### Challenge
The challenge addressed is the intersection of food waste and hunger, primarily aligned with Sustainable Development Goal (SDG) 2: Zero Hunger and SDG 12: Responsible Consumption and Production.

### Feedback
Three specific feedback points from real users:
1. **Acceptance of Concept:** 70% of respondents were open to purchasing expired products at lower costs.
2. **Stock Maintenance:** Users highlighted the importance of real-time inventory updates to ensure app reliability.
3. **Donor Interaction:** Suggestions were made to include a functionality where donors can interact with an AI to maximize donations.

### Implementation Improvements
1. **Real-time Stock Updates:** Modified database architecture to accommodate real-time stock data from stores.
2. **Donor Interaction Feature:** Implemented functionality for donors to interact with an AI for efficient donations.
3. **Inclusive Design:** Explored features like voice activation and kiosk versions for inclusivity.

## Challenges Faced
### Integration of Gemini API
Integrating the Gemini API posed a challenge due to its complexity and unfamiliarity. We dedicated resources to understand the API thoroughly and isolated its functionality into a microservice for focused development.

## Success and Completion of Solution
### Impact
GrubGenie has significantly reduced food waste and alleviated hunger:
1. **Reduced Food Waste:** Surplus food is redirected to those in need, contributing to SDG 12.
2. **Alleviated Hunger:** Access to nutritious food at lower costs addresses SDG 2.
Quantifiable data collected through user surveys and feedback mechanisms validate the solution's effectiveness.

## Scalability / Next Steps
### Future Plans
- **Inclusive Features:** Voice activation, kiosk versions, and language translation for broader accessibility.
- **Scalability:** Deploying on scalable platforms like Google Cloud for seamless performance.
- **Partnerships:** Collaborating with startups and government agencies to increase awareness and reach underserved communities.

![Alt Text](./ReadMe/giphy.gif)

## How to run the Program 
### NodeJs Server
- **cd FirestoreDBNodeJsServer**
- run **npm i** to install all the packages
- **nodemon server.js** to spin up the server at localhost in port 5000
