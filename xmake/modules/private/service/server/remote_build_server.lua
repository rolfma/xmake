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
-- @file        remote_build_server.lua
--

-- imports
import("private.service.config")
import("private.service.stream")
import("private.service.message")
import("private.service.server.server")

-- define module
local remote_build_server = remote_build_server or server()
local super = remote_build_server:class()

-- init server
function remote_build_server:init(daemon)
    super.init(self, daemon)
    if self:daemon() then
        config.load()
    end
    local listen = assert(config.get("remote_build.server.listen"), "config(remote_build.server.listen): not found!")
    super.listen_set(self, listen)
    super.handler_set(self, self.on_handle)
end

-- handle ping message
function remote_build_server:handle_ping(sock, msg)
    local wstream = stream(sock)
    if wstream:send_msg(message.new_ping()) and wstream:flush() then
        print("send ok")
    end
end

-- on handle message
function remote_build_server:on_handle(sock, msg)
    if msg:is_ping() then
        self:handle_ping(sock, msg)
    end
end

-- get class
function remote_build_server:class()
    return remote_build_server
end

function remote_build_server:__tostring()
    return "<remote_build_server>"
end

function main(daemon)
    local instance = remote_build_server()
    instance:init(daemon ~= nil)
    return instance
end