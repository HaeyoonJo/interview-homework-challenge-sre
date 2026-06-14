#!/usr/bin/env python3
"""
file name: ports.py
"""
import psutil
import sys
from tabulate import tabulate

def check_ports():
    """
    List all the ports opened by processes on the local machine
    """
    try:
        print("=== Listen Ports ===")
        connections = {}
        table_data = []
        for c in psutil.net_connections(kind='inet'):
            if c.status == 'LISTEN' and c.pid:
                connections[c.pid] = connections.get(c.pid, set())
                if len(c.laddr) >  1:
                    connections[c.pid].add(c.laddr.port)

        for k, v in connections.items():
            try:
                p = psutil.Process(k)
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                print("Process PID:", k, "Ports:", list(v), "(Access Denied/Zombie)")
            table_data.append([k, p.name(), list(v), p.exe()])
        
        table_data.sort(key=lambda x: x[0])

        headers = ["PID", "Process", "Listening Ports", "Path"]
        print(tabulate(table_data, headers=headers, tablefmt="simple"))
        return True
    except (PermissionError, psutil.AccessDenied):
        print(f"  Permission Denied. Please run this script with 'sudo' to view network connections.")
        return False