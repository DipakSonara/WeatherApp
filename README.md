# WeatherApp

The goal of this assignment is to evaluate your problem-solving skills, UX judgement and code quality.
Weather, everybody wants to know how it is going to be during the week. Will it be rainy, windy, or sunny? Luckily for us, in the information age, there are open APIs to retrieve information about it.


For this assignment you will be using the API from: http://openweathermap.org/api. The API key is provided at the end of the statement, or you can request your own by registering on the website for free.

### Requirements : Xcode 14.x

iOS minimum version : iOS 16.0

Device Support : All iPhones/iPads/iPods running iOS 15.x and higher

Orientation : Portrait and Landscape

Swift version : Swift 5

## Project can be run from Weather.xcodeproj file in Weather folder.


Screenshots
![Simulator Screen Shot - iPhone 14 Pro - 2023-10-20 at 14 50 42](https://github.com/DipakSonara/WeatherApp/assets/6499767/7a7c8472-a784-4fbe-8e90-6b95b76df948)
![Simulator Screen Shot - iPhone 14 Pro - 2023-10-20 at 14 50 46](https://github.com/DipakSonara/WeatherApp/assets/6499767/c4cbc2fc-c0ba-498f-bf7f-846404f0cf3b)
![Simulator Screen Shot - iPhone 14 Pro - 2023-10-20 at 12 59 47](https://github.com/DipakSonara/WeatherApp/assets/6499767/0a124c95-90ab-40e7-97ac-af5faf0bd29f)
![Simulator Screen Shot - iPhone 14 Pro - 2023-10-20 at 14 50 36](https://github.com/DipakSonara/WeatherApp/assets/6499767/6379adde-7756-442f-b439-b2e9366c8204)


## Asumptions

There is no downtime of server.

## Source Code Walkthrough

Source code follows MVVM design pattern.

Model
  - TodayWeather : Holds the attributes of current day weather for given locaiton.
  - ForecastResponse : Holds the attributes of next 5 days weather for given locaiton.

View
  - HomeView : Responsible for list for weather information of searched locations
  - CityScreenView : Responsible for display details informaton of weather.
  - ForecastWeather :  Resposible for displaying next 5 days forecast
  - WebView : Responsible for Steps for How to use the app
 
ViewModel 
  - HomeViewModel : Responsible to retrive data from api from and pass it to HomeView
  - CityScreenViewModel : Responsible to process data and pass it to CityScreenView
  - ForecastViewModel : Responsible to process data and pass it to ForecastView

ApiClient
  - Holds the information of all the apis used in app
    


