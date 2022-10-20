*** Settings *** 
Library     Selenium2Library 

*** Variables *** 
${delay}               0.5
${url}                 https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${browser}             Chrome 
${username}            Admin 
${password}            admin123 
${invalid_username}    admin
${invalid_password}    admin321
@{first_name}          Sehat    Lahir   ahmad
@{middle_name}         Lahir    Batin   yogi
@{last_name}           Batin    Sehat   fareizi
@{email}               sehatlahirbatin@gmail.com    yaugih@gmail.com        yogi@gmail.com
@{contact_number}      082329153573                 08223567887             08123454345433
@{keywords}            Test                         Cek                     Coba
@{notes}               Semoga Sehat Selalu          Selamat Ulang Tahun     Latihan ygy
${nApplicant}          3


***Test Cases***
Login With Valid Credentials
    [Tags]                      positive
    Begin Web Test
    Input Username              ${username}
    Input Password              ${password}
    Click Login Button
    Verify Login Success

Add Candidate
    [Tags]                      positive
    Looping For Input Many Applicant    ${nApplicant}   ${first_name}     ${middle_name}     ${last_name}    ${email}    ${contact_number}    ${keywords}   ${notes}

Logout
    [Tags]                      positive
    Click Profile
    Click Logout
    Verify Logout Success
    Close Browser

Login With Invalid Credentials
    [Tags]                      negative
    Begin Web Test
    Input Username             ${invalid_username}
    Input Password             ${invalid_password}
    Click Login Button
    Error Alert Should Show
    Close Browser

***Keywords***
Begin Web Test
    Open Browser                ${url}       ${browser} 
    Maximize Browser Window
    Set Selenium Speed         ${delay}
    Title Should Be             OrangeHRM

Looping For Input Many Applicant
    [Arguments]                    ${nApplicant}           ${first_name}     ${middle_name}     ${last_name}    ${email}    ${contact_number}    ${keywords}   ${notes}
    FOR                            ${i}                    IN RANGE    ${nApplicant}
        Click Tab Recruitment
        Verify Succes Recruitment
        Click Add
        Click Close Sidebar
        Input Candidate Firstname       ${first_name}[${i}]                
        Input Candidate Middlename      ${middle_name}[${i}]                   
        Input Candidate Lastname        ${last_name}[${i}]               
        Click Dropdown Vacancy
        Click Vacancy
        Click Item Vacancy
        Input Candidate Email           ${email}[${i}]
        Input Candidate Contactnumber   ${contact_number}[${i}]
        Select File
        Input Keywords                  ${keywords}[${i}]
        Click Date
        Click Today
        Input Notes                     ${notes}[${i}]
        Click consent
        Click Save
        Click Close Sidebar
        Click Close Sidebar
        Verify Save Succes
    END

Input Username
    [Arguments]    ${username}
    Sleep           3s  
    Input Text      name:username           ${username}

Input Password
    [Arguments]    ${password} 
    Input Text      name:password           ${password}

Click Login Button
    Click Element    xpath:/html/body/div/div[1]/div/div[1]/div/div[2]/div[2]/form/div[3]/button

Verify Login Success
    Element Text Should Be    xpath:/html/body/div/div[1]/div[1]/header/div[1]/div[1]/span/h6   PIM

Error Alert Should Show
   	Element Text Should Be    xpath:/html/body/div/div[1]/div/div[1]/div/div[2]/div[2]/div/div[1]    Invalid credentials

Click Tab Recruitment
    Click Element      xpath:/html/body/div/div[1]/div[1]/aside/nav/div[2]/ul/li[5]/a
    
Verify Succes Recruitment
    Element Text Should Be     xpath:/html/body/div/div[1]/div[1]/header/div[1]/div[1]/span/h6      Recruitment
    Element Text Should Be      xpath:/html/body/div/div[1]/div[1]/header/div[2]/nav/ul/li[1]/a     Candidates

Click Close Sidebar
    Click Element    xpath:/html/body/div/div[1]/div[1]/aside/nav/div[2]/div/div/button

