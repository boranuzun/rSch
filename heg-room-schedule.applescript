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
    set inputRoom to item 1 of argv
    # Convert input to uppercase
    set roomName to do shell script "echo " & quoted form of inputRoom & " | tr '[:lower:]' '[:upper:]'"
    set roomURL to "https://www.hesge.ch/heg/salle/" & roomName

    # Fetch room status
    set roomStatus to do shell script "curl -s " & quoted form of roomURL & " | pup ':contains(\"Salle\") text{}'"

    if roomStatus is "" then
        return "❌ Could not retrieve room status."
    end if

    # Format the room status for readability
    if roomStatus contains "occupée" then
        set formattedRoomStatus to "📕 Room Status: OCCUPIED\n"
    else
        set formattedRoomStatus to "📗 Room Status: AVAILABLE\n"
    end if

    # Fetch additional info
    set additionalInfo to do shell script "curl -s " & quoted form of roomURL & " | pup 'p text{}'"

    if additionalInfo is "" then
        return "❌ Could not retrieve additional information."
    end if

    return formattedRoomStatus & "\n📝 Additional Information:\n" & additionalInfo
end run
