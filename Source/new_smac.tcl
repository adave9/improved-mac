# ======================================================================
# Define options
# ======================================================================

set opt(chan)	Channel/WirelessChannel
set opt(prop)	Propagation/TwoRayGround
set opt(netif)	Phy/WirelessPhy
set opt(mac)	Mac/SMAC
set opt(ifq)	Queue/DropTail/PriQueue
set opt(ll)		LL
set opt(ant)        Antenna/OmniAntenna
set opt(x)		2500   ;# X dimension of the topography
set opt(y)		2500   ;# Y dimension of the topography
set opt(ifqlen)	50	      ;# max packet in ifq
set opt(seed)	0.0
set opt(tr)		new_smac.tr    ;# trace file
set opt(nam)            new_smac.nam   ;# nam trace file
set opt(adhocRouting)   DSDV
set opt(nn)             16             ;# how many nodes are simulated
set opt(stop)		900.0		;# simulation time

# =====================================================================
# Other default settings

LL set mindelay_		50us
LL set delay_			25us
LL set bandwidth_		0	;# not used

Agent/Null set sport_		0
Agent/Null set dport_		0

Agent/CBR set sport_		0
Agent/CBR set dport_		0

Agent/TCPSink set sport_	0
Agent/TCPSink set dport_	0

Agent/TCP set sport_		0
Agent/TCP set dport_		0
Agent/TCP set packetSize_	1460

Queue/DropTail/PriQueue set Prefer_Routing_Protocols    1

Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1.0
Antenna/OmniAntenna set Gr_ 1.0

Phy/WirelessPhy set CPThresh_ 10.0
Phy/WirelessPhy set CSThresh_ 1.559e-11
Phy/WirelessPhy set RXThresh_ 3.652e-10
Phy/WirelessPhy set Rb_ 2*1e6
Phy/WirelessPhy set Pt_ 0.2818
Phy/WirelessPhy set freq_ 914e+6 
Phy/WirelessPhy set L_ 1.0


# ======================================================================
# Main Program
# ======================================================================
set ns		[new Simulator]
set wtopo	[new Topography]
set tracefd	[open $opt(tr) w]
set namtrace    [open $opt(nam) w]
$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace 2500 2500
$wtopo load_flatgrid $opt(x) $opt(y)


set god_ [create-god $opt(nn)]

$ns node-config -adhocRouting $opt(adhocRouting) \
		 -llType $opt(ll) \
		 -macType $opt(mac) \
		 -ifqType $opt(ifq) \
		 -ifqLen $opt(ifqlen) \
		 -antType $opt(ant) \
		 -propType $opt(prop) \
		 -phyType $opt(netif) \
		 -channelType $opt(chan) \
    -topoInstance $wtopo \
    -agentTrace ON \
    -routerTrace OFF \
    -macTrace ON 

for {set i 0} {$i < $opt(nn) } {incr i} {
	set node_($i) [$ns node]	
	$node_($i) random-motion 0		;# disable random 
}
$ns color 0 green

$node_(0) color cyan
$ns at 0.0 "$node_(0) color blue"

$node_(0) set X_ 500.0
$node_(0) set Y_ 500.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 500.0
$node_(1) set Y_ 650.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 605.0
$node_(2) set Y_ 605.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 650.0
$node_(3) set Y_ 500.0
$node_(3) set Z_ 0.0

$node_(4) set X_ 605.0
$node_(4) set Y_ 395.0
$node_(4) set Z_ 0.0

$node_(5) set X_ 500.0
$node_(5) set Y_ 350.0
$node_(5) set Z_ 0.0

$node_(5) set X_ 500.0
$node_(5) set Y_ 350.0
$node_(5) set Z_ 0.0

$node_(6) set X_ 395.0
$node_(6) set Y_ 395.0
$node_(6) set Z_ 0.0

$node_(7) set X_ 350.0
$node_(7) set Y_ 500.0
$node_(7) set Z_ 0.0