Click Add
    Click Element    xpath:/html/body/div/div[1]/div[2]/div[2]/div/div[2]/div[1]/button

Input Candidate Firstname
    [Arguments]    ${first_name}
    Input Text     name:firstName    ${first_name}

Input Candidate Middlename
    [Arguments]    ${middle_name}
    Input Text     name:middleName    ${middle_name}

Input Candidate Lastname
    [Arguments]    ${last_name}
    Input Text     name:lastName    ${last_name}
    ${get_name}      Catenate    ${first_name}   ${middle_name}  ${last_name}    
    Set Global Variable     ${get_name}

Click Dropdown Vacancy
    Click Element  xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[2]/div/div/div/div[2]/div/div
               
Click Vacancy
    Click Element  xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[2]/div/div/div/div[2]/div/div/div[1]

Click Item Vacancy
    Click Element   xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[2]/div/div/div/div[2]/div/div[2]/div[6]/span

Input Candidate Email
    [Arguments]    ${email}
    Input Text     xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[3]/div/div[1]/div/div[2]/input  ${email}

Input Candidate Contactnumber 
    [Arguments]    ${contact_number}
    Input Text     xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[3]/div/div[2]/div/div[2]/input    ${contact_number}

Select File
    Choose File     xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[4]/div/div/div/div/div[2]/input    ${CURDIR}${/}resume.pdf

Input Keywords
    [Arguments]    ${keywords}
    Input Text     xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[5]/div/div[1]/div/div[2]/input    ${keywords}
    
Click Date
    Click Element  xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[5]/div/div[2]/div/div[2]/div/div/i
     Element Text Should Be     xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[5]/div/div[2]/div/div[2]/div/div[2]/div/div[4]/div/div[1]     Today

Click Today
    Sleep   3
    Click Element  xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[5]/div/div[2]/div/div[2]/div/div[2]/div/div[4]/div/div[1]

Input Notes
    [Arguments]    ${notes}
    Input Text     xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[6]/div/div/div/div[2]/textarea    ${notes}

Click Consent
    Click Element   xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[7]/div/div/div/div[2]/div/label/span/i

Click Save
    Click Element   xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[8]/button[2]

Click Save 2
    Wait Until Element Is Visible   xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[3]/button[2]
    Click Element   xpath:/html/body/div/div[1]/div[2]/div[2]/div/div/form/div[3]/button[2]

Verify Save Succes
    Sleep   5
    # Element Text Should Be       xpath:/html/body/div/div[1]/div[2]/div[2]/div[1]/form/div[1]/div[1]/div/div[2]/p       ${get_name}
    Element Text Should Be      xpath:/html/body/div/div[1]/div[1]/header/div[1]/div[1]/span/h6      Recruitment
    Element Text Should Be      xpath:/html/body/div/div[1]/div[1]/header/div[2]/nav/ul/li[1]/a      Candidates
Verify Success Add Candidate
    Element Text Should Be      xpath:/html/body/div/div[1]/div[1]/header/div[1]/div[1]/span/h6      Recruitment
    Element Text Should Be      xpath:/html/body/div/div[1]/div[1]/header/div[2]/nav/ul/li[1]/a      Candidates

Input Schedule
    Click Schedule Interview

Click Schedule Interview
    Click Element   //*[@id="app"]/div[1]/div[2]/div[2]/div[1]/form/div[2]/div[2]/button[2]

Click Shortlist
    Click Element   xpath:/html/body/div/div[1]/div[2]/div[2]/div[1]/form/div[2]/div[2]/button[2]

Click Profile
    Click Element   xpath:/html/body/div/div[1]/div[1]/header/div[1]/div[2]/ul/li/span/img

Click Logout
    Click Element   xpath:/html/body/div/div[1]/div[1]/header/div[1]/div[2]/ul/li/ul/li[4]/a

Verify Logout Success
    Element Text Should Be      xpath:/html/body/div/div[1]/div/div[1]/div/div[2]/h5       Login