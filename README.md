Assignment Overview:
Create a mobile application that fetches and displays a list of products from an external API.
The app should consist of two main screens and demonstrate your ability to handle JSON data, navigate between screens, and display information in a user-friendly format.
 
API Endpoint:
Use the following endpoint to fetch product data: https://dummyjson.com/products?limit=100
 
First Screen - Categories Overview:
 
Display Product Categories:
Extract and display a list of unique product categories from the fetched data. Each category should be represented only once.
Category Card Details:
For each category, create a card that displays:
The category name.
The thumbnail of the first product in that category.
The total number of distinct products in the category.
The total sum of all products in stock for that category.
Navigation:
Implement a touch event on each category card. When a user taps on a card, the app should navigate to the second screen, passing the selected category's information.
 
Second Screen - Category Details:
 
List of Products in Selected Category:
Display a list of all products within the selected category.
Product Item Details:
Each product item in the list should display:
The product's name.
The product's image.
The product's price.
The available stock quantity.
 
 
Technical Requirements:
 
The app should be built using native tools for Android (Kotlin) or iOS (Swift).
Implement proper error handling for the network requests.
Write clean, maintainable, and well-documented code.
(Optional) Implement caching to store the products data locally, reducing the need for repeated network requests.
 
