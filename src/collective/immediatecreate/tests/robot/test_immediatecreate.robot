# ============================================================================
# EXAMPLE ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s collective.immediatecreate -t test_example.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src collective.immediatecreate.testing.COLLECTIVE_IMMEDIATECREATE_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot src/collective/immediatecreate/tests/robot/test_example.robot
#
# See the http://docs.plone.org for further details (search for robot
# framework).
#
# ============================================================================

*** Settings *****************************************************************

Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot

Library  plone.app.robotframework.keywords.Debugging
Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers


*** Test Cases ***************************************************************

#Scenario: As a member I want to be able to log into the website
 # [Documentation]  Example of a BDD-style (Behavior-driven development) test.
  #Given a login form
   #When I enter valid credentials
   #Then I am logged in

Scenario: A new folder is added
  Given Go to homepage
  and Log in as site owner
  and wait until element is visible  css=li#plone-contentmenu-factories
  set selenium speed  1
  set selenium timeout  5
    When Click Link  css=li#plone-contentmenu-factories > a
    and Click Link  css=li.plonetoolbar-contenttype > a#folder
    Then Location Should Contain  new-folder

Scenario: Cancel the new folder
  Given Go to homepage
  and Log in as site owner
  and wait until element is visible  css=li#plone-contentmenu-factories
  and Click Link  css=li#plone-contentmenu-factories > a
  and Click Link  css=li.plonetoolbar-contenttype > a#folder
	and wait until element is visible  css=div.formControls
  set selenium speed  1
    When Click Button  css=div.formControls > input#form-buttons-cancel
		Then Click Link  css=li#contentview-folderContents > a
		and Page Should Not Contain  New Folder

#Scenario: Bild in Ordner
#  Given Go to homepage
#  and Log in as site owner
#  and wait until element is visible  css=li#plone-contentmenu-factories
#  and Click Link  css=li#plone-contentmenu-factories > a
#  and Click Link  css=li.plonetoolbar-contenttype > a#folder
#	and wait until element is visible  css=div.formControls
#  set selenium speed  1
#		When Click Button  css=div#mceu_19 > button#mceu_19-open
#		and Click Button  css=div#mceu_42
#		and Click Button  css=div.formControls > input#form-buttons-save


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a login form
  Go To  ${PLONE_URL}/login_form
  Wait until page contains  Login Name
  Wait until page contains  Password


# --- WHEN -------------------------------------------------------------------

I enter valid credentials
  Input Text  __ac_name  admin
  Input Text  __ac_password  secret
  Click Button  Log in


# --- THEN -------------------------------------------------------------------

I am logged in
  Wait until page contains  You are now logged in
  Page should contain  You are now logged in
