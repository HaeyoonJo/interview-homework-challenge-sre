#!/usr/bin/env python3
"""
file name: ram.py
"""
import psutil
import sys
from tabulate import tabulate

def check_ram():
    """
    Check RAM statistics.
    """
    try:
        print("=== RAM Stats ===")
        mem = psutil.virtual_memory()
        sw = psutil.swap_memory()
        gb = 1024 ** 3
        threshold = 100 * 1024 * 1024

        table_data = [
            ["Total", f"{mem.total / gb:.2f} GB"],
            ["Available", f"{mem.available / gb:.2f} GB"],
            ["Used", f"{mem.used / gb:.2f} GB ({mem.percent:.1f}%)"],
            ["Swap Used", f"{sw.used / gb:.2f} GB / {sw.total / gb:.2f} GB"]
        ]
        headers = ["Metric", "Amount (Used / Total)"]
        print(tabulate(table_data, headers=headers, tablefmt="simple"))       
        if mem.available <= threshold:
            print("  Warning: Low memory available!")
        return True
    except Exception as e:
        print(f"  An unexpected error occurred: {e}", file=sys.stderr)
        return False