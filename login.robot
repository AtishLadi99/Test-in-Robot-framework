# Created by admin at 28/11/23
*** Settings ***
Library  SeleniumLibrary
Suite Setup  Open Browser  https://www.saucedemo.com/  chrome
Suite Teardown  Close Browser
Test Setup  Go To Login Page

*** Variables ***
${VALID_USERNAME}  standard_user
${VALID_PASSWORD}  secret_sauce
${INVALID_USERNAME}  invalid_user
${INVALID_PASSWORD}  invalid_password

*** Keywords ***
Go To Login Page
    Go To  https://www.saucedemo.com/

Login With Credentials
    [Arguments]  ${username}  ${password}
    Input Text  user-name  ${username}
    Input Password  password  ${password}
    Click Button  login-button

*** Test Cases ***
# Test Case 1
Verify Successful Login
    Login With Credentials  ${VALID_USERNAME}  ${VALID_PASSWORD}
    Page Should Contain Element  product_label

# Test Case 2
Verify Unsuccessful Login with Incorrect Username
    Login With Credentials  ${INVALID_USERNAME}  ${VALID_PASSWORD}
    Page Should Contain Text  Epic sadface: Username and password do not match any user in this service

# Test Case 3
Verify Unsuccessful Login with Incorrect Password
    Login With Credentials  ${VALID_USERNAME}  ${INVALID_PASSWORD}
    Page Should Contain Text  Epic sadface: Username and password do not match any user in this service

# Test Case 4
Verify Unsuccessful Login with Blank Username and Password
    Login With Credentials  ${EMPTY}  ${EMPTY}
    Page Should Contain Text  Epic sadface: Username is required

# Test Case 5
Verify Unsuccessful Login with Valid Username and Blank Password
    Login With Credentials  ${VALID_USERNAME}  ${EMPTY}
    Page Should Contain Text  Epic sadface: Password is required

# Test Case 6
Verify Unsuccessful Login with Blank Username and Valid Password
    Login With Credentials  ${EMPTY}  ${VALID_PASSWORD}
    Page Should Contain Text  Epic sadface: Username is required

# Test Case 7
Verify Login with Leading and Trailing Spaces in Username
    Login With Credentials  ${VALID_USERNAME_WITH_SPACES}  ${VALID_PASSWORD}
    Page Should Contain Element  product_label

# Test Case 8
Verify Login with Leading and Trailing Spaces in Password
    Login With Credentials  ${VALID_USERNAME}  ${VALID_PASSWORD_WITH_SPACES}
    Page Should Contain Element  product_label

# Test Case 9
Verify the "Forgot Password" Link Functionality
    Click Link  partial=Fo
    Input Text  user-name  ${VALID_USERNAME}
    Click Button  reset-password
    Page Should Contain Text  Password reset link sent to:
    Click Link  Back to Login

# Test Case 10
Verify the "Back to Login" Link on the Password Reset Page
    Click Link  partial=Fo
    Input Text  user-name  ${VALID_USERNAME}
    Click Button  reset-password
    Click Link  Back to Login
    Page Should Contain Element  login-button

# Test Case 11
Verify Session Timeout Functionality
    Login With Credentials  ${VALID_USERNAME}  ${VALID_PASSWORD}
    Sleep  180000  # Sleep for the session timeout duration
    Click Element  inventory_container  # Perform action that requires authentication
    Page Should Contain Text  Epic sadface: Sorry, this problem has been fixed

# Test Case 12
Verify Login Functionality with Special Characters in Password
    Login With Credentials  ${VALID_USERNAME}  ${VALID_PASSWORD_WITH_SPECIAL_CHARS}
    Page Should Contain Element  product_label

# Test Case 13
Verify Case Sensitivity of the Username
    Login With Credentials  ${VALID_USERNAME_UPPERCASE}  ${VALID_PASSWORD}
    Page Should Contain Element  product_label

# Test Case 14
Verify Case Sensitivity of the Password
    Login With Credentials  ${VALID_USERNAME}  ${VALID_PASSWORD_UPPERCASE}
    Page Should Contain Element  product_label

# Test Case 15
Verify the "Remember Me" Functionality
    Check Checkbox  remember_me
    Login With Credentials  ${VALID_USERNAME}  ${VALID_PASSWORD}
    Close Browser
    Open Browser  https://www.saucedemo.com/  chrome
    Page Should Contain Element  product_label

# Test Case 16
Verify Login with an Expired Account
    Login With Credentials  ${EXPIRED_USERNAME}  ${VALID_PASSWORD}
    Page Should Contain Text  Epic sadface: This user has been locked out.

