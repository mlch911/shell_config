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
		bundleID = 'com.tdesktop.Telegram',
	}
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

hs.urlevent.bind('launchOrHide', function (eventName, params)
	local app_bundle_id = config.applications[params["name"]].bundleID
	local app = hs.application.get(app_bundle_id)

	if not app then
		hs.application.open(app_bundle_id)
	elseif app:isFrontmost() and #app:visibleWindows() > 0 then
		app:hide()
		if not app:isHidden() then
			for _, window in pairs(app:allWindows()) do
				window:close()
			end
		end
	else
		hs.application.launchOrFocusByBundleID(app:bundleID())
	end
end)
