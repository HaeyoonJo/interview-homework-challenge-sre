# Challenge 2: syschekipy Python package

We need to have a Python package that can be used to get system information. In this document, I will provide a overview for the python package information, usage, and how to run it in a virtual environment.

The package name is `syschekipy` to be friendly and directly understandable and it will provide a CLI interface to check system information such as CPU, RAM, Disk, ports, and overview of top 10 process with most CPU usage.

## Requirements
Create a simple Python script that can be used to get system information. The script should provide a comprehensive CLI interface with arguments for each feature.

The features to be implemented are:
- disk stats: volumes, total, used, free, used percentage
- cpu stats: cores, usage, frequency
- ram stats: total, used, free, used percentage
- ports stats: listening ports
- top 10 process with most CPU usage

## Prerequisites
- Python 3.6 or higher
- pip package manager

## Usage
### python virtual env
- First, create a virtual environment and install the requirements.
```bash
cd challenge-2/syschekipy/
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Running the script

To run the script, use the following command:
```bash
python3 syscheki.py
```
Once you run the script, you will see the following output:
```bash
(venv)$ python3 syscheki.py
usage: syschekipy [-h] [-d] [-c] [-p] [-r] [-o]

syschekipy description

optional arguments:
  -h, --help      show this help message and exit
  -d, --disk      check disk stats
  -c, --cpu       check cpu stats
  -p, --ports     check listen ports
  -r, --ram       check ram stats
  -o, --overview  top 10 process with most CPU usage
```

### Examples

1. Check Disk stats
```bash
(venv)$ python3 syscheki.py -d
```
output:
```bash
=== Disk Stats ===
Metric       Size
-----------  -----------------
Total Space  460.4 GiB
Used Space   420.1 GiB (91.0%)
Free Space   40.3 GiB
```


2. Check CPU stats
```bash
(venv)$ python3 syscheki.py -c
```
output:
```bash
=== CPU Stats ===
Metric             Value
-----------------  -------
Physical Cores     10
Logical Cores      10
Total CPU Usage    20.0%
Current Frequency  6 MHz
Context Switches   30,000
```

3. Check Listening Ports
- Run with `sudo`  
  To run it with `sudo`: `sudo python3 syscheki.py`. Otherwise, you will get `Permission Denied.` message and requires you to run it with `sudo` to get the listening ports.

```bash
(venv)$ sudo python3 syscheki.py -p
```
output:
```bash
  PID  Process                    Listening Ports                 Path
-----  -------------------------  ------------------------------  ----------------------------------------------------------------------------------------------------------------------------------------
  535  NWSDaemon                  [21400, 21300]                  /usr/lib/test/path/to/NWSDaemon
  602  rapportd                   [65367]                         /usr/lib/test/path/to/rapportd
  641  ControlCenter              [7000, 5000]                    /usr/lib/test/path/to/ControlCenter
  ...
  ...
```
- Using `netstat`  
  To make sure we have correct output, let's check the actual opened ports with `netstat` command as follows:
```bash
netstat -anvp tcp | awk 'NR<3 || /LISTEN/'
Active Internet connections (including servers)
Proto Recv-Q Send-Q  Local Address          Foreign Address        (state)          rxbytes      txbytes  rhiwat  shiwat    pid   epid state  
tcp6       0      0  *.65367                *.*                    LISTEN                 0            0  131072  131072    602      0 00100 00000006 
tcp4       0      0  *.65367                *.*                    LISTEN                 0            0  131072  131072    602      0 00100 00000006
tcp6       0      0  ::1.24642              *.*                    LISTEN                 0            0  131072  131072    799      0 00100 00000106
tcp4       0      0  127.0.0.1.16494        *.*                    LISTEN                 0            0  131072  131072    949      0 00000 0000020f
tcp4       0      0  127.0.0.1.15393        *.*                    LISTEN                 0            0  131072  131072    949      0 00000 0000020f
~
```
- Filter the port only using `awk`  
  The output of the `netstat` command is too long and we only want to check the port number. So, let's filter the output using `awk` command as follows:
```bash
netstat -anvp tcp | awk 'NR<3 || /LISTEN/' | awk '{print $4}'
(including
Local
*.65367
*.65367
::1.24642
127.0.0.1.16494
127.0.0.1.15393
```

- Conclusion  
  The output of the `syschekipy` script is correct and matches the output of the `netstat` command.

4. Check RAM stats
```bash
(venv)$ python3 syscheki.py -r
```
output:
```bash
=== RAM Stats ===
Metric     Amount (Used / Total)
---------  -----------------------
Total      16.00 GB
Available  4.35 GB
Used       6.18 GB (72.8%)
Swap Used  0.00 GB / 0.00 GB
```

5. Check Overview
- The overview will show the top 10 processes with the most CPU usage
```bash
(venv)$ python3 syscheki.py -o
```
output:
```bash
--------------------Top 10 by CPU---------------------------------
  PID  Process Name                 CPU %    Memory %
-----  ---------------------------  -------  ----------
 2233  Python                       9.80%    0.09%
 3455  Test Process                 6.00%    5.46%
 2111  Stage Process                3.40%    0.67%
 2333  Test Process2                1.40%    0.50%
 2222  Test Process3                1.20%    0.36%
 3827  Test Process4                0.70%    0.65%
 1200  Test Process5                0.80%    0.98%
 1311  Test Process6                0.70%    0.65%
 1528  Test Process7                0.60%    1.15%
  592  Test Process8                0.40%    1.46%
 ```

## Conclusion
The `syschekipy` Python package provides a simple and effective way to gather system information. It offers a user-friendly CLI interface that allows users to check disk, CPU, RAM, and listening ports, as well as an overview of the top 10 processes with the most CPU usage.

The package is simply designed, however, there are many ways to improve it with more features and functionalities. If you have any suggestions or feedback, please feel free to reach out.

Hope you enjoy using it and find it useful for your system monitoring needs.

To exit the virtual environment, simply run:
```bash
deactivate
```