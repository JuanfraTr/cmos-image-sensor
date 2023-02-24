* 
V1 Vdd 0 5
V2 Vreset 0 PULSE(0 5 0 1p 1p 'treset1' 'tperiodo' 4)
V3 Vtransfer 0 PULSE(0 5 0 1p 1p 'ttransfer1' 'tperiodo' 4)
M1 FD Vtransfer2 Vdiodo 0 CMOSN l='Lmin' w='W' ad='W*Ld' as='W*Ld' pd='2*W+2*Ld' ps='2*W+2*Ld' m=1
D1 0 Vdiodo D
C1 Vdiodo 0 160f
V4 Vrowselect 0 PULSE(0 5 'rowselect1' 1p 1p 0.5m 'tperiodo' 4)
M2 Vdd Vreset2 FD 0 CMOSN l='Lmin' w='W' ad='W*Ld' as='W*Ld' pd='2*W+2*Ld' ps='2*W+2*Ld' m=1
M3 Vdd FD N004 0 CMOSN l='Lmin' w='W' ad='W*Ld' as='W*Ld' pd='2*W+2*Ld' ps='2*W+2*Ld' m=7
M4 N002 Vrowselect2 N004 0 CMOSN l='Lmin' w='W' ad='W*Ld' as='W*Ld' pd='2*W+2*Ld' ps='2*W+2*Ld' m=1
I2 N002 0 1n
V5 Vreset2 Vreset PULSE(0 5 'treset2' 1p 1p 0.25m 'tperiodo' 4)
V6 Vtransfer2 Vtransfer PULSE(0 5 'ttransfer2' 1p 1p 0.5m 'tperiodo' 4)
G1 Vdiodo 0 Vsweep 0 1
V7 Vswcurrent1 0 PULSE(0 'current1' 0 1p 1p 'tswcurrent' 'tperiodo' 1)
V8 Vswcurrent2 Vswcurrent1 PULSE(0 'current2' 5m 1p 1p 'tswcurrent' 'tperiodo' 1)
V9 Vswcurrent3 Vswcurrent2 PULSE(0 'current3' 10m 1p 1p 'tswcurrent' 'tperiodo' 1)
V10 Vswcurrent4 Vswcurrent3 PULSE(0 'current4' 15m 1p 1p 'tswcurrent' 'tperiodo' 1)
V11 Vsweep 0 PULSE(0 'currentsweep' 0 1p 1p 'tswcurrent' 'tperiodo' 1)
M6 N003 Vsamplesignal N002 0 CMOSN l='Lmin' w='W' ad='W*Ld' as='W*Ld' pd='2*W+2*Ld' ps='2*W+2*Ld' m=1
V12 Vsamplereset 0 PULSE(0 5 'trsampleo' 1p 1p 'tonreset' 5m 4)
V13 Vsamplesignal 0 PULSE(0 5 'tssampleo' 1p 1p 'tonsignal' 5ms 4)
V14 Vrowselect2 Vrowselect PULSE(0 5 'rowselect2' 1p 1p 0.5m 'tperiodo' 4)
Creset N006 0 1.6p
Csignal N003 0 1.6p
M8 0 N003 N001 N001 CMOSP l='Lmin' w='Wp1' ad='Wp1*Ld' as='Wp1*Ld' pd='2*Wp1+2*Ld' ps='2*Wp1+2*Ld' m=1
M7 0 N006 N005 N005 CMOSP l='Lmin' w='Wp1' ad='Wp1*Ld' as='Wp1*Ld' pd='2*Wp1+2*Ld' ps='2*Wp1+2*Ld' m=1
M9 N005 Vlectura Vr Vr CMOSP l='Lmin' w='Wp1' ad='Wp1*Ld' as='Wp1*Ld' pd='2*Wp1+2*Ld' ps='2*Wp1+2*Ld' m=1
M10 N001 Vlectura Vs Vs CMOSP l='Lmin' w='Wp1' ad='Wp1*Ld' as='Wp1*Ld' pd='2*Wp1+2*Ld' ps='2*Wp1+2*Ld' m=1
M11 Vr Vpol Vdd Vdd CMOSP l='Lmin' w='Wp2' ad='Wp2*Ld' as='Wp2*Ld' pd='2*Wp2+2*Ld' ps='2*Wp2+2*Ld' m=1
V15 Vpol 0 4
M12 Vs Vpol Vdd Vdd CMOSP l='Lmin' w='Wp2' ad='Wp2*Ld' as='Wp2*Ld' pd='2*Wp2+2*Ld' ps='2*Wp2+2*Ld' m=1
V16 Vlectura 0 PULSE(0 5 'tlectura' 1p 1p 0.2m 5ms 4)
M5 N006 Vsamplereset N002 0 CMOSN l='Lmin' w='W' ad='W*Ld' as='W*Ld' pd='2*W+2*Ld' ps='2*W+2*Ld' m=1
E1 out 0 Vr Vs 1
.model D D
* .tran 5m *Solo un ciclo
.param tperiodo = 5m
.param treset1 = 0.25m
.param ttransfer1 = 0.20m
.include IEE3433Lib_TT.sp
.param rowselect2 = 4m
.param Lmin = 0.6u, W = 3u, Ld=1.2u
.param treset2 = 2.5m
.param ttransfer2 = 3m
.param tswcurrent = 3m
.param current1 = 100p, current2= 50p, current3=10p, current4=0p
.MEAS TRAN vout1 FIND V(out) AT 4.95m
.MEAS TRAN vout2 FIND V(out) AT 9.25m
.MEAS TRAN vout3 FIND V(out) AT 14.25m
.MEAS TRAN vout4 FIND V(out) AT 19.25m
.param currentsweep=5e-10
.tran 20m * Cuatro ciclos
* Photocorrientes
.param tssampleo = 4.1m
.param tonsignal = 0.4m
.param trsampleo = 2.8m
.param tonreset = 0.1m
.param rowselect1 = 2.5m
.param Wp1 = 60u, Wp2 = 10u
.param tlectura = 4.7m
.backanno
.end
