# Challenge 1: Basic search

The `challenge-1` is to perform some basic search and manipulation of a log file. The file is called `sample.log` and it contains 3360 lines. We need to find out some information from this log file.

To solve the challenges, you can use the following commands in your ubuntu docker container. If you don't have Docker installed, please follow the official Docker installation guide [here](https://docs.docker.com/get-docker/) and then run the following command to start a container with the current directory mounted:
```bash
cd challenge-1
docker run --rm -it --platform linux/amd64 -v $PWD:/workspace -w /workspace ubuntu:latest bash
```

Make sure that you have the `sample.log` file in the current directory by running the following command:
```bash
root@091f9c5609d0:/workspace# ls -l sample.log
-rw-r--r-- 1 root root 214494 Jun 13 09:37 sample.log
```

## 1. Count all lines with 500 HTTP code
### Requirement
- Count all lines with `500` HTTP code.

### Explanation
- The line we are looking for is `500` HTTP Code so having the pattern " 500 " with spaces around it to avoid counting lines that have `500` as part of any number or path (e.g., `1500` or `GET /500-internal`).
- `-c` option in `grep` counts the number of lines that match the pattern. So, we don't have to use `wc -l` to count the lines after `grep`.

### Result
```bash
grep -c " 500 " sample.log
```
result: 714

## 2. Count HTTP Code with specific conditions
### Requirement
- Count all `GET` requests from `yoko` to `/rrhh` location and if it was successful (`200`).

### Explanation
For this challenge, we can use `grep` to filter the lines that matching the criteria. We can use multiple `grep` commands to narrow down the results step by step. Alternatively, we can use `awk` to achieve the same result.

- commands
```bash
# Using grep
grep "yoko" sample.log | grep "GET /rrhh" | grep -c '200'

# Using awk (recommended for large files)
# Log format from sample.log: [date] user - HTTP/version status "METHOD /path"
#              $1     $2  $3    $4          $5    $6      $7
awk '$2 == "yoko" && $6 == "\"GET" && $7 == "/rrhh\"" && $5 == "200"' sample.log | wc -l
```

- Understanding the two different approaches
Simply to understand the differences between the two approaches, we can use `time` command to measure the execution time of both methods.
`time` command outputs three different times:
- `real`: the total elapsed time (wall clock time) from start to finish of the command (what you actually waited)
- `user`: the total CPU time spent in user space (the time spent executing the code of the process)
- `sys`: the total CPU time spent in kernel space (the time spent executing system calls and handling I/O operations)

```bash
root@091f9c5609d0:/workspace# time awk '$2 == "yoko" && $6 == "\"GET" && $7 == "/rrhh\"" && $5 == "200"' sample.log | wc -l
4

awk - single process
real    0m0.042s    
user    0m0.053s - one process doing all the work
sys     0m0.005s - minimal kernel overhead, no pipes

root@091f9c5609d0:/workspace# time grep "yoko" sample.log | grep "GET /rrhh" | grep -c '200'
4

chained grep — 3 processes + pipes
real    0m0.044s
user    0m0.069s - spread across 3 processes
sys     0m0.012s - higher because of pipe management
```

`awk` processes the file in a single pass with one process, while chained `grep` reads 
the file once but streams data through multiple processes and pipe buffers — adding 
overhead that compounds on large files.

### Result
```bash
# Using grep
grep "yoko" sample.log | grep "GET /rrhh" | grep -c '200'

# Using awk (recommended for large files)
awk '$2 == "yoko" && $6 == "\"GET" && $7 == "/rrhh\"" && $5 == "200"' sample.log | wc -l
```
result: 4

> **Note:** For a file of this size (3360 lines), resource differences between both methods 
> are negligible. The `pidstat` output shows minimal memory usage (~5MB RSS) for both. 
> The performance gap becomes significant only at larger scale (1M+ lines).
```bash
pidstat -u -r 1
15:54:42      UID       PID  minflt/s  majflt/s     VSZ     RSS   %MEM  Command
15:54:43        0       580     10.00      0.00  257924    5232   0.13  pidstat

15:54:56      UID       PID  minflt/s  majflt/s     VSZ     RSS   %MEM  Command
15:54:57        0       579      9.90      0.00  257924    5228   0.13  pidstat
```

## 3. How many requests to a path?
### Requirement
- How many requests go to `/`?

### Explanation
- The requirment is to count all requests that go to the path `/`. So we can use the grep to search the pattern of `"METHOD /"` in the log file. The regex pattern `"[A-Z]* /"` matches any HTTP method such as GET, POST, and DELETE etc.

### Result
```bash
grep -c '"[A-Z]* /"' sample.log
```
result: 717


## 4. Count all lines without 5XX HTTP code
### Requirement
- Count all lines _without_ `5XX` HTTP code.

### Explanation
- `grep -v` give to exclude the match of the pattern.
- The regex pattern `5[0-9][0-9]` matches any `5XX` HTTP code.

```bash
grep -v " 5[0-9][0-9] " sample.log | wc -l
```
result: 2191

## 5. Replace all 503 HTTP codes by 500
### Requirement
- Replace all `503` HTTP codes by `500`, how many requests have a `500` HTTP code?

### Explanation
- We can use `sed` to replace all `503` HTTP codes by `500` and then count the number of lines with `500` HTTP code using `grep`.

```bash
sed 's/ 503 / 500 /g' sample.log | grep -c " 500 "
```
result: 1469

