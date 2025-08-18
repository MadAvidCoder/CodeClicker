extends Control

var achievements = [
	{
		"id": "hello_world",
		"name": "Hello, World!",
		"description": "Write your very first line of code.",
		"requirement": { "type": "total_code_lines", "value": 1 },
		"unlocked": false
	},
	{
		"id": "syntax_student",
		"name": "Syntax Student",
		"description": "Write 100 lines of code.",
		"requirement": { "type": "total_code_lines", "value": 100 },
		"unlocked": false
	},
	{
		"id": "debugging_beginner",
		"name": "Debugging Beginner",
		"description": "Click 10 times in 5 seconds (debug those bugs fast!).",
		"requirement": { "type": "clicks_in_time", "value": 10, "timeframe": 5 },
		"unlocked": false
	},
	{
		"id": "commit_pusher",
		"name": "Commit Pusher",
		"description": "Reach 1,000 lines of code.",
		"requirement": { "type": "total_code_lines", "value": 1000 },
		"unlocked": false
	},
	{
		"id": "automation_script",
		"name": "Automation Script",
		"description": "Unlock your first auto-coder.",
		"requirement": { "type": "auto_coders_bought", "value": 1 },
		"unlocked": false
	},
	{
		"id": "framework_founder",
		"name": "Framework Founder",
		"description": "Unlock 10 code upgrades.",
		"requirement": { "type": "upgrades_bought", "value": 10 },
		"unlocked": false
	},
	{
		"id": "open_source_contributor",
		"name": "Open Source Contributor",
		"description": "Click a rare 'Open Source' event button.",
		"requirement": { "type": "open_source_clicks", "value": 1 },
		"unlocked": false
	},
	{
		"id": "pull_request_pro",
		"name": "Pull Request Pro",
		"description": "Upgrade an auto-coder to level 5.",
		"requirement": { "type": "auto_coder_level", "value": 5 },
		"unlocked": false
	},
	{
		"id": "hackathon_hero",
		"name": "Hackathon Hero",
		"description": "Write 500 lines of code in one minute.",
		"requirement": { "type": "code_lines_in_time", "value": 500, "timeframe": 60 },
		"unlocked": false
	},
	{
		"id": "legacy_maintainer",
		"name": "Legacy Maintainer",
		"description": "Prestige for the first time and start a new project.",
		"requirement": { "type": "prestiges", "value": 1 },
		"unlocked": false
	},
	{
		"id": "million_line_club",
		"name": "Million Line Club",
		"description": "Write 1,000,000 lines of code.",
		"requirement": { "type": "total_code_lines", "value": 1000000 },
		"unlocked": false
	},
	{
		"id": "merge_conflict",
		"name": "Merge Conflict",
		"description": "Reach 50,000 lines of code without buying any upgrades.",
		"requirement": { "type": "total_code_lines", "value": 50000, "no_upgrades": true },
		"unlocked": false
	},
	{
		"id": "code_reviewed",
		"name": "Code Reviewed",
		"description": "Manually click 1,000 times.",
		"requirement": { "type": "manual_clicks", "value": 1000 },
		"unlocked": false
	},
	{
		"id": "dark_theme_activated",
		"name": "Dark Theme Activated",
		"description": "Unlock the dark theme for your editor.",
		"requirement": { "type": "theme_unlocked", "theme": "dark" },
		"unlocked": false
	},
	{
		"id": "full_stack_dev",
		"name": "Full Stack Dev",
		"description": "Own at least one of every upgrade type.",
		"requirement": { "type": "has_each_upgrade_type", "value": 1 },
		"unlocked": false
	},
	{
		"id": "lint_free",
		"name": "Lint Free",
		"description": "Write 10,000 lines of code without any 'bug' events.",
		"requirement": { "type": "code_lines_without_bug", "value": 10000 },
		"unlocked": false
	},
	{
		"id": "refactor_master",
		"name": "Refactor Master",
		"description": "Reset (prestige) five times.",
		"requirement": { "type": "prestiges", "value": 5 },
		"unlocked": false
	},
	{
		"id": "speed_typist",
		"name": "Speed Typist",
		"description": "Achieve 50 clicks in 10 seconds.",
		"requirement": { "type": "clicks_in_time", "value": 50, "timeframe": 10 },
		"unlocked": false
	},
	{
		"id": "documentation_guru",
		"name": "Documentation Guru",
		"description": "View the help/about screen.",
		"requirement": { "type": "viewed_help", "value": 1 },
		"unlocked": false
	},
	{
		"id": "copilot_friend",
		"name": "Copilot Friend",
		"description": "Let an auto-coder write 10,000 lines for you.",
		"requirement": { "type": "auto_lines_written", "value": 10000 },
		"unlocked": false
	}
]

