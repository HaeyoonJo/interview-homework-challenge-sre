#!/usr/bin/env python3
"""
file name: args.py
"""
import argparse
import sys

def build_parser():
    """
    Builds the argument parser for the system information tool.
    :return: parser
    """
    parser = argparse.ArgumentParser(
        prog="myscript.py",
        description=f"Myscript description",
        formatter_class=argparse.RawTextHelpFormatter,
        add_help=False
    )
    parser._optionals.title = "Myscript options"
    parser.add_argument("-d", "--disk",     action="store_true", help="check disk stats")
    parser.add_argument("-c", "--cpu",      action="store_true", help="check cpu stats")
    parser.add_argument("-p", "--ports",    action="store_true", help="check listen ports")
    parser.add_argument("-r", "--ram",      action="store_true", help="check ram stats")
    parser.add_argument("-o", "--overview", action="store_true", help="top 10 process with most CPU usage")

    return parser

def get_cli_args():
    """
    Parses and returns command line arguments.
    :return: parsed arguments namespace
    """
    parser = build_parser()

    if not any(vars(parser.parse_args()).values()):
        parser.print_help()
        sys.exit(0)

    return parser.parse_args()