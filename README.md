Tech stack:
Rails 7, Action Cable, Stimulus, Tailwind

1. A simple lightweight community platform that allows people to create & join “Groups”.
2. A group can either be
    1. Open - Anyone can join
    2. Private - People can request to join, but they have to be accepted by the creator
    3. Secret - People have to be invited to join
3. Users can join multiple groups and create posts on groups they’re a member of.
4. The creator of the group can
    1. Edit/delete any post/comments on the group.
    2. Remove members that currently have access to the group
    3. See the pending requests for joining a group and accept/reject those requests (assuming the group is private)
    4. Invite people to join the group.
5. Notifications
    1. Notifications are sent to the user if they are currently active on the app as well as on e-mail.
    2. They should be sent when:
        1. Someone commented on a post created by you
        2. Someone replied to a comment you posted.