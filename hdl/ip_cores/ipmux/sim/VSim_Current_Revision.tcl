# VSim_Current_Revision.tcl

puts "current year = [set current_year [scan [clock format [clock seconds] -format %y] %d]]"
set current_year_h [expr ($current_year / 10)]
set current_year_l [expr ($current_year - 10 * $current_year_h)]
puts "current month = [set current_month [scan [clock format [clock seconds] -format %m] %d]]"
set current_month_h [expr ($current_month / 10)]
set current_month_l [expr ($current_month - 10 * $current_month_h)]
puts "current day = [set current_day [scan [clock format [clock seconds] -format %d] %d]]"
set current_day_h [expr ($current_day / 10)]
set current_day_l [expr ($current_day - 10 * $current_day_h)]
set current_date [expr (1048576*$current_year_h + 65536*$current_year_l + 4096*$current_month_h + 256*$current_month_l + 16*$current_day_h + $current_day_l)]

puts "current revision = [set current_revision 1]"

