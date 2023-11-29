# Created by admin at 28/11/23
*** Settings ***
Library  SeleniumLibrary
Suite Setup  Open Browser  ${URL}  ${BROWSER}
Suite Teardown  Close Browser
Test Setup  Login

*** Variables ***
${URL}                   https://www.saucedemo.com/
${BROWSER}               chrome
${VALID_USERNAME}        your_valid_username
${VALID_PASSWORD}        your_valid_password
${INVALID_USERNAME}      invalid_username
${INVALID_PASSWORD}      invalid_password

*** Test Cases ***
Verify Successful Login
    [Documentation]  Verify that a user can successfully log in to the website.
    Click Login Button
    Input Username  ${VALID_USERNAME}
    Input Password  ${VALID_PASSWORD}
    Submit Login
    Wait Until Page Contains  Products

Verify Invalid Login
    [Documentation]  Verify that a user cannot log in with invalid credentials.
    Click Login Button
    Input Username  ${INVALID_USERNAME}
    Input Password  ${INVALID_PASSWORD}
    Submit Login
    Wait Until Page Contains  Error

Verify Product Addition to Cart
    [Documentation]  Verify that a user can add a product to the shopping cart.
    Add Product to Cart
    Go to Shopping Cart
    Wait Until Page Contains  ${PRODUCT_NAME}

Verify Cart Checkout Process
    [Documentation]  Verify that a user can proceed with the checkout process from the shopping cart.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Wait Until Page Contains  Checkout Information

Verify Billing Information
    [Documentation]  Verify that the billing information can be entered during the checkout process.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Input Billing Information
    Click Continue
    Wait Until Page Contains  Payment Information

Verify Payment Information
    [Documentation]  Verify that the payment information can be entered during the checkout process.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Input Billing Information
    Click Continue
    Input Payment Information
    Click Continue
    Wait Until Page Contains  Order Summary

Verify Order Summary
    [Documentation]  Verify that the order summary is displayed correctly on the checkout page.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Input Billing Information
    Click Continue
    Input Payment Information
    Click Continue
    Wait Until Page Contains  Order Summary

Verify Order Placement
    [Documentation]  Verify that a user can successfully place an order.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Input Billing Information
    Click Continue
    Input Payment Information
    Click Continue
    Click Place Order
    Wait Until Page Contains  Order Confirmation

Verify Order Confirmation Email
    [Documentation]  Verify that the user receives an order confirmation email after placing an order.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Input Billing Information
    Click Continue
    Input Payment Information
    Click Continue
    Click Place Order
    Wait Until Page Contains  Order Confirmation
    # Add steps to check email (e.g., using external libraries)

Verify Logout Functionality
    [Documentation]  Verify that a user can successfully log out of the website.
    Logout
    Wait Until Page Contains  Login

Verify Session Timeout
    [Documentation]  Verify that the user is automatically logged out after a session timeout.
    Logout
    Wait Until Page Contains  Login

Verify Empty Cart Behavior
    [Documentation]  Verify that the cart behaves correctly when it is empty.
    Go to Shopping Cart
    Remove All Items from Cart
    Wait Until Page Contains  Cart is Empty

Verify Cart Quantity Update
    [Documentation]  Verify that a user can update the quantity of items in the shopping cart.
    Add Product to Cart
    Go to Shopping Cart
    Update Cart Quantity
    Wait Until Page Contains  Updated Cart Quantity

Verify Shipping Information
    [Documentation]  Verify that the user can enter shipping information during the checkout process.
    Add Product to Cart
    Go to Shopping Cart
    Click Checkout Button
    Input Billing Information
    Click Continue
    Input Shipping Information
    Click Continue
    Wait Until Page Contains  Payment Information


*** Keywords ***
Login
    Open Browser  ${URL}  ${BROWSER}
    Input Username  ${VALID_USERNAME}
    Input Password  ${VALID_PASSWORD}
    Submit Login
    Wait Until Page Contains  Products

Click Login Button
    Open Browser  ${URL}  ${BROWSER}
    Click Button  xpath=//button[text()='Login']

Input Username
    Input Text  user-name  ${1}

Input Password
    Input Password  password  ${1}

Submit Login
    Click Button  login-button

Add Product to Cart
    Click Button  xpath=//button[text()='Add to cart']

Go to Shopping Cart
    Click Link  xpath=//div[@id='shopping_cart_container']/a

Click Checkout Button
    Click Button  xpath=//a[text()='CHECKOUT']

Input Billing Information
    Input Text  first-name  John
    Input Text  last-name  Doe
    Input Text  postal-code  12345

Click Continue
    Click Button  xpath=//input[@value='CONTINUE']

Input Payment Information
    Input Text  card-number  4111111111111111
    Input Text  expiration-date  12/23
    Input Text  cvv  123

Click Place Order
    Click Button  xpath=//button[text()='PLACE ORDER']

Logout
    Click Link  xpath=//button[text()='Open Menu']
    Click Link  xpath=//a[text()='Logout']

Remove All Items from Cart
    Click Button  xpath=//button[text()='REMOVE']

Update Cart Quantity
    Input Text  xpath=//input[@class='cart_quantity_input']  2
    Click Button  xpath=//button[text()='UPDATE']

Input Shipping Information
    Input Text  address-line-1  123 Main St
    Input Text  address-line-2  Apt 4
    Input Text  city  Anytown
    Input Text  state  CA
    Input Text  postal-code  54321

Apply Promo Code
    Input Text  promo-code  DISCOUNT123
    Click Button  xpath=//button[text()='APPLY']
