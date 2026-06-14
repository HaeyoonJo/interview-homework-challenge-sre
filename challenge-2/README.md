# Challenge 2: syschekipy Python package

- Project name: syschekipy
- Project description: A Python package for system checks (CPU, RAM, Disk, ports, and process overview)

## Requirements
Create a simple Python script that can be used to get system information. The script should have the following CLI interface:

```sh
Usage: syschekipy [options..]
Syschekipy description

Syschekipy options:
  -d, --disk       check disk stats
  -c, --cpu        check cpu stats
  -p, --ports      check listen ports
  -r, --ram        check ram stats
  -o, --overview   top 10 process with most CPU usage.
```

- disk stats: volumes, total, used, free, used percentage
- cpu stats: cores, usage, frequency
- ram stats: total, used, free, used percentage
- ports stats: listening ports
- top 10 process with most CPU usage