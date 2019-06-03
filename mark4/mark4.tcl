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
set val(nn) 19 ;# number of mobilenodes
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
#==================================


#======================================================================

set ns [new Simulator]
set tracefd [open mark4.tr w]
set windowVsTime2 [open win4.tr w]
set namtrace [open mark4.nam w] 

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

#=====================================================================
                   
for {set i 0} {$i < $val(nn) } { incr i } {
            set node_($i) [$ns node]     
      }

#===========DeclareNODES===========================================================

$node_(0) set X_ 500.0
$node_(0) set Y_ 500.0
$node_(0) set Z_ 0.0

$node_(1) set X_ 300.0
$node_(1) set Y_ 375.0
$node_(1) set Z_ 0.0

$node_(2) set X_ 500.0
$node_(2) set Y_ 375.0
$node_(2) set Z_ 0.0

$node_(3) set X_ 700.0
$node_(3) set Y_ 350.0
$node_(3) set Z_ 0.0

$node_(4) set X_ 300.0
$node_(4) set Y_ 275.0
$node_(4) set Z_ 0.0

$node_(5) set X_ 500.0
$node_(5) set Y_ 250.0
$node_(5) set Z_ 0.0

$node_(6) set X_ 800.0
$node_(6) set Y_ 250.0
$node_(6) set Z_ 0.0

$node_(7) set X_ 1100.0
$node_(7) set Y_ 350.0
$node_(7) set Z_ 0.0

$node_(8) set X_ 1150.0
$node_(8) set Y_ 350.0
$node_(8) set Z_ 0.0

$node_(9) set X_ 800.0
$node_(9) set Y_ 50.0
$node_(9) set Z_ 0.0

$node_(10) set X_ 800.0
$node_(10) set Y_ 0.0
$node_(10) set Z_ 0.0

$node_(11) set X_ 700.0
$node_(11) set Y_ 600.0
$node_(11) set Z_ 0.0

$node_(12) set X_ 950.0
$node_(12) set Y_ 600.0
$node_(12) set Z_ 0.0

$node_(13) set X_ 500.0
$node_(13) set Y_ 625.0
$node_(13) set Z_ 0.0

$node_(14) set X_ 250.0
$node_(14) set Y_ 625.0
$node_(14) set Z_ 0.0

$node_(15) set X_ 300.0
$node_(15) set Y_ 625.0
$node_(15) set Z_ 0.0

$node_(16) set X_ 500.0
$node_(16) set Y_ 725.0
$node_(16) set Z_ 0.0

$node_(17) set X_ 800.0
$node_(17) set Y_ 700.0
$node_(17) set Z_ 0.0

$node_(18) set X_ 950.0
$node_(18) set Y_ 700.0
$node_(18) set Z_ 0.0
##===============================motion=============================================

$ns at 150.0 "$node_(9) setdest 1000.0 25.0 5.0"
$ns at 150.0 "$node_(10) setdest 1000.0 25.0 5.0"
$ns at 150.0 "$node_(6) setdest 900.0 250.0 5.0"
$ns at 300.0 "$node_(3) setdest 700.0 250.0 5.0"
#========================CBR over UDP===============================================



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
#$ns at 150.0 "$ftp stop"

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
#$ns at 150.0 "$ftp stop"
#----------------------------------------------------------


#===================NODE====colour=========================================

$node_(0) color green
$ns at 0.0 "$node_(0) color green"


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
exec nam mark4.nam &
exit 0
}
$ns run

