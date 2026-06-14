#!/usr/bin/env python3
"""
file name: cpu.py
"""
import psutil
import sys
from tabulate import tabulate

def check_cpu():
    """
    Check cpu statistics.
    """
    try:
        print("=== CPU Stats ===")
        physical_cores = psutil.cpu_count(logical=False) or "N/A"
        logical_cores = psutil.cpu_count(logical=True) or "N/A"
        cpu_usage = psutil.cpu_percent(interval=1, percpu=False)
        freq = psutil.cpu_freq()
        stats = psutil.cpu_stats()
        times = psutil.cpu_times()

        freq_str = f"{freq.current:.0f} MHz" if freq else "N/A"
        ctx_switches = f"{stats.ctx_switches:,}" if stats else "N/A"
        cpu_user_time = f"{times.user:.1f}s" if times else "N/A"

        table_data = [
            ["Physical Cores", physical_cores],
            ["Logical Cores", logical_cores],
            ["Total CPU Usage", f"{cpu_usage}%"],
            ["Current Frequency", freq_str],
            ["Context Switches", ctx_switches]
        ]
        
        headers = ["Metric", "Value"]
        
        print(tabulate(table_data, headers=headers, tablefmt="simple"))
        return True
    except Exception as e:
        print(f"  An unexpected error occurred: {e}", file=sys.stderr)
        return False