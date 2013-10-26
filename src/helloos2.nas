; hello-os
; TAB=4

; Belows are the assembly codes for standard FAT12 floppy disk

start:	DB		0xeb, 0x4e, 0x90; OEM number
		DB		"HELLOIPL"		; Name of the boot sector (8 bytes)
		DW		512				; Each sector size (must be 512 bytes)
		DB		1				; Cluster minimum size like linux's inode (must be 1 sector)
		DW		1				; FAT starting sector (usually from 1st sector)
		DB		2				; Number of FAT Backup (must be 2)
		DW		224				; Root dir  (usually 224) 
		DW		2880			; Disk total sectors (must be 2880 sectors)
		DB		0xf0			; Media Type (disk type, must be 0xf0)
		DW		9				; Each FAT size in sectors (must be 9 sectors)
		DW 		18				; Each track has how many sectors (must be 18)
		DW		2				; Head number (must be 2)
		DD 		0				; No partition, no special hidden sectors (must be 0)
		DD		2880			; Totoal sectors for rewriting disk once
		DB		0,0,0x29		; Number of physical drivers and ying dao qian zheng
		DD		0xffffffff		; Serial number of volumes
		DB		"HELLO-OS   "	; Volumn labels (11 bytes)
		DB		"FAT12   "		; Volumn format label (8 byets)
		RESB	18				; Reserve 18 bytes

; Main body of program
	
		DB		0xb8, 0x00, 0x00, 0x8e, 0xd0, 0xbc, 0x00, 0x7c
		DB		0x8e, 0xd8, 0x8e, 0xc0, 0xbe, 0x74, 0x7c, 0x8a
		DB		0x04, 0x83, 0xc6, 0x01, 0x3c, 0x00, 0x74, 0x09
		DB		0xb4, 0x0e, 0xbb, 0x0f, 0x00, 0xcd, 0x10, 0xeb
		DB		0xee, 0xf4, 0xeb, 0xfd
	
; Information Display
	
		DB		0x0a, 0x0a		; Two RETURNs
		DB		"Hello, World"
		DB		0x0a			; Return
		DB		"Nice Job, Guopeng!"
		DB		0x0a			; Return
		DB		0
len:	EQU		$-start			; Calculate length so far
		RESB 	0x1fe-len		; Reserve until 0x001fe (510 bytes)
		DB		0x55, 0xaa		; Must as such, so that booting can continue
	
; Besides Booting
	
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	4600
		DB		0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
		RESB	1469432
