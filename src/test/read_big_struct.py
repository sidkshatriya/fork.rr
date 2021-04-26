from util import *

send_gdb('b breakpoint')
expect_gdb('Breakpoint 1')

send_gdb('c')
expect_gdb('Breakpoint 1, breakpoint')

send_gdb('f 1')
expect_gdb('(rd)')

send_gdb('p big')
expect_gdb("bytes = 'Z'")

ok()
