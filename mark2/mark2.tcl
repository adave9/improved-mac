#======================================================================
# Define options
set val(chan) Channel/WirelessChannel ;# channel type
set val(prop) Propagation/TwoRayGround ;# radio-propagation model
set val(netif) Phy/WirelessPhy ;# network interface type
set val(mac) Mac/802_11 ;# MAC type
set val(ifq) Queue/DropTail/PriQueue ;# interface queue type
set val(ll) LL ;# link layer type
set val(ant) Antenna/OmniAntenna ;# antenna model
set val(ifqlen) 50 ;# max packet in ifq
set val(nn) 43 ;# number of mobilenodes
set val(rp) DSDV ;# routing protocol
set val(x) 2500 ;# X dimension of topography
set val(y) 2500 ;# Y dimension of topography 
set val(stop) 900 ;# time of simulation end

# ================================= 
Antenna/OmniAntenna set X_ 0 
Antenna/OmniAntenna set Y_ 0 
Antenna/OmniAntenna set Z_ 1.5 

Antenna/OmniAntenna set Gt_ 1.0  
Antenna/OmniAntenna set Gr_ 1.0 
#======================


#======================================================================

set ns [new Simulator]
set tracefd [open mark2.tr w]
set windowVsTime2 [open win2.tr w]
set namtrace [open mark2.nam w] 

#Define different colors for data flows (for NAM)
#$ns color 1 Blue
#$ns color 2 Red

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo [new Topography]

$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

