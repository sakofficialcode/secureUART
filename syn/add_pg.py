"""Make a power-aware copy of the netlist for Virtuoso import.

DC's netlist has no power pins, but every ARM cell symbol has VDD, VSS, VNW
(n-well) and VPW (p-well). Imported as-is they all float, and LVS fails. This
script:
  * adds VDD/VSS ports to every module and passes them down the hierarchy,
  * connects each cell's supply pins: VDD->VDD, VNW->VDD, VSS->VSS, VPW->VSS
    (wells tied to the rails: no body bias),
  * only connects supply pins the cell actually has, read from the ARM CDL.

Output: syn/out/top_scan_pg.v  (import this; keep top_scan.v for simulation)

Usage (on the server, from the repo root):  python3 syn/add_pg.py
"""
import glob
import re
import sys
from pathlib import Path

HERE = Path(__file__).parent
SRC = HERE / "out" / "top_scan.v"
DST = HERE / "out" / "top_scan_pg.v"
CDL_GLOB = "/opt/PDK/TSMC65/ARM/cln65gplus/sc12_base_rvt/r3p0-00eac0/cdl/*"
SUPPLY = {"VDD": "VDD", "VNW": "VDD", "VSS": "VSS", "VPW": "VSS"}


def read_cdl_supplies(paths):
    """cell name -> supply pins it has, from .SUBCKT lines (+ continuations)."""
    cells, cur = {}, None
    for path in paths:
        for line in Path(path).read_text(errors="replace").splitlines():
            tok = line.split()
            if tok and tok[0].upper() == ".SUBCKT":
                cur = tok[1]
                cells[cur] = {t for t in tok[2:] if t in SUPPLY}
            elif tok and tok[0] == "+" and cur:
                cells[cur] |= {t for t in tok[1:] if t in SUPPLY}
            else:
                cur = None
    return cells


cdl_files = [p for p in glob.glob(sys.argv[1] if len(sys.argv) > 1 else CDL_GLOB)
             if Path(p).is_file()]
cdl = read_cdl_supplies(cdl_files)
if not cdl:
    sys.exit(f"no .SUBCKT found in {CDL_GLOB}")

text = SRC.read_text()
modules = set(re.findall(r"^module (\w+)", text, re.M))
inst_re = re.compile(r"^(\s+)(\w+)(\s+)(\\\S+\s|\w+)(\s*)\(", re.M)
used, n_cells, n_subs, missing = set(), 0, 0, set()


def connect(m):
    global n_cells, n_subs
    indent, ref, sp, inst, sp2 = m.groups()
    if ref in modules:
        n_subs += 1
        conns = ".VDD(VDD), .VSS(VSS), "
    elif ref.endswith("_A12TR"):
        if ref not in cdl:
            missing.add(ref)
            return m.group(0)
        n_cells += 1
        used.add(ref)
        conns = "".join(f".{p}({SUPPLY[p]}), " for p in ("VDD", "VSS", "VNW", "VPW") if p in cdl[ref])
    else:
        return m.group(0)  # not an instance (e.g. a declaration)
    return f"{indent}{ref}{sp}{inst}{sp2}( {conns}"


out = inst_re.sub(connect, text)
if missing:
    sys.exit(f"cells not found in CDL: {sorted(missing)}")

# VDD/VSS ports on every module
out, n_mod = re.subn(r"^(module \w+ \()", r"\1 VDD, VSS,", out, flags=re.M)
out = re.sub(r"^(module \w+ \(.*?\);\n)", r"\1  inout VDD, VSS;\n", out, flags=re.M | re.S)

no_pg = sorted(c for c in used if not cdl[c])
DST.write_text(out)
print(f"read {len(cdl)} cells from {len(cdl_files)} CDL file(s)")
print(f"modules: {n_mod}   submodule instances: {n_subs}   cell instances: {n_cells}")
print("supply pins per used cell type:",
      sorted({tuple(sorted(cdl[c])) for c in used}))
if no_pg:
    print("WARNING: cells with no supply pins in CDL:", no_pg)
print(f"wrote {DST}")
