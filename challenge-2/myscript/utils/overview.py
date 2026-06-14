#!/usr/bin/env python3
"""
file name: overview.py
"""
import psutil
import sys
import time
from tabulate import tabulate

def check_overview():
    try:
        print("--------------------Top 10 by CPU---------------------------------")
        processes = []

        for proc in psutil.process_iter(['pid', 'name', 'username']):
            try:
                proc.cpu_percent(interval=None) 
                processes.append(proc)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        time.sleep(0.1)
        process_list = []
        for proc in processes:
            try:
                p_info = proc.as_dict(attrs=['pid', 'name', 'cpu_percent', 'memory_percent'])
                process_list.append(p_info)
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        cpu_top = sorted(process_list, key=lambda i: i['cpu_percent'] or 0, reverse=True)
        table_data = []
        for proc in cpu_top[:10]:
            table_data.append([
                proc.get('pid', 'N/A'),
                proc.get('name', 'N/A'),
                f"{proc.get('cpu_percent', 0):.2f}%",
                f"{proc.get('memory_percent', 0):.2f}%"
            ])
        headers = ["PID", "Process Name", "CPU %", "Memory %"]
        print(tabulate(table_data, headers=headers, tablefmt="simple"))
        return True
    except Exception as e:
        print(f"  An unexpected error occurred: {e}", file=sys.stderr)
        return False