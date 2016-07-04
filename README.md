# Conway's Game of Life with Godot Engine

Each cell has a vitality score from 0 to 6.

A cell lives, dies, remain the same or increase it's vitality depending on the sum of the 8-neighbors vitality.

Current constants:

```es6
const MAX_VITALITY = 6

const OVERPOPULATION = 7 * MAX_VITALITY
const UNDERPOPULATION = 2 * MAX_VITALITY
const GROW_THRESHOLD = 0.48
```
