# Linux Resource Monitor

Bash monitoring tool I built as part of my DevOps learning path. It monitors CPU, RAM, and disk usage on Linux systems and sends Slack alerts when something looks off.

## What it does

The main script (`monitor.sh`) runs on a Linux machine and checks:
- CPU load average
- Memory usage (total and free)
- Disk usage percentage
- Top 3 memory-hungry processes

If disk usage goes above 85%, it sends a warning to a Slack channel via webhook. Everything gets logged to a file with timestamps.

There's also a `setup.sh` script that handles the initial setup - creates log directories, sets permissions, configures cron for hourly runs, and sets up log rotation so the log files don't eat up the disk over time.

## Project structure

```
├── monitor.sh          # Main monitoring script
├── setup.sh            # Deployment & environment setup (run once with sudo)
├── .env                # Slack Webhook URL (not in Git)
├── .github/workflows/  # CI - ShellCheck on every PR
└── .gitignore
```

## How to use

**1. Clone and configure Slack:**
```bash
git clone https://github.com/TheDanielMalka/linux-resource-monitor.git
cd linux-resource-monitor
```

Create a `.env` file:
```
SLACK_WEBHOOK_URL=your_webhook_url_here
```

**2. Run setup (once):**
```bash
sudo ./setup.sh
```

**3. Or run the monitor directly:**
```bash
./monitor.sh
```

## Setup script handles

- OS detection (Ubuntu/CentOS)
- Log directory creation at `/var/log/monitor` with proper permissions (755/644)
- Cron job - monitor runs every hour automatically
- Log rotation - weekly, keeps 4 weeks, compresses old logs

## Tools & technologies

Bash, Linux CLI tools (df, awk, grep, curl), Slack Webhooks, GitHub Actions (ShellCheck), Cron, Logrotate

## What I learned

This project was my hands-on intro to Linux system administration as part of Sprint 2 in my DevOps roadmap. I got to work with shell scripting, file permissions, process management, CI/CD pipelines, and integrating external services (Slack) - all things I'll need as a DevOps engineer.

Built with a professional Git workflow: feature branches, pull requests, smart commits linked to GitHub Issues, and milestone tracking.
