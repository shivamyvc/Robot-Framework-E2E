*** Settings ***
Library    SeleniumLibrary
Library    ..//..//setup_utility.py
Resource   ..//..//Utility_Resource.robot

*** Variables ***
${baseUrl}    https://www.saucedemo.com/v1/index.html  # Base URL of the Swag Labs site
${ChromeDriver}   E:\\Shivam\\Projects\\Driver\\chromedriver.exe  # Path to ChromeDriver
@{product_List}    Sauce Labs Backpack    Sauce Labs Bike Light    Sauce Labs Onesie    Sauce Labs Fleece Jacket    Test.allTheThings() T-Shirt (Red)  # List of products to add to the cart

*** Test Cases ***
Test Add To Cart Features
    Launch Browser  # Open the browser and launch the Swag Labs site
    Login Application  # Login to the application with valid credentials
    ${Total_cart_value}    Convert To Number        0  # Initialize total cart value to 0
    FOR     ${ProductName}     IN     @{product_List}  # Loop through the list of products
        ${item_price}    Select And Add Product    ${ProductName}  # Add product to the cart and get its price
        ${item_price}=    Convert To Number    ${item_price}[1:]  # Convert item price to number (remove the dollar sign)
        ${Total_cart_value}=    Evaluate    ${item_price}+${Total_cart_value}  # Add the item's price to the total cart value
    END
    Log To Console   ${Total_cart_value}  # Log the calculated total value of the cart
    ${checkout_value}=    Check Out And Validate Total  # Proceed to checkout and get the total value from the checkout page
    ${Total_cart_value}=    Convert To String     ${Total_cart_value}  # Convert the total cart value to string for comparison
    Should Contain    ${checkout_value}    ${Total_cart_value}  # Validate that the checkout total matches the calculated value

*** Keywords ***
Launch Browser
    ${service}=    Get Service    ${ChromeDriver}  # Get the ChromeDriver service
    Open Browser  url=${baseUrl}      browser=chrome     service=${service}  # Open the Swag Labs website using Chrome
    Maximize Browser Window  # Maximize the browser window for better visibility

Login Application
    Wait Until Element Is Visible    class=login_logo  # Wait until the login logo is visible
    Input Text    id=user-name    standard_user  # Input the username (standard user)
    Input Password    id=password    secret_sauce  # Input the password (secret_sauce)
    Click Element    id=login-button  # Click the login button
    Wait Until Element Is Visible    class=product_label  # Wait for the products page to load

Select And Add Product
    [Arguments]    ${Product_Name}  # Accept product name as an argument
    Wait Until Element Is Visible    xpath=//div[contains(text(),'${Product_Name}')]//ancestor::div[@class='inventory_item']  # Wait until the product element is visible
    ${item_price}=    Get Text        xpath=//div[contains(text(),'${Product_Name}')]//ancestor::div[@class='inventory_item']//div[@class='inventory_item_price']  # Get the price of the product
    Log To Console    ${Product_Name}:${item_price}  # Log the product name and its price
    ${addToCart}=      Get Webelement      xpath=//div[contains(text(),'${Product_Name}')]//ancestor::div[@class='inventory_item']//button[text()='ADD TO CART']  # Get the "Add to Cart" button
    Scroll Into View    ${addToCart}    behavior=smooth  # Scroll to the "Add to Cart" button
    Click Element    ${addToCart}  # Click the "Add to Cart" button to add the product to the cart
    [Return]    ${item_price}  # Return the item price for further processing

Check Out And Validate Total
    ${cartIcon}=    Get Webelement    id=shopping_cart_container  # Get the shopping cart icon element
    Scroll Into View    ${cartIcon}    behavior=smooth    block=start  # Scroll to the cart icon
    Click Element    ${cartIcon}  # Click the shopping cart icon to view the cart
    Wait Until Element Is Visible    xpath=//a[text()='CHECKOUT']  # Wait for the checkout button to be visible
    ${checkOutBtn}    Get Webelement    xpath=//a[text()='CHECKOUT']  # Get the checkout button
    Scroll Into View     ${checkOutBtn}     smooth  # Scroll to the checkout button
    Click Element     ${checkOutBtn}  # Click the checkout button
    Wait Until Element Is Visible    class=subheader  # Wait for the checkout page to load
    Input Text    id=first-name    Ross  # Fill in first name
    Input Text    id=last-name    Romero  # Fill in last name
    Input Text    id=postal-code    123134  # Fill in postal code
    Click Element    xpath=//input[@value='CONTINUE']  # Click the continue button to proceed to the next page
    Wait Until Element Is Visible    class=subheader  # Wait for the summary page to load
    ${subTotal}=  Get Webelement    class=summary_subtotal_label  # Get the subtotal value from the summary page
    Scroll Into View    ${subTotal}    smooth    end  # Scroll to the subtotal element
    ${totalCartValue}=    Get Text    ${subTotal}  # Get the total cart value
    Log To Console    ${totalCartValue}  # Log the total cart value for verification
    ${finishBtn}=     Get Webelement    xpath=//a[text()='FINISH']  # Get the finish button
    Scroll Into View    ${finishBtn}    smooth    end  # Scroll to the finish button
    Click Element    ${finishBtn}  # Click the finish button to complete the order
    ${ThankYouMessage}=    Get Text    class=complete-header  # Get the "Thank You" message to confirm successful checkout
    Log To Console    ${ThankYouMessage}  # Log the "Thank You" message
    [Return]    ${totalCartValue}  # Return the total cart value from the checkout page for comparison