# configure the nodes
        $ns node-config -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -channelType $val(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace OFF \
                   -movementTrace ON
#=====================================================================
                   
for {set i 0} {$i < $val(nn) } { incr i } {
            set node_($i) [$ns node]     
      }

#===========Declare NODES===========================================================

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

$node_(16) set X_ 290.0
$node_(16) set Y_ 710.0
$node_(16) set Z_ 0.0

$node_(17) set X_ 500.0
$node_(17) set Y_ 920.0
$node_(17) set Z_ 0.0

$node_(18) set X_ 800.0
$node_(18) set Y_ 800.0
$node_(18) set Z_ 0.0

$node_(19) set X_ 925.0
$node_(19) set Y_ 500.0
$node_(19) set Z_ 0.0

$node_(20) set X_ 800.0
$node_(20) set Y_ 200.0
$node_(20) set Z_ 0.0

$node_(21) set X_ 500.0
$node_(21) set Y_ 75.0
$node_(21) set Z_ 0.0

$node_(22) set X_ 200.0
$node_(22) set Y_ 200.0
$node_(22) set Z_ 0.0

$node_(23) set X_ 75.0
$node_(23) set Y_ 500.0
$node_(23) set Z_ 0.0

$node_(24) set X_ 200.0
$node_(24) set Y_ 800.0
$node_(24) set Z_ 0.0

$node_(25) set X_ 500.0
$node_(25) set Y_ 710.0
$node_(25) set Z_ 0.0

$node_(26) set X_ 650.0
$node_(26) set Y_ 650.0
$node_(26) set Z_ 0.0

$node_(27) set X_ 710.0
$node_(27) set Y_ 500.0
$node_(27) set Z_ 0.0

$node_(28) set X_ 650.0
$node_(28) set Y_ 350.0
$node_(28) set Z_ 0.0

$node_(29) set X_ 500.0
$node_(29) set Y_ 290.0
$node_(29) set Z_ 0.0

$node_(30) set X_ 350.0
$node_(30) set Y_ 350.0
$node_(30) set Z_ 0.0

$node_(31) set X_ 290.0
$node_(31) set Y_ 500.0
$node_(31) set Z_ 0.0

$node_(32) set X_ 350.0
$node_(32) set Y_ 650.0
$node_(32) set Z_ 0.0

$node_(33) set X_ 900.0
$node_(33) set Y_ 900.0
$node_(33) set Z_ 0.0

$node_(34) set X_ 1350.0
$node_(34) set Y_ 500.0
$node_(34) set Z_ 0.0

$node_(35) set X_ 1350.0
$node_(35) set Y_ 650.0
$node_(35) set Z_ 0.0

$node_(36) set X_ 1455.0
$node_(36) set Y_ 605.0
$node_(36) set Z_ 0.0

$node_(37) set X_ 1500.0
$node_(37) set Y_ 500.0
$node_(37) set Z_ 0.0

$node_(38) set X_ 1455.0
$node_(38) set Y_ 395.0
$node_(38) set Z_ 0.0

$node_(39) set X_ 1350.0
$node_(39) set Y_ 350.0
$node_(39) set Z_ 0.0

$node_(40) set X_ 1245.0
$node_(40) set Y_ 395.0
$node_(40) set Z_ 0.0

$node_(41) set X_ 1200.0
$node_(41) set Y_ 500.0
$node_(41) set Z_ 0.0

$node_(42) set X_ 1245.0
$node_(42) set Y_ 605.0
$node_(42) set Z_ 0.0

##===============================motion=============================================

$ns at 150.0 "$node_(0) setdest 900.0 900.0 5.0"
$ns at 150.0 "$node_(33) setdest 500.0 500.0 5.0"

$ns at 350.0 "$node_(32) setdest 1250.0 1200.0 5.0"
$ns at 350.0 "$node_(31) setdest 1300.0 1200.0 5.0"
$ns at 350.0 "$node_(25) setdest 1350.0 1200.0 5.0"

#$ns at 350.0 "$node_(30) setdest 1350.0 1200.0 5.0"
#$ns at 350.0 "$node_(1) setdest 1400.0 1200.0 5.0"

#$ns at 350.0 "$node_(7) setdest 860.0 860.0 5.0"
#$ns at 350.0 "$node_(6) setdest 870.0 870.0 5.0"
#$ns at 350.0 "$node_(5) setdest 880.0 880.0 5.0"

#========================TCP or FTP or UDP===============================================

#Set a TCP connection between node_(0) and node_(17)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(17) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(18)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(18) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(19)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(19) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(20)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(20) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(21)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(21) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(22)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(22) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(23)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(23) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(0) and node_(24)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(24) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 10.0 "$ftp start"
$ns at 150.0 "$ftp stop"


#Setup a UDP connection
#set udp [new Agent/UDP]
#$ns attach-agent $node_(0) $udp
#set null [new Agent/Null]
#$ns attach-agent $node_(2) $null
#$ns connect $udp $null
#$udp set fid_ 2

#Setup a CBR over UDP connection
#set cbr [new Application/Traffic/CBR]
#$cbr attach-agent $udp
#$cbr set type_ CBR
#$cbr set packet_size_ 5000
#$cbr set rate_ 1mb
#$cbr set random_ false
#$ns at 0.1 "$cbr start"

#Set a TCP connection between node_(33) and node_(24)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(24) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(33) and node_(23)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(23) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(33) and node_(22)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(22) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(33) and node_(21)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(22) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(33) and node_(20)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(20) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(33) and node_(19)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(19) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#Set a TCP connection between node_(33) and node_(17)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(33) $tcp
$ns attach-agent $node_(17) $sink
$ns connect $tcp $sink

# Set a FTP over TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 250.0 "$ftp start"
#$ns at 150.0 "$ftp stop"

#===================NODE====colour=========================================

$node_(0) color green
$ns at 0.0 "$node_(0) color green"

$node_(33) color green
$ns at 250.0 "$node_(33) color green"

#$node_(17) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(18) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(19) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(20) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(21) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(22) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(23) color yellow
#$ns at 0.0 "$node_(0) color green"
#$node_(24) color yellow

#==================NODE======size==========================================

$ns initial_node_pos $node_(0) 60
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
$ns initial_node_pos $node_(16) 50
$ns initial_node_pos $node_(17) 50
$ns initial_node_pos $node_(18) 50
$ns initial_node_pos $node_(19) 50
$ns initial_node_pos $node_(20) 50
$ns initial_node_pos $node_(21) 50
$ns initial_node_pos $node_(22) 50
$ns initial_node_pos $node_(23) 50
$ns initial_node_pos $node_(24) 50
$ns initial_node_pos $node_(25) 50
$ns initial_node_pos $node_(26) 50
$ns initial_node_pos $node_(27) 50
$ns initial_node_pos $node_(28) 50
$ns initial_node_pos $node_(29) 50
$ns initial_node_pos $node_(30) 50
$ns initial_node_pos $node_(31) 50
$ns initial_node_pos $node_(32) 50
$ns initial_node_pos $node_(33) 60
$ns initial_node_pos $node_(34) 50
$ns initial_node_pos $node_(35) 50
$ns initial_node_pos $node_(36) 50
$ns initial_node_pos $node_(37) 50
$ns initial_node_pos $node_(38) 50
$ns initial_node_pos $node_(39) 50
$ns initial_node_pos $node_(40) 50
$ns initial_node_pos $node_(41) 50
$ns initial_node_pos $node_(42) 50

#====================================================
# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
}

#===============END and STOP=================================================

# ending nam and the simulation
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at 900.0 "puts \"end simulation\" ; $ns halt"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
exec nam mark2.nam &
exit 0
}
$ns run
