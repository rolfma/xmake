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
-- Copyright (C) 2015-present, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        connect_service.lua
--

-- imports
import("core.base.option")
import("core.base.socket")
import("core.base.scheduler")
import("private.service.config")

function _get_address()
    local addr, port
    local address = assert(config.get("remote_build.client.connect"), "config(remote_build.client.connect): not found!")
    local splitinfo = address:split(':', {plain = true})
    if #splitinfo == 2 then
        addr = splitinfo[1]
        port = splitinfo[2]
    else
        addr = "127.0.0.1"
        port = splitinfo[1]
    end
    assert(addr and port, "invalid connect address!")
    return addr, port
end

function _session(addr, port)
    print("connect %s:%d ..", addr, port)
    local sock = socket.connect(addr, port)
    if sock then
        print("%s: connected!", sock)
    else
        print("connect %s:%d failed", addr, port)
    end
end

function main()
    scheduler.co_start(_session, _get_address())
end
