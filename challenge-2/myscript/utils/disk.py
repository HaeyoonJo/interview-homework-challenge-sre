#!/usr/bin/env python3
"""
file name: disk.py
"""
import shutil
import sys
from tabulate import tabulate

def check_disk():
    """
    Check disk usage statistics.
    """
    try:
        print("=== Disk Stats ===")
        total, used, free = shutil.disk_usage('/')

        gb = 2**30
        total_gb = total / gb
        used_gb = used / gb
        free_gb = free / gb

        used_percent = (used / total) * 100

        table_data = [
            ["Total Space", f"{total_gb:.1f} GiB"],
            ["Used Space", f"{used_gb:.1f} GiB ({used_percent:.1f}%)"],
            ["Free Space", f"{free_gb:.1f} GiB"]
        ]
        headers = ["Metric", "Size"]
        print(tabulate(table_data, headers=headers, tablefmt="simple"))
        return True
    except Exception as e:
        print(f"  An unexpected error occurred: {e}", file=sys.stderr)
        return False