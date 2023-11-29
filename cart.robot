# Created by admin at 28/11/23
*** Settings ***
Library  SeleniumLibrary
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser

*** Variables ***
${VALID_USERNAME}  your_valid_username
${VALID_PASSWORD}  your_valid_password
${PRODUCT_NAME}    Sauce Labs Backpack

*** Test Cases ***

# Test Case 1: Verify Adding a Product to the Cart
Verify Adding a Product to the Cart
    Log In with Valid Credentials
    Add Product to Cart
    [Teardown]  Remove Product from Cart

# Test Case 2: Verify Removing a Product from the Cart
Verify Removing a Product from the Cart
    Log In with Valid Credentials
    Add Product to Cart
    Remove Product from Cart

# Test Case 3: Verify Cart Icon Display
Verify Cart Icon Display
    Log In with Valid Credentials
    Element Should Be Visible  css:.shopping_cart_container

# Test Case 4: Verify Cart Count Update
Verify Cart Count Update
    Log In with Valid Credentials
    Add Product to Cart
    Add Another Product to Cart
    Element Text Should Be  css:.shopping_cart_badge  2

# Test Case 5: Verify Cart Summary Information
Verify Cart Summary Information
    Log In with Valid Credentials
    Add Product to Cart
    Go To Cart
    Element Text Should Be  css:.cart_item_label  ${PRODUCT_NAME}

# Test Case 6: Verify Cart Total Calculation
Verify Cart Total Calculation
    Log In with Valid Credentials
    Add Product to Cart
    Add Another Product to Cart
    Go To Cart
    ${total} =  Get Text  css:.summary_total_label
    Should Be Equal As Numbers  ${total}  2 * ${PRODUCT_PRICE}

# Test Case 7: Verify Checkout Button Functionality
Verify Checkout Button Functionality
    Log In with Valid Credentials
    Add Product to Cart
    Click Element  css:.checkout_button
    Wait Until Page Contains  Your Information

# Test Case 8: Verify Continue Shopping Button
Verify Continue Shopping Button
    Log In with Valid Credentials
    Add Product to Cart
    Click Element  css:.btn_secondary
    Element Should Be Visible  css:.inventory_list

# Test Case 9: Verify Empty Cart Functionality
Verify Empty Cart Functionality
    Log In with Valid Credentials
    Add Product to Cart
    Remove Product from Cart
    Element Should Be Visible  css:.cart_list_container

# Test Case 10: Verify Cart Persistence after Logout/Login
Verify Cart Persistence after Logout/Login
    Log In with Valid Credentials
    Add Product to Cart
    Log Out
    Log In with Valid Credentials
    Go To Cart
    Element Text Should Be  css:.cart_item_label  ${PRODUCT_NAME}

# Test Case 11: Verify Cart Behavior with Out-of-Stock Products
Verify Cart Behavior with Out-of-Stock Products
    Log In with Valid Credentials
    Navigate To Product List
    Click Element  css:.inventory_list_item:contains("${OUT_OF_STOCK_PRODUCT}")
    Element Should Be Disabled  css:.btn_inventory

# Test Case 12: Verify Cart Behavior with Invalid Inputs
Verify Cart Behavior with Invalid Inputs
    Log In with Valid Credentials
    Add Product to Cart with Invalid Quantity
    Element Should Be Visible  css:.error-message-container

# Test Case 13: Verify Cart Responsiveness on Different Devices
Verify Cart Responsiveness on Different Devices
    Log In with Valid Credentials
    Add Product to Cart
    Set Window Size  1200  800
    Capture Page Screenshot  cart_desktop.png
    Set Window Size  400  800
    Capture Page Screenshot  cart_mobile.png

# Test Case 14: Verify Cart Timeout Session
Verify Cart Timeout Session
    Log In with Valid Credentials
    Add Product to Cart
    Sleep  90000  # Sleep for session timeout (in milliseconds)
    Refresh Page
    Element Should Be Visible  css:.login_credentials

*** Keywords ***

Log In with Valid Credentials
    Input Text  css:[name="user-name"]  ${VALID_USERNAME}
    Input Text  css:[name="password"]   ${VALID_PASSWORD}
    Click Button  css:[value="LOGIN"]

Add Product to Cart
    Click Element  css:.inventory_item:contains("${PRODUCT_NAME}")
    Click Element  css:.btn_inventory

Remove Product from Cart
    Click Element  css:.cart_item:contains("${PRODUCT_NAME}") .btn_secondary
    Element Should Not Be Visible  css:.cart_item:contains("${PRODUCT_NAME}")

Go To Cart
    Click Element  css:.shopping_cart_container
