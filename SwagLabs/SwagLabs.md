# Swag Labs End-to-End Automation Test

This project automates the process of logging into the Swag Labs application, adding products to the cart, calculating the total value of the cart, and verifying the total value on the checkout page.

## Project Features

- **Login Automation:** Automates the login process with valid credentials (username: `standard_user`, password: `secret_sauce`).
- **Product Selection:** Adds multiple products to the cart and calculates the total value of the cart dynamically.
- **Checkout Process:** Verifies that the total cart value from the product selection page matches the total value displayed on the checkout page.
- **Cart Validation:** Ensures that the cart's total value is correct and matches across product selection and checkout pages.

## Workflow
1. **Launch Browser:** Opens the browser and navigates to the Swag Labs site.
2. **Login to Application:** Logs in with valid credentials.
3. **Add Products to Cart:** Adds a set of predefined products to the cart.
4. **Calculate Total Cart Value:** Calculates the total value by summing the prices of all added products.
5. **Checkout:** Proceeds to the checkout page and enters shipping information.
6. **Verify Total:** Compares the total cart value from the product selection page with the total value displayed on the checkout page.

## Technologies Used
- **SeleniumLibrary**: For browser automation and interaction with the web elements.
- **Robot Framework**: The automation framework used to create and run the test cases.

## Files in the Project
- **Test Cases**: Contains the end-to-end automation script for adding products to the cart and validating the total.
- **Keywords**: Custom keywords for actions such as launching the browser, logging in, adding products to the cart, and verifying the total.
- **Variables**: Stores the base URL of the Swag Labs application and other reusable values.

## Future Improvements
- Add data-driven testing to handle different sets of products and scenarios.
- Implement error handling for failed login attempts and network issues.
- Integrate the tests with a CI/CD pipeline for automated execution.


