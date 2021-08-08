# syscall numbers (/usr/include/asm/unistd_64.h)
.equiv SYS_READ, 0
.equiv SYS_WRITE, 1
.equiv SYS_OPEN, 2
.equiv SYS_CLOSE, 3
.equiv SYS_BRK, 12
.equiv SYS_EXIT, 60

# options for open
# (/usr/include/asm-generic/fcntl.h)
# (/usr/include/bits/fcntl-linux.h)
.equiv O_RDONLY, 0
# in octal (leading zero)
.equiv O_WRONLY, 01
.equiv O_CREAT, 0100
.equiv O_TRUNC, 01000
.equiv O_APPEND, 02000

# standard file descriptors (/usr/include/unistd.h)
.equiv STDIN, 0
.equiv STDOUT, 1
.equiv STDERR, 2

# return value of read when end of file is reached (man 2 read)
.equiv END_OF_FILE, 0