var upgrades = [
	{
		"id": "better_keyboard",
		"name": "Mechanical Keyboard",
		"description": "Type faster and with more satisfaction! +1 code per click.",
		"cost": 50,
		"effect": { "click_power": 1 }
	},
	{
		"id": "dual_monitors",
		"name": "Dual Monitors",
		"description": "Twice the code windows, twice the productivity. +100% auto-code speed.",
		"cost": 200,
		"effect": { "auto_code_multiplier": 2.0 }
	},
	{
		"id": "text_editor_upgrade",
		"name": "Pro Text Editor",
		"description": "Unlock advanced features to boost efficiency. +2 code per click.",
		"cost": 150,
		"effect": { "click_power": 2 }
	},
	{
		"id": "auto_linter",
		"name": "Auto-Linter",
		"description": "Automatically fix simple bugs. +1 code per second.",
		"cost": 300,
		"effect": { "auto_code_per_sec": 1 }
	},
	{
		"id": "coffee_machine",
		"name": "Coffee Machine",
		"description": "Caffeine boost! +50% code per click.",
		"cost": 500,
		"effect": { "click_power_multiplier": 1.5 }
	},
	{
		"id": "code_snippets",
		"name": "Reusable Snippets",
		"description": "Paste code faster using handy snippets. +5 code per click.",
		"cost": 800,
		"effect": { "click_power": 5 }
	},
	{
		"id": "cloud_ide",
		"name": "Cloud IDE",
		"description": "Code from anywhere, anytime. +3 code per second.",
		"cost": 1200,
		"effect": { "auto_code_per_sec": 3 }
	},
	{
		"id": "copilot_ai",
		"name": "AI Copilot",
		"description": "Let AI write boilerplate for you. +100% auto-code speed.",
		"cost": 2500,
		"effect": { "auto_code_multiplier": 2.0 }
	},
	{
		"id": "dark_theme",
		"name": "Dark Theme",
		"description": "Less eye strain means more code! +20% click and auto-code.",
		"cost": 1000,
		"effect": { "click_power_multiplier": 1.2, "auto_code_multiplier": 1.2 }
	},
	{
		"id": "stack_overflow",
		"name": "Stack Overflow Access",
		"description": "Find answers instantly. +10 code per click.",
		"cost": 3000,
		"effect": { "click_power": 10 }
	},
	{
		"id": "standing_desk",
		"name": "Standing Desk",
		"description": "Boosts your health and productivity. +50% auto-code speed.",
		"cost": 5000,
		"effect": { "auto_code_multiplier": 1.5 }
	},
	{
		"id": "continuous_integration",
		"name": "Continuous Integration",
		"description": "Code merges itself while you sleep. +10 code per second.",
		"cost": 8000,
		"effect": { "auto_code_per_sec": 10 }
	},
	{
		"id": "rubber_ducky",
		"name": "Rubber Duck Debugging",
		"description": "Explain your code to the duck and spot more bugs. +2 code per second.",
		"cost": 1300,
		"effect": { "auto_code_per_sec": 2 }
	},
	{
		"id": "faster_internet",
		"name": "Faster Internet",
		"description": "Pages load instantly, docs at your fingertips. +30% auto-code speed.",
		"cost": 2200,
		"effect": { "auto_code_multiplier": 1.3 }
	},
	{
		"id": "standing_meetings",
		"name": "Standing Meetings",
		"description": "Shorter meetings, more time to code! +10% code per click.",
		"cost": 1100,
		"effect": { "click_power_multiplier": 1.1 }
	},
	{
		"id": "unit_tests",
		"name": "Unit Tests",
		"description": "Find bugs before they hit production. +5 code per second.",
		"cost": 4000,
		"effect": { "auto_code_per_sec": 5 }
	},
	{
		"id": "git_aliases",
		"name": "Git Aliases",
		"description": "Type less, push more. +3 code per click.",
		"cost": 2500,
		"effect": { "click_power": 3 }
	},
	{
		"id": "devops_pipeline",
		"name": "DevOps Pipeline",
		"description": "Automate your workflow. +25% to all code generation.",
		"cost": 7000,
		"effect": { "click_power_multiplier": 1.25, "auto_code_multiplier": 1.25 }
	},
	{
		"id": "wireless_mouse",
		"name": "Wireless Mouse",
		"description": "No more cable drag. +1 code per click.",
		"cost": 300,
		"effect": { "click_power": 1 }
	},
	{
		"id": "ergonomic_chair",
		"name": "Ergonomic Chair",
		"description": "Stay comfortable, code longer. +2 code per second.",
		"cost": 1700,
		"effect": { "auto_code_per_sec": 2 }
	},
	{
		"id": "docker_containers",
		"name": "Docker Containers",
		"description": "Deploy faster, debug less. +6 code per second.",
		"cost": 6000,
		"effect": { "auto_code_per_sec": 6 }
	},
	{
		"id": "vim_shortcuts",
		"name": "Vim Shortcuts",
		"description": "Navigate code at the speed of thought. +4 code per click.",
		"cost": 3200,
		"effect": { "click_power": 4 }
	}
]

