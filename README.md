# Assignment 1

## Task

- Create a responsive login screen suitable for tablets and all iPhones.
- Send a request to the API to initiate the login process, ensuring all validations are applied.
- Design a Welcome Page that displays the user's details received in the response as pre-filled text fields and dropdown menus.
- Finally, save all this data in the SQLite database.

## Approach to Do this

- Create a login page with all necessary constraints.
- Call the API to obtain the response.
- Store the response in `UserDefault` for data retrieval at any time within the application.
- Create the Welcome Page using StackView and apply all the necessary constraints to it.
- Retrieve data from the `UserDefault` and set it when the View loads. Then, using the package, save the data into the SQL database.

## Package link

```link
https://github.com/stephencelis/SQLite.swift
```

## Screenshot

### login page

![login page](https://i.imgur.com/ag7ZxWh.png)

### Welcome page

![Welcome page](https://i.imgur.com/WY6TDpY.png)

### Success Message

![Success Message](https://i.imgur.com/FQSYU1y.png)

### Alert Message

![Alert Message](https://i.imgur.com/orWN36j.png)

### UserData

![UserData](https://i.imgur.com/7eTrNZD.png)
