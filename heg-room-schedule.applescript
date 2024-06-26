#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Room Schedule
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🏫
# @raycast.argument1 { "type": "text", "placeholder": "Room Name", "optional": false }

# Documentation:
# @raycast.description Gives you information about a given room's schedule.
# @raycast.author boran
# @raycast.authorURL https://github.com/boranuzun

# Main script logic
on run argv
    set roomName to item 1 of argv
    set roomURL to "https://www.hesge.ch/heg/salle/" & roomName
    set roomStatus to do shell script "curl -s " & roomURL & " | pup ':contains(\"Salle\") text{}'"

    if roomStatus is "" then
        return "Error: Could not retrieve room status."
    end if

    # Format the room status for readability
    if roomStatus contains "occupée" then
        set formattedRoomStatus to "Room Status: OCCUPIED\n"
    else
        set formattedRoomStatus to "Room Status: AVAILABLE\n"
    end if

    set additionalInfo to do shell script "curl -s " & roomURL & " | pup 'p text{}'"

    if additionalInfo is "" then
        return "Error: Could not retrieve additional information."
    end if

    return formattedRoomStatus & "\nAdditional Information:\n" & additionalInfo
end run
