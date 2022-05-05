config = {}
config.applications = {
	['com.runningwithcrayons.Alfred'] = {
		bundleID = 'com.runningwithcrayons.Alfred',
		local_bindings = {'c', 'space', 'o'}
	},
	['PathFinder'] = {
		bundleID = 'com.cocoatech.PathFinder',
		hyper_key = 'f'
	},
	['com.culturedcode.ThingsMac'] = {
		bundleID = 'com.culturedcode.ThingsMac',
		hyper_key = 't',
		tags = {'planning', 'review', 'tasks'},
		whitelisted = true,
		local_bindings = {',', '.'},
		rules = {
			{nil, 1, hs.layout.maximized}
		}
	},
	['com.toggl.toggldesktop.TogglDesktop'] = {
		bundleID = 'com.toggl.toggldesktop.TogglDesktop',
		local_bindings = {'p'}
	},
	['com.ideasoncanvas.mindnode.macos'] = {
		bundleID = 'com.ideasoncanvas.mindnode.macos',
		tags = {'research'},
		hyper_key = 'u',
		rules = {
			{nil, 1, hs.layout.maximized}
		}
	},
	['com.apple.MobileSMS'] = {
		bundleID = 'com.apple.MobileSMS',
		hyper_key = 'q',
		tags = {'communication', 'distraction'},
		rules = {
			{nil, 2, hs.layout.right30}
		}
	},
	["微信"] = {
		bundleID = 'com.tencent.xinWeChat',
		hyper_key = 'w'
	},
	["Wechat"] = {
		bundleID = 'com.tencent.xinWeChat',
		hyper_key = 'w'
	},
	["QQ"] = {
		bundleID = 'com.tencent.qq',
		hyper_key = 'z'
	},
	["qq"] = {
		bundleID = 'com.tencent.qq',
		hyper_key = 'z'
	},
	["mqq"] = {
		bundleID = 'com.tencent.mqq',
		hyper_key = 'z'
	},
	["DingTalk"] = {
		bundleID = 'com.alibaba.DingTalkMac',
	},
	["Telegram"] = {
		bundleID = 'ru.keepcoder.Telegram',
	},
	["FeiShu"] = {
		bundleID = 'com.electron.lark',
	},
	["iTerm2"] = {
		bundleID = 'com.googlecode.iterm2',
	},
}

config.domains = {
	['twitter.com'] = {
		url = 'twitter.com',
		tags = {'distraction', 'socialmedia'}
	},
	['instagram.com'] = {
		url = 'instagram.com',
		tags = {'distraction', 'socialmedia'}
	},
	['reddit.com'] = {
		url = 'reddit.com',
		tags = {'distraction'}
	},
	['instapaper.com'] = {
		url = 'instapaper.com',
		tags = {'distraction', 'reading'}
	},
	['youtube.com'] = {
		url = 'youtube.com',
		tags = {'distraction'}
	}
}

-- configure spaces for headspace
config.spaces = {}
config.funcs = {}
-- config.projects = hs.settings.get("secrets").toggl.projects
-- config.hyper_key = 'space'

-- hyper = require('hyper')
-- hyper.start(config)

-- 方向键
-- hyper:bindKey({})
-- hyper:bindKey({}, 'i', {}, 'up')
-- hyper:bindKey({}, 'k', {}, 'down')

hs.logger.defaultLogLevel = 'debug'

hs.urlevent.bind('launchOrHide', function (eventName, params)
	local app_bundle_id = config.applications[params["name"]].bundleID
	local app = hs.application.get(app_bundle_id)

	if not app then
		hs.application.open(app_bundle_id)
	elseif app:isFrontmost() and #app:visibleWindows() > 0 then
		app:hide()
		sleep(0.1)
		if not app:isHidden() then
			hs.dialog.blockAlert('message', 'informativeText')
			hs.logger:d(app:name() + ' doesn\'t hide, close it now !')
			for _, window in pairs(app:allWindows()) do
				window:close()
			end
		end
	else
		hs.application.launchOrFocusByBundleID(app:bundleID())
	end
end)

function sleep (a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end

function wait(time)
	if tonumber(time) ~= nil then
		os.execute("Sleep "..tonumber(time))
	else
		Zos.execute("Sleep "..tonumber("0.1"))
	end
end