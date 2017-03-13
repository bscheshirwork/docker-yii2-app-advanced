--[[

   Copyright (C) 2007 MySQL AB

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; version 2 of the License.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

--]]

---
-- Uses MySQL-Proxy to log your queries
--   Downloaded from http://ronaldbradford.com/mysql-dba/mysql-proxy/log.lua
--
-- Written by Giuseppe Maxia, based on examples provided
-- by Jan Knesckhe
--
-- This script will log the current date and time, the connection id
-- and the query to a file named "mysql.log"
--
local log_file = os.getenv("LOG_FILE")

local fh = io.open(log_file, "a+")

function read_query( packet )
    if string.byte(packet) == proxy.COM_QUERY then
        local query = string.sub(packet, 2)
        fh:write( string.format("%s %6d -- %s \n", 
            os.date('%Y-%m-%d %H:%M:%S'), 
            proxy.connection.server["thread_id"], 
            query)) 
        fh:flush()
    end
end