var clicks = 0
var score = 0
var total_score = 0
var upgrades_bought = 0
var auto_coders_bought = 0
var open_source_clicks = 0
var max_auto_level = 0
var prestige_count = 0
var auto_lines_written = 0
var help_viewed = false

@onready var label = $Label
@onready var subviewport := $AchievementDisplay/SubViewport
@onready var texture_rect := $AchievementDisplay/TextureRect
@onready var display = $AchievementDisplay

func _ready():
	var mat = texture_rect.material
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("rect_size", subviewport.size)

func _process(delta: float) -> void:
	label.text = str(score) + " Lines"
	check_achievements()

func check_unlock(requirements: Dictionary) -> bool:
	if requirements.has("no_upgrades") and upgrades_bought > 0:
		return false
	match requirements["type"]:
		"total_code_lines":
			return total_score >= requirements["value"]
		"manual_clicks":
			return clicks >= requirements["value"]
		"auto_coders_bought":
			return auto_coders_bought >= requirements["value"]
		"upgrades_bought":
			return upgrades_bought >= requirements["value"]
		"open_source_clicks":
			return open_source_clicks >= requirements["value"]
		"auto_coder_level":
			return max_auto_level>= requirements["value"]
		"prestiges":
			return prestige_count >= requirements["value"]
		"auto_lines_written":
			return auto_lines_written >= requirements["value"]
		"viewed_help":
			return help_viewed
	return false

func check_achievements() -> void:
	for ach in achievements:
		if ach["unlocked"]:
			continue
		else:
			if check_unlock(ach["requirement"]):
				ach["unlocked"] = true
				display.display(["Achievement Unlocked!", "[" + ach["name"] + "]", ach["description"]])

func _on_texture_button_pressed() -> void:
	score += 1
	total_score += 1
	clicks += 1
