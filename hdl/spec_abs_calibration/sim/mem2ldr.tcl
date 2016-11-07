###############################################################################
# mem2ldr.tcl      03-Dec-2012
# $1	The first paramter is the filename to be used for input and output

# The names of the input MEM file and the output LDR file:
puts "MEM input file name = [set mem_file "$1.mem"]"
puts "LDR output file name = [set ldr_file "$1.ldr"]"

# The format used by the White Rabbit community (memory_loader_pkg.vhd)
# is "write addr data" for example:
# write 0 2F2F204D
# write 1 454D2066
# write 2 696C652E

puts "LDR file word length = [set wordlength 32] bits"

###############################################################################

set addr_ptr 0

if {[file exists $mem_file]} {
    set mem_fileptr [open $mem_file]
    set ldr_fileptr [open $ldr_file w]
	 set lineCount 0
	while {[gets $mem_fileptr line] >= 0} {
		set lineElements [llength $line]
		# Skip empty and comment lines (preceeded by "//")
		if { $lineElements != 0 && [lindex $line 0] != "//"} {
			for {set x 0} {$x < $lineElements} {incr x} { 
				set lineElem [lindex $line $x]

				# Addresses are preceeded with a "@" character
				if { [string index $lineElem 0] == "@"} {
					set addr [scan $lineElem "@%x"]
					# If the LDR file address pointer did not yet reach the addresses value
					# in the MEM file yhen fill the LDR file with "0" until the LDR file
					# address pointer is lined up.
					while {$addr_ptr < $addr} {
						set ldrline "write "
                  append ldrline [format "%x" $addr_ptr]
                  append ldrline " "
                  append ldrline [format "%08x" 0]
						puts $ldr_fileptr $ldrline
						incr addr_ptr
					}

            } else {

               # Scan a byte from the MEM file
               # every modulo wordlength/8 bytes a new address is written
   				if { $x % int($wordlength/8) == 0} {
                  set ldrline "write "
                  append ldrline [format "%x" $addr_ptr]
                  append ldrline " "
               }
               append ldrline [format "%02x" [scan $lineElem "%x"]]

               # If this is the last line element then...
					if { $x == $lineElements - 1} {
                  # check wether all bytes were read from the LDR line
                  # i.e. the byte pointer points to the last byte of the word
                  if { $x % int($wordlength/8) != int($wordlength/8)- 1} {
                     puts $ldr_fileptr "Warning: word length and bytes per line ($lineElements) are inconsistent!"
                     puts "Warning: word length and bytes per line ($lineElements) are inconsistent!"
                  }
					}
               # when all bytes are scanned then write them to file
   				if { $x % int($wordlength/8) == int($wordlength/8)- 1} {
          			puts $ldr_fileptr $ldrline
	   				incr addr_ptr
               }
				}
			}
#		   # Check wether there are bytes read but the last word is not yet complete
#		   # and the left-over bytes should be padded with eight "0" bits
#			if {$byte_ptr != 0} {
#				for {set padding $byte_ptr} {$padding < [expr (int($wordlength/8))]} {incr padding} {
#					append ldrline "00000000"
#				}
#				puts $ldr_fileptr $ldrline
#				set addr_ptr [expr ($addr_ptr + int($wordlength/8))]
#			}
		}
	}
    close $mem_fileptr
    close $ldr_fileptr
} else {
    puts "WARNING $mem_file not found..."
}

###############################################################################

