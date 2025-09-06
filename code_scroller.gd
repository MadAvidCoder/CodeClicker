extends Control

const code_lines = [
	"$  for (int i = 0; i < 256; i++) { buffer[i] = decrypt(input[i], key + i); // Decrypt buffer with rolling key }",
	"$  if (flag == true && is_admin(user)) { log_access(user, timestamp); send_alert('admin login'); }",
	"$  def hack_the_system(username, password, ip_address, port): # Attempt remote exploit and log results",
	"$  while (connection.is_active() and retries < MAX_RETRIES) { send_ping(); await_response(); sleep(2); }",
	"$  console.log('Access granted: ' + user_id + ', session token: ' + session.token()); // Log on success",
	"$  # TODO: Refactor this method to support multi-threading and asynchronous callback handling",
	"$  sudo rm -rf / --no-preserve-root; echo 'System wipe initiated by user ' + admin_name",
	"$  let x = Math.random() * Math.floor((Date.now() % 1000) / 2); processValue(x, 'randomizer')",
	"$  public static void main(String[] args) { System.out.println('System Boot: ' + LocalDateTime.now()); }",
	"$  echo 'HAXXORZ! File transfer started at '$(date)'; uploading to remote server: 192.168.1.99'",
	"$  try { connect(server_ip, port); authenticate(token, 'elevated'); } catch (e) { log_error(e); }",
	"$  class EliteHacker extends SuperUser { override fun exploit(target: Device) = target.openPort(22); }",
	"$  import os, sys; os.system('python3 run_attack.py --target ' + sys.argv[1])",
	"$  var password = 'hunter2'; var salt = generate_salt(); store_hash(hash(password, salt), user_id)",
	"$  # Begin brute force: for pw in pw_list: if try_login(user, pw): log_success(user, pw)",
	"$  scp /var/log/syslog admin@192.168.1.253:/home/admin/backups/syslog_$(date +%s).gz",
	"$  SELECT username, password_hash FROM users WHERE last_login > NOW() - INTERVAL '24 HOURS';",
	"$  nmap -A -T4 -p 1-65535 -oN scan_results.txt --script vuln 10.0.0.0/24",
	"$  sshpass -p 'hunter2' ssh -o StrictHostKeyChecking=no root@10.10.10.10 'shutdown -h now'",
	"$  # Loop through all open ports and attempt to fingerprint running services for exploit candidates",
	"$  curl -s -H 'Authorization: Bearer $TOKEN' https://api.internal.net/v2/records | jq '.items[]'",
	"$  grep --color -E 'ERROR|FAIL|DENIED' /var/log/auth.log | tee /tmp/auth_errors.txt",
	"$  printf 'Exploit complete. Total time: %d seconds >> /tmp/exploit_log.txt",
	"$  python3 scan_and_infect.py --network 172.16.0.0/16 --mode=stealth --report=infected_hosts.log",
	"$  # This script will attempt to escalate privileges and report the outcome to the central logging server",
	"$  find /etc -type f -name '*.conf' -exec cat {} + | grep -i 'password' > /tmp/config_passwords.txt",
	"$  export SESSION_ID=$(openssl rand -hex 32); echo 'Session created: '$SESSION_ID",
	"$  tail -f /var/log/secure | awk '{if($3==\"sshd\") print $0;}' | tee /tmp/ssh_activity.log",
	"$  if (os.name == 'posix') { subprocess.call(['chmod', '+x', '/usr/local/bin/hacktool']) }",
	"$  while read line; do echo \"$line\" | base64 --decode >> /tmp/decoded_data.txt; done < encoded.txt",
	"$  // Scan for open endpoints and log every response time for statistical anomaly detection",
	"$  perl -e 'use Socket;$i=\"10.0.0.5\";$p=31337;socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));'",
	"$  netstat -an | grep 'LISTEN' | awk '{print $4, $6}' > /tmp/open_ports.txt",
	"$  # Automated backup: tar -czvf /backup/config_$(date +%Y%m%d).tar.gz /etc /var/www /opt"
]
const code_color: Color = Color(0.2, 1.0, 0.3)
const bg_color: Color = Color(0.02, 0.06, 0.08)
const max_display_lines = 26

var display_lines = []
var typing_line: String = ""
var typing_index: int = 0
var typing: bool = false
var time_since: float = 0

@onready var label: Label = $Label

func _ready():
	label.text = ""
	label.modulate = code_color
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.set_anchors_preset(Control.PRESET_FULL_RECT)

	_start_new_typing_line()
	typing = true


func _draw():
	draw_rect(Rect2(Vector2.ZERO, size), bg_color, true)

func _start_new_typing_line():
	typing_line = code_lines[randi() % code_lines.size()]
	typing_index = 0

func _finish_line():
	display_lines.append(typing_line)
	typing_index = 0
	if display_lines.size() > max_display_lines:
		display_lines.pop_front()
	_update_label()

func _update_label():
	var to_show = ""
	for l in display_lines:
		to_show += l + "\n"
	to_show += typing_line.left(typing_index)
	label.text = to_show

func _process(delta):
	label.size = size
	queue_redraw()

	time_since += randf_range(0.6, 1) * delta
	if typing:
		if time_since > 0.02:
			time_since = 0
			if typing_index < typing_line.length() and typing_index < 93:
				typing_index += 2
				_update_label()
			else:
				_finish_line()
				typing = false
				time_since = 0
	else:
		if time_since > 0.06:
			time_since = 0
			typing = true
			_start_new_typing_line()
