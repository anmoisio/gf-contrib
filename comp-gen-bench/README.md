# Compositional Generalisation Benchmarks

Implementations of Compositional Generalisation Benchmarks:
- SCAN: https://github.com/brendenlake/SCAN
- COGS/SLOG: https://github.com/najoungkim/COGS and https://github.com/bingzhilee/slog
    - the most important file is [cogs-rgl/Semantics.gf](cogs-rgl/Semantics.gf) that implements a neo-Davidsonian semantics for a part of the gf-rgl abstract syntax
        - Requires replacing `fun`s with `data`s as in https://github.com/anmoisio/gf-rgl
