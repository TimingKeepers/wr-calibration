#! /usr/bin/python

"""
counter_agilent_53230A.py: A program to record dat from the counter.
Copyright (C) 2016  T.J.Pinkert

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

"""Allan variance measurement program, to be used for the Agilent 53230A.

connects to the counter by TCP/IP and set upo the counter to count gapless gate times. 
"""

import time
import datetime
import sys
import thread
from Tkinter import * #TJP: how ugly
#from Tkinter import ttk #TJP: how ugly
import unit_conversion as uc
import utility_functions as uf
import socket
from optparse import OptionParser


#########################################
## Some functions for use by this program
#########################################
def onExit():
    isactive=0
    root.destroy()

def counter_write(counter, command):
    """Write command to counter
    
    counter: socket.socket()
    command: SCPI command string (with or without newline termination)
    """
    if command[-1]!="\n":
        command+="\n"
    counter.send(command)

def counter_read(counter, buffer_size=1024, split_output=True, filter_error_value=True):
    """Read out the results from the counter taking into account the way the
    counter signals the length of the result to read. Empty string entries are
    always removed from the list
    
    counter: counter instance
    buffer_size: amount of bytes to read in one go
    split_output: default True, split the output string into a list at ","
    filter_error_value: filter error values out of the list
    
    returns: output string or list of output strings.
    """
    tmp_buffer=counter.recv(buffer_size)

    #we have data as output
    if tmp_buffer[0]=="#":
        #read the length of the output
        len_bytes=int(tmp_buffer[1])
        bytes_to_read=int(tmp_buffer[2:2+len_bytes])
        if 2+len_bytes+bytes_to_read < buffer_size:
            end_buffer=2+len_bytes+bytes_to_read
        else:
            end_buffer=buffer_size-1

        output_buffer=tmp_buffer[2+len_bytes:end_buffer]
        bytes_to_read-=buffer_size
        
        #print "tmp_buffer length in bytes:", tmp_buffer[:2], tmp_buffer[2:2+len_bytes], len(output_buffer), bytes_to_read

        #read up to end of output if needed.
        while bytes_to_read > -1:
            tmp_buffer=counter.recv(buffer_size)
            if bytes_to_read < buffer_size:
                end_buffer=bytes_to_read
            else:
                end_buffer=buffer_size-1
            output_buffer+=tmp_buffer
            bytes_to_read-=buffer_size

    #we have output from a normal system command like *IDN?
    elif len(tmp_buffer)>0:
        output_buffer=tmp_buffer
        while len(tmp_buffer)==buffer_size:
            tmp_buffer=counter.recv(buffer_size)
            output_buffer+=tmp_buffer

    #we had no output...
    else:
        output_buffer=[]

    #split output in list if requested
    if split_output:
        output_buffer=output_buffer.split(",")

        #strip unwanted whitespace and endlines from start and end of strings
        for i in range(len(output_buffer)):
            output_buffer[i]=output_buffer[i].strip()
                    
        #remove entries after an error
        if filter_error_value:
            remove_from=-1
            for i in range(len(output_buffer)):
                if output_buffer[i] == "+9.91000000000000E+037" and remove_from < 0:
                    remove_from=i+1
            if remove_from > 0:
                output_buffer=output_buffer[:remove_from]
                print "output_buffer removed up from index:", remove_from, "with value: ",output_buffer[remove_from-1]

        #remove empty strings from buffer...
        for i in range(len(output_buffer)-1,-1,-1):
            if output_buffer[i] == "":
                output_buffer.pop(i)

    return output_buffer

def counter_write_read(counter, command="R?", buffer_size=1024):
    """Read out the results from the counter taking into account the way the
    counter signals the length of the result to read.
    
    counter: counter instance
    command: SCPI command to write
    
    returns: fields of the readout in an array.
    """
    counter_write(counter, command)
    output_buffer=counter_read(counter, buffer_size)

    return output_buffer
    


#########################
# Beginning of program. #
#########################
usage = 'usage: %prog [options]'
parser = OptionParser(usage=usage)
parser.add_option("-a", "--ip_address", dest="ip_address", type="str", default="10.0.0.2", help="IP address of the counter (default: 10.0.0.2)")
parser.add_option("-p", "--port", dest="ip_port", type="int", default=5025, help="IP port number of the counter (default: 5025)")

(options, args) = parser.parse_args()
#print options, args

#Some things for the multithreaded measurement bit.
killed=0

#for debugging/monitoring purposes
PRINT_FILE_OUTPUT=True

root = Tk()
root.title('Counter Allan Deviation measurement (agilent 53230A)')
root.protocol("WM_DELETE_WINDOW", onExit)

counter = None #Counter instances
counter_ip = options.ip_address #Counter ip address
counter_port = options.ip_port #Counter measurement channels
counter_gate_time = DoubleVar() #Counter gate times
counter_gate_time.set(1.0)
counter_modes=["RCON","CONT"]
counter_modes_display=["Pi gating", "Lambda gating"]
reference_modes=["EXT","INT"]
reference_modes_display=["External", "Internal"]
# CONT: resolution enhanced counting, Modified Allan Dev. (Mod. ADEV)
# RCON: reciprocal counting, Normal Allan Dev. (ADEV).
counter_mode=counter_modes[0]
reference_mode=reference_modes[0]
n_measurements = IntVar()
n_measurements.set(1000000)
gui_read_every = IntVar()
gui_read_every.set(5)

try:
    #NOTE: clear=1 failes
    counter = socket.socket()
    counter.connect((counter_ip, counter_port))
except:
    print 'Can\'t start counter on ip address',str(counter_ip)
    counter=None
    sys.exit(1)

if counter:
    counter_identity=counter_write_read(counter, "*RST;*CLS;*IDN?")
    if counter_identity[1] == "53230A" and counter_identity[3][:5] == "01.09":
        print "Warning: Counter does not support continuous reciprocal counting, update firmware!"
        counter_modes.pop(0)
        counter_modes_display.pop(0)
        counter_mode=counter_modes[0]
    
base_directory=""
base_name_suffix="_%s_counter_agilent_53230A.dat"%(counter_ip)
output_file=StringVar()
output_file.set(base_directory+uf.create_date_name(base_directory, base_name_suffix=base_name_suffix))

#variables read by the measurement loop, take these in order to avoid deadlocks
#on the setter and getter methods
frequency=DoubleVar()
frequency.set(0.0)
exp_freq=DoubleVar()
exp_freq.set(60.0e6)
file_pointer=None
isactive=0
write_to_file=0
new_file=True

class App(Frame):
    def __init__(self, master=None):
        Frame.__init__(self,master)

        #arrange access to global variables
        self.thread_id=None

        #make gui
        self.create_gui()
        
        #setup counter
        self.__counter_setup(counter_mode, counter_gate_time.get())
    
    def __counter_setup(self, counter_mode, gate_time):
        """Set up counter.
        
        counter_mode: mode of the counter RCON for allan dev.
        exp_freq: expected frequency
        """
        # set up counter in default (=RCON) mode
        print "Counter set up routine"
        counter_write(counter, "*RST;*CLS")
        counter_write(counter, "SYST:TIMEOUT INF") #set system timeout to infinite, otherwise the counting ends after SYST:TIMEOUT seconds...
        counter_write(counter, "SENS:ROSC:SOUR "+reference_mode) #explicitly set external reference
        counter_write(counter, "SENS:ROSC:EXT:FREQ 10e6") #explicitly set 10 MHz
        counter_write(counter, "SENS:FREQ:MODE "+counter_mode)
        print "Set measurement mode to:",counter_mode
        counter_write(counter, "SENS:FREQ:GATE:SOUR TIME")
        counter_write(counter, "SENS:FREQ:GATE:TIME "+str(gate_time))
        print "Set gate time to:",str(gate_time)
        counter_write(counter, "INP:COUP AC") #AC coupled input
        counter_write(counter, "INP:LEV:AUTO OFF") # automatic determination of measurement levels off
        counter_write(counter, "INP:LEV 0.0") # set level to 0 volt (for AC coupled signals)
        counter_write(counter, "TRIG:SOUR IMM")
        counter_write(counter, "TRIG:DEL 0.0")
        counter_write(counter, "TRIG:COUNT 1000000")

    def create_gui(self):
        """Create the graphical user interface
        """
        self.write_to_file=IntVar()
        self.write_to_file.set(0)
        self.isactive=IntVar()
        self.isactive.set(0)


        self.grid()

        Checkbutton(self,text="Start/stop measurement",command=self.start_stop_measurement,variable=self.isactive).grid(row=0,column=0,sticky=W)
        Label(self, text="Counter Mode:").grid(row=0, column=1, sticky=E)
        self.counter_mode_display=Spinbox(self, text="Counter Mode:", values=counter_modes_display, wrap=True, state="normal", command=self.set_counter_mode)
        self.counter_mode_display.grid(row=0, column=2, sticky=W)

        Label(self, text="Reference Mode:").grid(row=1, column=1, sticky=E)
        self.reference_mode_display=Spinbox(self, text="Reference Mode:", values=reference_modes_display, wrap=True, state="normal", command=self.set_reference_mode)
        self.reference_mode_display.grid(row=1, column=2, sticky=W)

        Label(self,text="Output file:").grid(row=2,column=0,sticky=W)
        Entry(self,textvariable=output_file,width=50).grid(row=2,column=1,columnspan=2,sticky=EW,)

        Checkbutton(self,text="Write to file", command=self.start_stop_write_to_file, variable=self.write_to_file).grid(row=3,column=1,sticky=W)

        counterbase=5
        Label(self,text="").grid(row=0+counterbase, column=1)
        
        Label(self,text="Counter Properties (can only be changed before start)").grid(row=1+counterbase,column=0,columnspan=2,sticky=EW)
        
        Label(self,text="Gate time:").grid(row=2+counterbase,column=0,sticky=E)
        Entry(self,textvariable=counter_gate_time).grid(row=2+counterbase,column=1,sticky=W)
        Label(self,text="Number of meas.:").grid(row=3+counterbase,column=0,sticky=E)
        Entry(self,textvariable=n_measurements).grid(row=3+counterbase,column=1,sticky=W)
        Label(self,text="Read every n counts:").grid(row=4+counterbase,column=0,sticky=E)
        Entry(self,textvariable=gui_read_every).grid(row=4+counterbase,column=1,sticky=W)
        Label(self,text="Expected frequency:").grid(row=5+counterbase,column=0,sticky=E)
        Entry(self,textvariable=exp_freq).grid(row=5+counterbase,column=1,sticky=W)
        
        Label(self, text="Frequency").grid(row=1+counterbase, column=2, sticky=EW)
        Label(self,textvariable=frequency).grid(row=2+counterbase, column=2, sticky=EW)


    def start_stop_measurement(self):
        global isactive
        if self.isactive.get():
            isactive=1
            self.start_counting()
        else:
            self.__counter_setup(counter_mode, counter_gate_time.get())
            isactive=0

    def start_counting(self):
        self.thread_id = thread.start_new_thread(Measurement,())

    def start_stop_write_to_file(self):
        global write_to_file, file_pointer
        if self.write_to_file.get():
            new_file=True
            file_pointer=open(output_file.get(), "w")
            write_to_file=1
        else:
            write_to_file=0
            file_pointer.close()
            file_pointer=None
            output_file.set(base_directory+uf.create_date_name(base_directory, base_name_suffix=base_name_suffix))

    def set_counter_mode(self, ):
        global counter_mode, counter_modes, counter_modes_display
        counter_mode=counter_modes[counter_modes_display.index(self.counter_mode_display.get())]

    def set_reference_mode(self, ):
        global reference_mode, reference_modes, reference_modes_display
        reference_mode=reference_modes[reference_modes_display.index(self.reference_mode_display.get())]

def Measurement():
    global file_pointer, counter, new_file
    #initial fetching of the gui variables
    loc_gate_time=counter_gate_time.get()
    loc_verbose=1
    freq_buffer=[]
    filecounter=0
    restart_counter=False
    read_every=gui_read_every.get()   #read in portions of n counts
    flush_every_n_counts=read_every    #flush in portions of n counts (this can block the program...)
        
    print "Configuring counter for measurement loop:"
    counter_write(counter, "SENS:ROSC:SOUR "+reference_mode) #explicitly set external reference
    counter_write(counter, "SENS:ROSC:EXT:FREQ 10e6") #explicitly set 10 MHz
    counter_write(counter, "SENS:FREQ:MODE "+counter_mode)
    counter_write(counter, "SENS:FREQ:GATE:TIME %g"%counter_gate_time.get())
    print "Set gate time to: %f"%(counter_gate_time.get())
    counter_write(counter, "SAMP:COUNT %i"%n_measurements.get())
    print "start counting"
    counter_write(counter, "INIT:IMM")
    print "Reference oscillator is:", counter_write_read(counter, "SENS:ROSC:SOUR?")[0].strip()
#    print "Check for valid external reference", counter_write(counter, "SENS:ROSC:EXT:CHECK"), counter_read()[0].strip()
    print "Counter working in:", counter_write_read(counter, "SENS:FREQ:MODE?")[0].strip(), "mode."
    print "Counter gate time set to:", counter_write_read(counter, "SENS:FREQ:GATE:TIME?"), "seconds."
    total_readouts=0 #in order to issue init:imm when we reach 1.000.000 measurements (or n_measurements.get())

    #save start time
    start = datetime.datetime.utcnow()
    first_round=True

    while(isactive):
        #restart the counter after an error...
        if restart_counter:
            #bute force reconnect, abort counting and flush the counter buffer
            #reconnect is apparently needed to clear the error queue
            print "errors: ",counter_write_read(counter,"SYST:ERR?",1024)
            print "abort counting"
            counter_write(counter, "ABORT")
            
            #reconnect the counter...
            counter.close()
            counter=socket.socket()
            counter.connect((counter_ip, counter_port))
            
            print "reset counter"
            counter_write(counter, "STAT:PRES; *RST; *CLS")            
            time.sleep(counter_gate_time.get()+0.1)

            # set up counter in RCON/CONT mode
            print "setup counter again"
            counter_write(counter, "SYST:TIMEOUT INF") #set system timeout to infinite, otherwise the counting ends after SYST:TIMEOUT seconds...
            counter_write(counter, "SENS:FREQ:MODE "+counter_mode)
            print "Set measurement mode to:",counter_mode
            counter_write(counter, "SENS:FREQ:GATE:SOUR TIME")
            counter_write(counter, "SENS:FREQ:GATE:TIME "+str(gate_time))
            print "Set gate time to: %f"%(counter_gate_time.get())
            counter_write(counter, "INP:COUP AC") #AC coupled input
            counter_write(counter, "INP:LEV:AUTO OFF") # automatic determination of measurement levels off
            counter_write(counter, "INP:LEV 0.0") # set level to 0 volt (for AC coupled signals)
            counter_write(counter, "SAMP:COUNT %i"%n_measurements.get())

            #a new file to write to.
            print "create new filepointer"
            file_pointer.close()
            output_file.set(base_directory+uf.create_date_name(base_directory, base_name_suffix=base_name_suffix))
            file_pointer=None
            file_pointer=open(output_file.get(), "w")            

            #start counting
            print "start counting"
            counter_write(counter, "INIT:IMM")
            print "Counter working in:",counter_write_read(counter, "SENS:FREQ:MODE?")[0].strip(), "mode."
            #save start time
            start = datetime.datetime.utcnow()
            first_round=True
            restart_counter=False

        freq_buffer=counter_write_read(counter, "DATA:REMOVE? %i, WAIT"%(read_every))
        readout_time=time.time()
        
        #remember number of readouts:
        total_readouts+=len(freq_buffer)
        if not total_readouts%n_measurements.get() and not total_readouts==0:
            counter_write(counter, "INIT:IMM")
            print "restart counting after reaching measurement count"
            restart_counter=0
        else:
            restart_counter=0

        # Write frequency to file
        buffer_length=len(freq_buffer)
        for i in range(len(freq_buffer)):
            if write_to_file and first_round and new_file:
                file_pointer.write("#gapless counter measurement ("+counter_mode+")\n")
                file_pointer.write("#Measurement started at: %s\n#With gate time: %f\n"%(start, loc_gate_time))
                file_pointer.write("#\n#measurement number (#)   Timestamp (Local time)   UTC time readout   frequency (Hz)   buffer size (#)\n")
                new_file=False
                filecounter=0
                first_round=False

            if freq_buffer[i] == "+9.91000000000000E+037":
                if restart_counter==False:
                    print "restarting measurement, probably timebase error..."
                restart_counter=True
            
            if write_to_file and file_pointer and not new_file:
                time_string=(datetime.datetime.utcfromtimestamp(readout_time)+datetime.timedelta(seconds=loc_gate_time*(i-buffer_length+1))).isoformat()+"Z"
                write_string=str(filecounter)+"   "+str(readout_time+i-buffer_length+1)+"   "+time_string+"   "+freq_buffer[i].lstrip("+")+"   "+str(buffer_length)+"\n"
                file_pointer.write(write_string)
                #print file output string
                if PRINT_FILE_OUTPUT:
                    print write_string.strip()
                if filecounter%(flush_every_n_counts)==0:
                    file_pointer.flush()
                filecounter+=1
                first_round=False
                new_file=False
            else:
                new_file=True
                filecounter=0
                first_round=True
        
        # notify of counter restart in file
        if not total_readouts%n_measurements.get() and not total_readouts==0:
            file_pointer.write("# restart counting after reaching measurement count\n")

        if loc_verbose and len(freq_buffer) > 0:
            frequency.set(freq_buffer[0])

        freq_buffer=[]
            
    #if measuring stopped, stop counter from measuring
    counter_write(counter, "ABORT")
    time.sleep(counter_gate_time.get()+0.1)

    return 0


app = App(root)
root.mainloop()
