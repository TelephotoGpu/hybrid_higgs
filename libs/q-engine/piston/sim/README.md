# Piston memory simulations

Run the XPM true-dual-port RAM differential fuzz test with XSim:

```sh
./run_xsim_dpram_fuzz.sh
```

The test initializes all 4,096 words, then executes 20,000 randomized
non-colliding dual-port transactions. It compares the Xilinx
`xpm_memory_tdpram` implementation against the original behavioral RAM
semantics.
