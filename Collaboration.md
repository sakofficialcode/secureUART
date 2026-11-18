# Secure UART: Layout Collaboration

The RTL is synthesized, scan-inserted, verified at gate level, and imported into
Virtuoso as schematics. This document covers what you need to start layout on
your block.

**Start from tag `layout-v1`.** Do not re-run synthesis or the Verilog import.
Both would overwrite the shared schematics and any fixes made in them.

---

## 1. What's in the repo

| Path | What it is |
|---|---|
| `cds/suart_sch/` | **Shared schematic library.** One cell per netlist module. You do LVS against these. |
| `syn/out/top_scan_pg.v` | Netlist the schematics were imported from (logic plus VDD/VSS wiring) |
| `syn/out/top_scan.v` | Logic-only netlist, used for simulation (tag `netlist-v1`) |
| `syn/reports/` | Area, cell, timing, and scan-chain reports |
| `syn/dc_top.tcl`, `syn/add_pg.py`, `syn/run_gls.sh` | Scripts that produced the above (for reference only) |
| `rtl/`, `tb/` | RTL and testbench |

Design summary:

| Item | Value |
|---|---|
| Cells | 532 ARM sc12 standard cells (`tsmcN65arm`) |
| Flip-flops | 132 total: 61 in the scan chain; 71 not scanned (2 ciphers + scan lock) |
| Clock | 1.8432 MHz (543 ns). Setup slack is 492 ns; hold is met with a 0.1 ns margin. |
| Supplies | `VDD!` and `VSS!` (global nets). Every cell's VNW is tied to VDD and VPW to VSS. |

---

## 2. Block split

Instance paths are given from `top`. Ownership is to be filled in by the team.

| Block group | Instances (module) | Cells | Flops | Owner |
|---|---|---|---|---|
| **UART datapath** | `baud` (`baud_gen_test_1`) 14, `tx` (`uart_tx_test_1`) 67, `sync` (`sync_2ff_test_1`) 4, `rx` (`uart_rx_test_1`) 77 | 162 | 37 | |
| **Ciphers** | `tx_cipher` (`sg_cipher_1` + `lfsr_17_12000_1c94b_1` + `lfsr_15_6000_70ae_1`) 104, `rx_cipher` (`sg_cipher_0` + `lfsr_17_12000_1c94b_0` + `lfsr_15_6000_70ae_0`) 103 | 207 | 70 | |
| **BIST + security** | `bist` (`bist_ctrl_51_51_test_1` + `lfsr_8_b8_a3_test_1` as `p_gen`) 140, `sec` (`sec_ctrl`) 6 | 146 | 25 | |
| **Top / integration** | 17 glue cells in `top` (BIST muxes, output gating, scan-out buffer) + placing and wiring all blocks | 17 | 0 | |

**Cipher owner, note:** the two cipher copies are *not* identical. DC sized a
few gates differently:

| Module | Copy 0 (`rx_cipher`) | Copy 1 (`tx_cipher`) |
|---|---|---|
| `sg_cipher` | `NOR2_X1M_A12TR` | `NOR2_X0P7M_A12TR` |
| `lfsr_17_…` | `NOR3_X3M_A12TR` | `NOR3_X0P5A_A12TR` + one extra `BUF_X0P8B_A12TR` |
| `lfsr_15_…` | identical | identical |

You can lay out one copy, duplicate it, and swap those cells in the other copy.
Run LVS on each copy separately.

---

## 3. One-time setup (your own account)

All commands are for **tcsh** on `vlsi-cmp-00`.

```
git clone git@github.com:sakofficialcode/secureUART.git ~/secureUART
cd ~/secureUART && git checkout layout-v1
```

Create your Virtuoso work folder. Run the course setup scripts once here; they
create `cds.lib`:

```
mkdir ~/suart_cds
cd ~/suart_cds
source /opt/scripts/setup_all_csh.sh
source /opt/scripts/setup_TSMC65.sh
```

Add the shared schematic library to `cds.lib`:

```
echo "DEFINE suart_sch $HOME/secureUART/cds/suart_sch" >> cds.lib
grep -E "suart_sch|tsmcN65arm" cds.lib
```

The `grep` must show both lines. `tsmcN65arm` is added by the course setup.

Work around a missing library that crashes some Cadence tools (one time):

```
mkdir -p ~/lib_compat
ln -sf /usr/lib64/libsasl2.so.3 ~/lib_compat/libsasl2.so.2
```

---

## 4. Launching Virtuoso (every session)

Virtuoso reads `cds.lib` from the folder you launch it in. **Always launch from
`~/suart_cds`, never from the repo.** From the repo you'll only see the
default Cadence libraries.

