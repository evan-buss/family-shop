# family-shop

A collaborative weekly shopping list for families.

## Early Screenshots

<img src="https://github.com/evan-buss/family-shop/blob/master/images/home.png" height="600">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="https://github.com/evan-buss/family-shop/blob/master/images/list.png" height="600">



## Mobile Application

The mobile application is written in Dart using the Flutter framework from Google.

I decided to use Flutter because it is cross-compatible with both Android and IOS. This is my first real project with 
flutter and I think it has real potential.

## Backend API

The backend API is written in C# using the open-source .Net Core from Microsoft. .Net Core runs on both Windows and Linux
and uses C# which is very similar to Java, making learning it very easy. I also like the Entity Framework which is used
for ORM.

## Deployment

The API uses Docker containers to make it easy to deploy to a web server. The dev and production environments are exactly
the same. There is a "shop_api" container which contains the server itself and it runs on port 5001. There is also a 
separate container running a PostgreSQL server that the api persists data to. 

## Docker Commands 
- docker-compose build (build both images)
- docker-compose up (run both containers)
  - Access the API on localhost:5001
- docker-compose down -v (remove old database volumes)
  - You must remove the old volumes if you make any structural changes
