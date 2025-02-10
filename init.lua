-- debug_reader/init.lua
minetest.register_chatcommand("logs", {
    description = "Reads debug.txt and sends its contents to the player",
    func = function(name)
        -- Define the file path for debug.txt
        local debug_file_path = minetest.get_worldpath() .. "/debug.txt"
        
        -- Check if the file exists
        local file = io.open(debug_file_path, "r")
        if not file then
            return false, "Could not open debug.txt file."
        end

        -- Read the file contents
        local content = file:read("*all")
        file:close()

        -- Send the content to the player who ran the command
        -- Limit the content to the first 2000 characters to avoid chat overflow
        local max_length = 2000
        local truncated_content = content:sub(1, max_length)

        -- Send the contents in a private message to the player
        minetest.chat_send_player(name, "Contents of debug.txt:\n" .. truncated_content)

        -- Inform player if content was truncated
        if #content > max_length then
            minetest.chat_send_player(name, "Note: The output was truncated to " .. max_length .. " characters.")
        end

        return true
    end,
})
