# Host shim for the off-target CMake build

These headers let ATN's C/C++ sources compile and run on a PC (for the CMake
unit tests in [`../`](..)) without an Automation Studio / Automation Runtime
install. They are **only** placed on the include path by the top-level
`CMakeLists.txt`; a real B&R target build never sees them.

| File             | Purpose |
|------------------|---------|
| `bur/plctypes.h` | Minimal stand-in for the AR `<bur/plctypes.h>`: IEC/B&R base types (`plcbit`, `plcstring`, `UDINT`, `STRING`, …) and linkage macros (`_BUR_PUBLIC`, `_GLOBAL_CONST`, …). |
| `atn.h`          | Copy of the AS-generated `ATN.h` (the C interface for `atn.fun`/`atn.typ`/`atn.var`). The sources `#include "atn.h"`, which AS normally generates into the gitignored `Temp/Includes/`, so a checked-in copy is needed off-target. |
| `stringext.h`    | Empty stub — ATN lists StringExt as a dependency but calls none of its functions. |
| `vartools.h`     | Empty stub — ATN lists VarTools as a dependency but calls none of its functions. |
| `LogThat.h`      | Capture stub for the LogThat dependency: declares `logInfo`/`logWarning`/`logError`/`logSuccess` with the real signatures, plus test instrumentation (`logThatShimCalls`, `logThatShimCount`, `logThatShimReturn`, `logThatShimReset()`) so tests can assert on what ATN logged. |
| `logthat_stub.cpp` | Implementation of the capture stub; compiled into the `atn` static library by the top-level `CMakeLists.txt`. |

## Refreshing `atn.h`

`atn.h` mirrors the generated header and can drift if `atn.fun`/`atn.typ`/
`atn.var` change. To refresh it, build the example project in Automation Studio
and copy the regenerated header over this one:

```sh
cp example/AsProject/Temp/Includes/ATN.h test/host-shim/atn.h
```

The host build is configured 32-bit (Win32) so `unsigned long` is 4 bytes,
matching the SG4 data model that several ATN structs rely on (they store
pointers in `unsigned long` fields).