$node_(8) set X_ 395.0
$node_(8) set Y_ 605.0
$node_(8) set Z_ 0.0

$node_(9) set X_ 500.0
$node_(9) set Y_ 800.0
$node_(9) set Z_ 0.0

$node_(10) set X_ 710.0
$node_(10) set Y_ 710.0
$node_(10) set Z_ 0.0

$node_(11) set X_ 800.0
$node_(11) set Y_ 500.0
$node_(11) set Z_ 0.0

$node_(12) set X_ 710.0
$node_(12) set Y_ 290.0
$node_(12) set Z_ 0.0

$node_(13) set X_ 500.0
$node_(13) set Y_ 200.0
$node_(13) set Z_ 0.0

$node_(14) set X_ 290.0
$node_(14) set Y_ 290.0
$node_(14) set Z_ 0.0

$node_(15) set X_ 200.0
$node_(15) set Y_ 500.0
$node_(15) set Z_ 0.0

$node_(2) color cyan
$ns at 200.0 "$node_(2) color green"
$node_(4) color cyan
$ns at 200.0 "$node_(4) color green"
$node_(5) color cyan
$ns at 200.0 "$node_(5) color green"
$node_(6) color cyan
$ns at 200.0 "$node_(6) color green"
$node_(6) color cyan
$ns at 500.0 "$node_(6) color magenta"

$ns at 200.0 "$node_(2) setdest 1000.0 1000.0 5.0"
$ns at 200.0 "$node_(4) setdest 1000.0 1100.0 5.0"
$ns at 200.0 "$node_(5) setdest 1000.0 1200.0 5.0"
$ns at 200.0 "$node_(6) setdest 1000.0 1300.0 5.0"
$ns at 500.0 "$node_(6) setdest 395.0 395.0 5.0"
##===============================motion=============================================

#$ns at 150.0 "$node_(0) setdest 900.0 900.0 5.0"


#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(1)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(1) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(1) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(1) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(2)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(2) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(2) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(2) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(3)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(3) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(3) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(3) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(4)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(4) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(4) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(4) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(5)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(5) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(5) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(5) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(6)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(6) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(6) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(6) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(7)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(7) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(7) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(7) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(8)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(8) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(8) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(5) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(9)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(9) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(9) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(9) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(10)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(10) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(10) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(10) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(11)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(11) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(11) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(11) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(12)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(12) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(12) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(12) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(13)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(13) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(13) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(13) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(14)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(14) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(14) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(14) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
#Set a TCP connection between node_(0) and node_(15)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(15) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(15) and node_(0)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(15) $tcp
$ns attach-agent $node_(0) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"
#---------------------------------------------------------
#---------------------------------------------------------
$ns initial_node_pos $node_(0) 80
$ns initial_node_pos $node_(1) 50
$ns initial_node_pos $node_(2) 50
$ns initial_node_pos $node_(3) 50
$ns initial_node_pos $node_(4) 50
$ns initial_node_pos $node_(5) 50
$ns initial_node_pos $node_(6) 50
$ns initial_node_pos $node_(7) 50
$ns initial_node_pos $node_(8) 50
$ns initial_node_pos $node_(9) 50
$ns initial_node_pos $node_(10) 50
$ns initial_node_pos $node_(11) 50
$ns initial_node_pos $node_(12) 50
$ns initial_node_pos $node_(13) 50
$ns initial_node_pos $node_(14) 50
$ns initial_node_pos $node_(15) 50

#----------------------------------------------------------


for {set i 0} {$i < $opt(nn) } { incr i } {
    $ns at $opt(stop) "$node_($i) reset";
}

$ns at $opt(stop) "$ns nam-end-wireless $opt(stop)"
$ns at $opt(stop) "stop"
$ns at 900.0 "puts \"end simulation\" ; $ns halt"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
exec nam new_smac.nam &
exit 0
}

puts "Starting Simulation..."
$ns run





