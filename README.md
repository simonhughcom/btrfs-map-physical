# btrfs-map-physical
Tool to calculate resume_offset for btrfs

Copied from [osandov-linux](https://github.com/osandov/osandov-linux/blob/master/scripts/btrfs_map_physical.c) without the rest of the scripts I don't need

## Instructions for hibernation
1. Compile with `make all`
2. run `./btrfs_map_physical /path/to/swapfile`

Example output:
```
FILE OFFSET  EXTENT TYPE  LOGICAL SIZE  LOGICAL OFFSET  PHYSICAL SIZE  DEVID  PHYSICAL OFFSET
0            regular      4096          2927632384      268435456      1      4009762816
4096         prealloc     268431360     2927636480      268431360      1      4009766912
268435456    prealloc     268435456     3251634176      268435456      1      4333764608
536870912    prealloc     268435456     3520069632      268435456      1      4602200064
805306368    prealloc     268435456     3788505088      268435456      1      4870635520
1073741824   prealloc     268435456     4056940544      268435456      1      5139070976
1342177280   prealloc     268435456     4325376000      268435456      1      5407506432
1610612736   prealloc     268435456     4593811456      268435456      1      5675941888
```

3. Note the first physical offset returned by this tool. In this example, we
   use `4009762816`
4. Get the pagesize with `getconf PAGESIZE`
5. To compute the resume_offset value, divide the physical offset by the
   pagesize. In this example, it is `4009762816 / 4096 = 978946`
6. Set the `resume=swap_device` and `resume_offset=swap_file_offset` kernel
   parameters.
   For example, for grub: 
    Add `GRUB_CMDLINE_LINUX="resume=UUID=ROOT_UUID resume_offset=RESUME_OFFSET`
    in `/etc/default/grub` and then regenerate the grub configuration.

See [Arch Wiki](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation_into_swap_file_on_Btrfs) for more information
