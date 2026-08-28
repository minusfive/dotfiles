# Split autosize investigation (2026-08-28)

## Problem

Repeated splits in `Left` and `Up` caused pane overlap and odd sizing.  
After an initial fix, `Right` and `Down` still subdivided and did not equalize.

## Upstream behavior that matters

1. `pane:split{}` maps direction to `SplitRequest.target_is_second`.  
   `Left` and `Top` map to `false`. `Right` and `Bottom` map to `true`.  
   Source: `wezterm/wezterm` at `lua-api-crates/mux/src/pane.rs`.

2. `tab.adjust_pane_size(direction, amount)` applies to the nearest ancestor split on the same axis.  
   It does not rebalance a full row or full column by itself.  
   Source: `wezterm/wezterm` at `mux/src/tab.rs` (`adjust_pane_size` and `adjust_node_at_cursor`).

3. `AdjustPaneSize` works from active pane context in GUI actions.  
   Source: `wezterm/wezterm` at `wezterm-gui/src/termwindow/mod.rs`.

## Key finding

A single boundary pass strategy cannot solve both split insertion modes.

1. The `Left` and `Up` chain converges with an end-to-start pass that activates the trailing pane at each boundary.
2. The `Right` and `Down` chain converges with a start-to-end pass that activates the leading pane at each boundary.

This difference follows the split tree insertion side (`target_is_second`).

## Failure mode and detection

The first fix treated the visible row or column as flat geometry. That failed because split insertion order changed which pane became the source pane.

If repeated splits stay correct in one direction pair and drift in the opposite pair, inspect the pane bounds and the active band. That is the sign to reason from geometry, not from screen order alone.

## Session efficiency lessons

1. Validate action semantics early with small `wezterm cli` probes before algorithm rewrites.
2. Start from canonical docs and upstream source (`wezterm.org` and `wezterm/wezterm`) to avoid stale guidance.
3. Keep rebalance logic synchronous while debugging. Retry timers can hide root cause and destabilize the GUI process.
4. Keep a repeatable stress harness and one objective metric (`max_error`) so regressions are visible after each edit.

## Validation summary

`wezterm cli` stress runs tested eight repeated splits per direction with the direction-aware strategy.

1. `Left`: max error stayed `0` on every step.
2. `Right`: max error stayed `0` on every step.
3. `Up`: max error stayed `0` on every step.
4. `Down`: max error stayed `0` on every step.

Max error means the largest absolute difference from the equal target allocation for the active band.

## Final implementation notes

In `.config/wezterm/wezterm.lua`:

1. Rebalance runs after every split.
2. Rebalance scope is one orthogonal band, not the full tab.
3. `Left` and `Up` use the leading-edge boundary pass.
4. `Right` and `Down` use the trailing-edge boundary pass.
5. Directionless calls (close-pane rebalance) run both passes.
6. Active pane is restored after rebalance.

## Risk notes

1. The algorithm is local-band equalization by design.
2. Complex mixed grids can keep different bands at different target sizes.
3. This is expected behavior, not a calculation error.