```
tcsh
cd ~/suart_cds
cp cds.lib cds.lib.bak
source /opt/scripts/setup_all_csh.sh
source /opt/scripts/setup_TSMC65.sh
cp cds.lib.bak cds.lib
setenv LD_LIBRARY_PATH ~/lib_compat
virtuoso &
```

The `cp` lines are needed because `setup_TSMC65.sh` rewrites `cds.lib` and
would drop your `suart_sch` line.

---

## 5. First task: fix your block's import shorts

The Verilog importer drew some VSS wires straight across neighbouring signal
wires. Three cell types (`OA21`, `OAI21`, `OAI2XB1`) have a VSS pin it can't
route away from. The overlap reads as a short in the schematic. **The netlist
itself is correct**; only the drawing is wrong. LVS uses the schematic, so these
must be fixed by hand:

| Schematic | Shorts |
|---|---|
| `uart_tx_test_1` | `n1`, `n29`, `n35` ↔ `VSS!` |
| `uart_rx_test_1` | `VSS!`, `n23`, `n25`, `n8` ↔ `bit_cnt_q<0>` (probably one bad wire) |
| `sg_cipher_1` | `n1` ↔ `VSS!` |
| `sg_cipher_0` | `n14` ↔ `VSS!` |
| `bist_ctrl_51_51_test_1` | `n9`, `step` ↔ `VSS!` |

To fix them:
1. Open the schematic in edit mode and run **Check → Current Cellview**. Each short gets a marker.
2. Move the overlapping wire off the VSS wire, or delete and redraw that segment.
3. Run **Check and Save** until it reports **0 errors**.

Expected warnings you can ignore:
- "Solder dot on cross over": cosmetic.
- `VDD!`/`VSS!` "signal type mismatch": harmless.
- Floating `keyed`/`ks_ready` on the ciphers: unused by design.

Commit only your own block's cells (see §8).

---

## 6. Layout

- **Create your own layout library**, e.g. `suart_lay_<yourname>`, so no two people ever edit the same files.
  - **Before creating it**, confirm which technology library to attach. It must match the ARM cell layouts: in the Library Manager, right-click `tsmcN65arm` → **Properties** and read the attached technology. It will be either `tsmcN65` or `techLib_cln65gplus_9M6X2Z`; use that one.
  - The shared `suart_sch` is attached to `tsmcN65`. That only matters for schematics.
- Cell layouts come from `tsmcN65arm`. Place instances to match your schematic, with the same instance names where you can.
- **Label power pins `VDD!` and `VSS!`**, exactly as the schematics name them, or LVS will report the supplies as mismatched.
- Before anyone draws, agree as a team on:
  - each block's outline size, and where each pin sits (edge and metal layer)
  - power rail width and layer, so abutted blocks line up
  - which metal layers stay inside blocks and which are kept for top-level routing
- Run **DRC and LVS on your block** (layout against `suart_sch/<module>/schematic`) before handing it to the integrator. LVS needs the ARM cell SPICE netlists, which are in `/opt/PDK/TSMC65/ARM/cln65gplus/sc12_base_rvt/r3p0-00eac0/cdl/`.

---

## 7. Integrator notes

- **Top-level pins:** `clk`, `rst_n`, `tx_valid`, `tx_data[7:0]`, `tx_ready`, `uart_txd`, `uart_rxd`, `rx_data[7:0]`, `rx_valid`, `rx_err`, `key_in`, `key_load`, `key_sel`, `scan_en`, `scan_in`, `scan_out`, `bist_start`, `bist_done`, `bist_pass`, `VDD!`, `VSS!`.
- **Scan chain:** it runs through every block except the ciphers, in the order DFT chose. `scan_out` is a buffered copy of `rx_data[7]`. With no clock tree, a long wire between two neighbouring scan flops can fail hold. After extraction, re-check hold on the chain hops that cross between blocks.
- **Clock:** `clk` goes to all 132 flops and is hand-routed. Keep it short and balanced; the hold margin is only 0.1 ns.

---

## 8. Git rules

- Pull before you start (`git pull`) and before you push.
- **Commit only your own block's cells or your own layout library.** OA files are binary, so git cannot merge two people's edits to the same cell.
- **Never commit lock files.** `.gitignore` already excludes `*.cdslck*`, `CDS.log*`, `.cadence/`, `panic*` and `libManager.log`. Check with `git status` before committing.
- Don't change `syn/out/`, `rtl/`, or the scripts without telling the team. A netlist change means a new tag, and everyone re-syncs.
