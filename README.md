# BuzzBoard Event Tracker - Database Documentation

## 1. Schema Explanation

- **Organizers:** Stores event organizers’ info.
- **Students:** University students who can register for events.
- **Events:** Each event is linked to an organizer.
- **Registrations:** Tracks which students have registered for which events.

## 2. Queries & Their Purpose

1. **Upcoming Events:** Shows events after a certain date.
2. **Student’s Events:** Lists all events a student is registered in.
3. **Event Registrations Count:** Aggregates registrants per event.
4. **Popular Events:** Lists events with more than 2 registrations.
5. **Dual-Event Registrants:** Finds students who registered for both of two named events.
6. **Most Popular Event:** Returns the event(s) with the highest registrations.
7. **Events Not Registered:** For a student, lists events not registered for.
8. **Events per Organizer:** Counts events organized by each organizer.
9. **Tech Event Registrants:** Lists students who registered for any Tech event.
10. **Unique Event Dates (Tech & Music):** Union of event dates from Tech and Music.

## 3. Key Insights

- **Most Attended Event:** Easily identified by registrations count.
- **Active Students:** Students registering for multiple events can be tracked.
- **Engagement by Category:** See which event categories are more popular.
- **Organizer Activity:** Track which organizers are most active.

