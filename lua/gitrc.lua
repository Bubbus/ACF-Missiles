/*
Github Repository Checker v1 
	
	Created by Wrex & Bubbus
		
	Credits: Nebual
	

	***Include this into a file thats loaded before others, DONT PUT IN AUTORUN!!!***


	GitC.CheckVersion(RepoOwner, RepoName, Callback):
	
	**http://github.com/RepoOwner/RepoName**
	
	Args:
		RepoOwner:  
			The owner of the repository
			
		RepoName:
			The name of the repository
		
		Callback:
			Returns the parsed data from the repository:
	
			Useful variables:
			
				data.uptodate: (bool)
					Returns true if the players addon is up to date with the repositories.
				data.name: (string)
					Returns the repository owner
				data.commits (table)
					Returns up to 100 commits with the first entry being the latest

	
	Example:
	
		GitRC.CheckVersion("nrlulz", "ACF", function(data)
			print(data.name.." is "..data.uptodate and "Up To Date" or "Out Of Date")
		end)
	
*/



GitRC = GitRC or {}

local Repositories = {}

local RepoURL = "https://api.github.com/repos/%s/%s/commits?per_page=10"


local string = string
local table = table
local os = os
local http = http
local util = util
local file = file
local math = math
local print = print


-- EXAMPLE USAGE:
-- concommand.Add("acfmissiles_checkversion",function()
	-- GitRC.CheckVersion("Bubbus", "ACF-Missiles", function(data)
		-- print(data.name.." is "..(data.uptodate and "Up To Date" or "Out Of Date"))
	-- end)
-- end)


// turns a git date into os.time() seconds
local function format_gitdate(gitdate)
	local dt = string.Explode("T",gitdate)
	local edate = string.Explode("-",dt[1])
	local etime = string.Explode(":",dt[2])
	local time = os.time({year=edate[1],
		month=edate[2],day=edate[3],hour=etime[1],
		min =etime[2],
		sec = string.sub(etime[3],1,2)})
	return time 
end

// gets the time zone of the local player
local function get_timezone()
	local now = os.time()
	local lmt = os.date("*t", now)
	local gmt = os.date("!*t", now)
	local ltime = os.time(lmt)
	local gtime = os.time(gmt)
	local diff = os.difftime(gtime,ltime)
						
	if lmt.isdst then
		if diff <= 0 then
			diff = diff + 3600
		else
			diff = diff - 3600
		end
	end
	return diff
end

// gets a random filename from the commit and checks to make sure it exists
local function get_randomfilenametime(files,committime)
	local existingfiles = {}
	for i=1, #files do
		local filename = files[i].filename
		if file.Exists(filename, "GAME") then 
			existingfiles[i] = filename		
		end
	end
	local filecount = table.Count(existingfiles)
	if !filecount then 
		print(table.Count(files))
		local randomfile = files[math.random(1,table.Count(files))]
		local filepath = randomfile.filename
		print("path: "..filepath)
		local filestatus = randomfile.status
		print("status"..filestatus)
		if filestatus=="removed" then
			filetime = committime+10
		end
	else		
		local randomfile = existingfiles[math.random(1,filecount)] or ""
		filetime = file.Time(randomfile,"GAME")
        --print("filetime", filetime, randomfile)
	end
	return filetime
end

// this will be used for other functions, so it gets to be its own function!
local function GetRepository(RepoOwner, RepoName, Callback)
	Repositories[RepoName] = {} 
	http.Fetch(string.format(RepoURL,RepoOwner, RepoName), function(json) 
		if json then
			local repo = util.JSONToTable(json)
			
			Repositories[RepoName].commits = repo
			Repositories[RepoName].owner = RepoOwner
			Repositories[RepoName].name  = RepoName
			Callback(repo)
			--print("Repository parsed!")
		else 
			print("Repository "..RepoName.." not found, did you input the correct owner and name?")
		end
	end, print)	
end


function GitRC.CheckVersion(RepoOwner, RepoName, Callback)
	if not Callback then error("[GitC]ERROR: missing callback function. ") return end 

	if Repositories[RepoName] then 
		Callback(Repositories[RepoName])
		return 
	end
	
	// get the repo data
	GetRepository(RepoOwner, RepoName, function(repo)
		local repo =  repo[1] // pull the latest commit
		if repo then
			// get the latest commit
			http.Fetch( repo.url, function(json) 
				local latestcommit = util.JSONToTable(json) 
				if latestcommit then
                                
					local commitdate = latestcommit.commit.author.date	
					local committime = format_gitdate(commitdate) - get_timezone()
					local filetime = get_randomfilenametime(latestcommit.files,committime)		
					Repositories[RepoName].committime = committime
					Repositories[RepoName].filetime = filetime
					Repositories[RepoName].uptodate = committime <= filetime
					
					Callback(Repositories[RepoName])
				else
					print("Commit data not found, something went horribly wrong!")
				end
			end, print)	
		end
	end)	
end