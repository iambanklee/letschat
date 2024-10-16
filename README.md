# Let's chat

This is a simple SPA chat app implemented in Rails

## App features:
- Users can sign up with a display name
- Users can join and leave chat rooms
  - Joined chat room will be on top of list
- Chat rooms can have many users at a time
  - Real-time chat room user counters update
- Users can send message to chat rooms
- Real-time messages sending and receiving
- Text only messages (so far)
- Chat room messages history

Try it today! https://letschat-wawa.fly.dev/

## Test
100% RSpec/Capybara test coverage 
```bash
ChatRoomChannel
  stream to the queue chat_room_ with given chat_room_id

User
  Users should be able to sign up and be authenticated
    sign up
      allow users to sign up with display name
    Authentication
      when user is not sign in
        redirect user to sign in page
      allow users to sign in
        redirect user to root page
  Users should be able to join and leave chat rooms
Capybara starting Puma...
* Version 6.4.3, codename: The Eagle of Durango
* Min threads: 0, max threads: 4
* Listening on http://127.0.0.1:58246
2024-10-16 15:06:38 INFO Selenium [:logger_info] Details on how to use and modify Selenium logger:
  https://selenium.dev/documentation/webdriver/troubleshooting/logging

2024-10-16 15:06:38 WARN Selenium [:clear_session_storage] [DEPRECATION] clear_session_storage is deprecated and will be removed in a future release.
2024-10-16 15:06:38 WARN Selenium [:clear_local_storage] [DEPRECATION] clear_local_storage is deprecated and will be removed in a future release.
    user can join a chat room
2024-10-16 15:06:39 WARN Selenium [:clear_session_storage] [DEPRECATION] clear_session_storage is deprecated and will be removed in a future release.
2024-10-16 15:06:39 WARN Selenium [:clear_local_storage] [DEPRECATION] clear_local_storage is deprecated and will be removed in a future release.
    user can leave a chat room
  Chat rooms can have many users at a time
2024-10-16 15:06:39 WARN Selenium [:clear_session_storage] [DEPRECATION] clear_session_storage is deprecated and will be removed in a future release.
2024-10-16 15:06:39 WARN Selenium [:clear_local_storage] [DEPRECATION] clear_local_storage is deprecated and will be removed in a future release.
    shows how many user in the chat room
  Users can send message to chat rooms
2024-10-16 15:06:40 WARN Selenium [:clear_session_storage] [DEPRECATION] clear_session_storage is deprecated and will be removed in a future release.
2024-10-16 15:06:40 WARN Selenium [:clear_local_storage] [DEPRECATION] clear_local_storage is deprecated and will be removed in a future release.
    allow user to sends message

ChatRoom
  Action Cable (Broadcasting)
    when a Chat room is created
      broadcasts message to right channel with predefined partial

ChatRoomUser
  Action Cable (Broadcasting)
    when a ChatRoomUser is created (user joins a chat room)
      broadcasts message to right channel with predefined partial
    when a ChatRoomUser is destroy (user leaves a chat room)
      broadcasts message to right channel with predefined partial

Message
  Action Cable (Broadcasting)
    when a Message is created
      broadcasts message to right channel with predefined partial

ChatRooms
  GET /chat_rooms/new
    returns http success
  POST /chat_rooms
    with valid chat room params
      returns http success
      creates a chat room
    with invalid chat room params
      returns 400 errors
  GET /chat_rooms/:id/join
    when chat room exist
      adds user to given chat room
    when chat room does not exist
      returns 404 error
  GET /chat_rooms/:id/leave
    when chat room exist
      remove user from given chat room
    when chat room does not exist
      returns 404 error

Mains
  with signed in user
    GET /index
      returns http success

Messages
  GET /chat_rooms/:chat_room_id/messages
    returns http success
  POST /chat_rooms/:chat_room_id/messages
    returns http success
    creates a new message for given chat room

main/index.html.erb
  display user display name
  display chat rooms user joined
  display other chat rooms user can join

Finished in 4.4 seconds (files took 1.08 seconds to load)
27 examples, 0 failures

Coverage report generated for RSpec to ./coverage.
Line Coverage: 100.0% (435 / 435)
```
