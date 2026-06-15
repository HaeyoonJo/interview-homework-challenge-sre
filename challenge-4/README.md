# Challenge-4: what's wrong?

## Requirements
Oh, no! We don't know what happened to this binary! Can you help us?
When we execute the binary, it always returns `Ooooh, what's wrong? :(`.
How can we fix it? We expected the message `Congrats! :)`.

> _TIP: The binary was compiled for x86_64 Linux._

## Problem
Since the binary is compiled for x86_64 Linux, we can run the binary on a ubuntu container with `--platform linux/amd64` option. This will allow us to execute the binary and see the expected message.

- To start the container with the current directory mounted, run the following command:
```bash
cd challenge-4/
docker run --rm -it --platform linux/amd64 -v $PWD:/workspace -w /workspace ubuntu:latest bash
```
Once you're in the container, you can execute the binary with the following command:
```bash
# Confirm the workspace is mounted correctly and see the binary file
root@dc04a01c379b:/workspace# ls -lh
total 24K
-rwxr-xr-x 1 root root 17K Jun 13 09:37 blackbox

# Execute the binary
root@dc04a01c379b:/workspace# ./blackbox 
Ooooh, what's wrong? :(
```

## Solution
To view binary file, we will use `hexdump` command to see the content of the binary file in hexadecimal format.
If hexdump is not installed in the container, you can install it with the following command:
```bash
apt-get update && apt-get install bsdmainutils
```
Now we can see the hexadecimal format in the binary file.
```bash
root@dc04a01c379b:/workspace# hexdump -C blackbox | grep -i Ooo -B5 -A5
00001240  48 83 c4 08 c3 00 00 00  00 00 00 00 00 00 00 00  |H...............|
00001250  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00002000  01 00 02 00 74 68 65 5f  6d 61 67 69 63 5f 66 69  |....the_magic_fi|
00002010  6c 65 7a 2e 74 78 74 00  43 6f 6e 67 72 61 74 73  |lez.txt.Congrats|
00002020  21 20 3a 29 00 4f 6f 6f  6f 68 2c 20 77 68 61 74  |! :).Ooooh, what|
00002030  27 73 20 77 72 6f 6e 67  3f 20 3a 28 00 00 00 00  |'s wrong? :(....|
00002040  01 1b 03 3b 44 00 00 00  07 00 00 00 e0 ef ff ff  |...;D...........|
00002050  78 00 00 00 10 f0 ff ff  a0 00 00 00 20 f0 ff ff  |x........... ...|
00002060  b8 00 00 00 40 f0 ff ff  60 00 00 00 29 f1 ff ff  |....@...`...)...|
00002070  d0 00 00 00 80 f1 ff ff  f0 00 00 00 f0 f1 ff ff  |................|
```
We can see some strings such as `the_magic_filez.txt.Congrats! :).Ooooh, what's wrong? :(`. However, it's a bit early to decide whether it's really a clue in our case. So I went over the entire `hexdump` metadata and table, I found some clues below:
```bash
00000340  05 00 00 00 47 4e 55 00  02 00 00 c0 04 00 00 00  |....GNU.........|
...
00003010  47 43 43 3a 20 28 55 62  75 6e 74 75 20 39 2e 33  |GCC: (Ubuntu 9.3|
...
00003670  00 63 72 74 73 74 75 66  66 2e 63 00 64 65 72 65  |.crtstuff.c.dere|
...
00003700  79 5f 65 6e 74 72 79 00  6d 61 69 6e 2e 63 00 5f  |y_entry.main.c._
```
Let me touch each line to predict my guess. First of all, `GNU` and `GCC` seems that it's related to C language. Then if you go down more, you can see the original files from `main.c` and `crtstuff.c`.
These gives an answer that the binary file is compiled from C language, so the string we saw eariler above, `the_magic_filez.txt`, `Congrats! :)` and `Ooooh, what's wrong? :(` in the hex values are following `if/else` logic in C language as below:
- "if `the_magic_filez.txt` then `Congrats! :)` else `Ooooh, what's wrong? :(`"

So once we have `the_magic_filez.txt` file in the same directory as the binary, we can execute the binary again and see the expected message `Congrats! :)`.
```bash
root@dc04a01c379b:/workspace# touch the_magic_filez.txt
root@dc04a01c379b:/workspace# ls -lh
total 24K
-rwxr-xr-x 1 root root  17K Jun 13 09:37 blackbox
-rw-r--r-- 1 root root    0 Jun 14 23:53 the_magic_filez.txt
root@dc04a01c379b:/workspace# ./blackbox ; echo
Congrats! :)
```

## Conclusion
Amazingly we have the expected message `Congrats! :)` after creating the `the_magic_filez.txt` file in the same directory as the binary. 

This means that the binary is checking for the existence of `the_magic_filez.txt` file and returning the expected message.

To exit the container, simply type `exit` and press Enter then the container will be removed as we were giving the flag `--rm`.

