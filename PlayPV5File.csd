<CsoundSynthesizer>
<CsOptions>
-odac -+rtaudio=CoreAudio
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 256
nchnls = 2
0dbfs = 1


opcode PV5Read, a, iik[]k[]

    ihopsize, iframesize, kmagnitudes[], kfrequencies[] xin

    k1 init 0
    setksmps ihopsize

    krowCount lenarray kmagnitudes, 1

    kmagsrow[] getrow kmagnitudes, k1
    kfreqsrow[] getrow kfrequencies, k1
    fsig1 tab2pvs kmagsrow, kfreqsrow
    aOut pvsynth fsig1
    k1 += 1

    if k1 > krowCount - 1 then
        event "e", 0, p3
    endif

    xout aOut

endop

instr 1

ihopsize, iframesize, kmagnitudes[], kfrequencies[] hdf5read "$FILE_PATH", "ihopsize", "ifftsize", "kmagnitudes*", "kfrequencies*"
aOut PV5Read ihopsize, iframesize, kmagnitudes, kfrequencies

out aOut

endin

schedule(1, 0, -1)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>
