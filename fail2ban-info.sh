#!/bin/bash
grep "Ban " /var/log/fail2ban.log | grep `date +%Y-%m-%d -d yesterday` |  mail -s "Fail2Ban Yesterday Summary `date +%Y-%m-%d -d yesterday`" haimch@gmail.com
