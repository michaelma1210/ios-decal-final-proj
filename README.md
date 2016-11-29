# Biddle #

## Authors ##
* David Choi
* Yeshun Lin
* Claudia Tse
* Michael Ma

## Purpose ##
Biddle is a social app designed to make spontaneous social activities easier by allowing friends to see each other’s current availability and view/create events.

## Features ##
* Set your status as busy/idle
 * Default status will be set by your uploaded schedule
* Add short blurb on your profile say what you’re looking for. (ex. Study buddy, Food buddy, Gym buddy)
* Add/accept friends and see their status
* View/create events
 * Invite friends to events and accept invitations
* Collect info and suggest activities

## Control Flow ##
* Users are initially presented with a ‘Login/Create Account’ screen.
* Once they’ve logged in, they will be brought to the ‘Home’ page where they can manually change their status to busy/idle by tapping a button in the middle of the screen. When they swipe right, a navigation bar will show up that will contain the buttons: Profile, Friends, Events, and Schedule. Tapping each of those buttons will bring you to their respective page.
* The ‘Profile’ page will contain the current user’s name, username, status, and blurb which you can edit by tapping on the ‘Edit’ button on the top right corner which will bring you to the ‘Edit Profile’ page.
  * The ‘Edit Profile’ page will allow you to edit your name, username and blurb. Tapping either the ‘Save’ button on the top right or the ‘Cancel’ button the top left will bring you back to your profile page.
* The ‘Friends’ page will list the names of the current user’s friends, their blurbs, and their current status. Tapping the ‘Add’ button on the top right will bring you to the ‘Add Friends’ page where you can search up users by their username and add them as a friend. 
* The ‘Events’ page will list the events that you’ve joined and the option to create events. Clicking the ‘Create’ button on the top corner will bring you to the ‘Create Events’ page.
  * The ‘Create Events’ page will allow you to add details about your event, invite people, and edit the privacy of your event.
* The ‘Schedule’ page will feature a calendar where you can manually input (by sliding) your availability for the week. 

## Implementation ##

### Model ###
* EventsList.swift
* FriendsList.swift
* User.Swift

### View ###
* LoginView
* SwitchView
* ProfileView
* EditProfileView
* CreateEventView
* EventsListTableView
* FriendsListTableView
* AddFriendView
* ScheduleView

### Controller ###
* LoginViewController.swift
* SwitchViewController.swift
* ProfileViewController.swift
* EditProfileViewController.swift
* CreateEventViewController.swift
* EventListTableViewController.swift
* FriendsListTableViewController.swift
* AddFriendsViewController.swift
* ScheduleViewController.swift



