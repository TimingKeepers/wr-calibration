###############################################################################
# revisiondate.tcl      08-Dec-2006

# Calculate Current Date
set current_year [clock format [clock seconds] -format %y]
scan $current_year %d current_year
set current_year_h [expr ($current_year / 10)]
set current_year_l [expr ($current_year - 10 * $current_year_h)]
set current_month [clock format [clock seconds] -format %m]
scan $current_month %d current_month
set current_month_h [expr ($current_month / 10)]
set current_month_l [expr ($current_month - 10 * $current_month_h)]
set current_day [clock format [clock seconds] -format %d]
scan $current_day %d current_day
set current_day_h [expr ($current_day / 10)]
set current_day_l [expr ($current_day - 10 * $current_day_h)]
set current_date [expr (1048576*$current_year_h + 65536*$current_year_l + 4096*$current_month_h + 256*$current_month_l + 16*$current_day_h + $current_day_l)]

# Calculate Current Revision
set revision_log_file "revisiondate_log.txt"

set current_rev_date [clock format [clock seconds] -format %y%m%d]
if [file exists $revision_log_file] { 
    set revision_log_fileptr [open $revision_log_file]
    gets $revision_log_fileptr revision_log_date
    gets $revision_log_fileptr revision_log_revnumber
    close $revision_log_fileptr
    if { [string compare $current_rev_date $revision_log_date] == 0 } {
        # Dates are equal
        set current_revision [expr ($revision_log_revnumber + 1)]
    } else {
        # Dates are unequal
        set current_revision 0
    }
    set revision_log_fileptr [open $revision_log_file w]
    puts $revision_log_fileptr $current_rev_date
    puts $revision_log_fileptr $current_revision
    close $revision_log_fileptr
} else {
    puts "WARNING $revision_log_file not found. Creating new one..."
    set current_revision 0
    set revision_log_fileptr [open $revision_log_file w]
    puts $revision_log_fileptr $current_rev_date
    puts $revision_log_fileptr $current_revision
    close $revision_log_fileptr
}

puts         "###### Synthesis is done with the following settings:"
puts [format "###### DATE:     %x" $current_date]
puts [format "###### REVISION: %d" $current_revision]
###############################################################################

