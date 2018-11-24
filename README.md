# max1000_flashrom
Flash the QSPI (Winbond W74M64FVSSIQ) of the MAX1000 via flashrom


The Arrow MAX1000 has a FT2232H which can be used to program the QSPI flash (W74M64FVSSIQ).
This flash is not supported by Quartus 18.1 so far.

To use the FT2232 for programming, the FPGA needs to be programmed such that the QSPI pins 
are connected with FTDI chip.

With the given implementation the divisor of 1 and 2 are not working. Might be some timing problems or
even issues w.r.t. signal integrity. Additionally port B of the FT2232H must be used.

```
ubuntu:~/Desktop$ flashrom -p ft2232_spi:type=2232H,port=B,divisor=4
flashrom v0.9.9-r1954 on Linux 4.15.0-39-generic (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Calibrating delay loop... OK.
Found Winbond flash chip "W25Q64.V" (8192 kB, SPI) on ft2232_spi.
```

To flash an intel hex file, the file must be converted to binary.
```
arm-none-eabi-objcopy -I ihex --output-target=binary flash_0.hex flash_0.bin
```

The binary itself must match the flash size, therefore, we have to pad it.
```
dd if=/dev/null of=flash_0.bin bs=1 count=0 seek=8388608
```

Now we can flash it
```
ubuntu:~/Desktop$ flashrom -p ft2232_spi:type=2232H,port=B,divisor=4 -w flash_0.bin 
flashrom v0.9.9-r1954 on Linux 4.15.0-39-generic (x86_64)
flashrom is free software, get the source code at https://flashrom.org

Calibrating delay loop... OK.
Found Winbond flash chip "W25Q64.V" (8192 kB, SPI) on ft2232_spi.
Reading old flash chip contents... done.
Erasing and writing flash chip... Erase/write done.
Verifying flash... VERIFIED.
```