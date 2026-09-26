# Movie

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelPreloadingMovie

```lua
CancelPreloadingMovie(movieId: number)
```

### GetMovieDownloadProgress

```lua
GetMovieDownloadProgress(movieId: number) -> inProgress: bool, downloaded: BigUInteger, total: BigUInteger
```

### IsMovieLocal

```lua
IsMovieLocal(movieId: number) -> isLocal: bool
```

### IsMoviePlayable

```lua
IsMoviePlayable(movieId: number) -> isPlayable: bool
```

### IsMovieReadable

```lua
IsMovieReadable(movieId: number) -> readable: bool
```

### PreloadMovie

```lua
PreloadMovie(movieId: number)
```
