--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- Copyright (C) 2015-2020, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        install.lua
--

-- imports
import("core.base.option")

-- get menu options
function menu_options()

    -- description
    local description = "Install the given packages."

    -- menu options
    local options =
    {
        {},
        {'h', "help",      "k",  nil, "Print this help message and exit." },
        {},
        {nil, "action",    "v",  nil, "The sub-command name."    },
        {nil, "options",   "vs", nil, "The sub-command options." }
    }

    -- show menu options
    local function show_options()

        -- show usage
        cprint("${bright}Usage: $${clear cyan}xrepo install [options] packages")

        -- show description
        print("")
        print(description)

        -- show options
        option.show_options(options)
    end
    return options, show_options, description
end

-- main entry
function main(menu)
    menu.show_help()
end
