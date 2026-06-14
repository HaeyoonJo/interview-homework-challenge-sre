#!/usr/bin/env python3
"""
file name:  syscheki.py
Usage:      System information tool
"""

import shutil
import subprocess
import sys
from args import get_cli_args
from utils.disk import check_disk
from utils.cpu import check_cpu
from utils.ports import check_ports
from utils.ram import check_ram
from utils.overview import check_overview

def check_disk_usage(args):
    if args.disk:
        success = check_disk()
        if not success:
            print("Could not read disk stats.")
            return

def check_cpu_stats(args):
    if args.cpu:
        success = check_cpu()
        if not success:
            print("Could not read CPU stats.")
            return

def check_opened_ports(args):
    if args.ports:
        success = check_ports()
        if not success:
            print("Could not read opened ports.")
            return

def check_ram_usage(args):
    if args.ram:
        success = check_ram()
        if not success:
            print("Could not read RAM stats.")
            return

def show_overview(args):
    if args.overview:
        success = check_overview()
        if not success:
            print("Could not read system overview.")
            return

def main():
    args = get_cli_args()
    handlers = {
        "disk":     check_disk_usage(args),
        "cpu":      check_cpu_stats(args),
        "ports":    check_opened_ports(args),
        "ram":      check_ram_usage(args),
        "overview": show_overview(args),
    }

if __name__ == "__main__":
    main()