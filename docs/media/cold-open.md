# Cold Open — finding and cutting the tape

## Recording timeline

```
V1   2026-09-20_19-07-38.mkv    starts 19:07:38   02:03:23   ends 21:11:01
                                          (63-second gap — recording split)
V2   2026-09-20_21-12-04.mkv    starts 21:12:04   02:53:31   ends 00:05:35 (09-21)

V3   2026-09-21_00-44-14.mkv    CORRUPT — ffprobe cannot read it. Delete.
```

Total usable content: **4h 56m 54s**, effectively continuous.

## Anchors derived from saved data

These are not guesses. Each is a timestamp the addon itself wrote to
SavedVariables, converted to an offset from the recording start.

| Wall clock | Source | Offset |
| --- | --- | --- |
| `19:32:52` | Tier B probe `risky.at` | **V1 00:25:14** |
| `21:03` | portrait plate `updated` | **V1 01:55:22** |
| `21:53` | card `updated` | **V2 00:40:56** |

Verify one against the VOD before trusting the rest — they all assume the
recording started when the session did.

## Candidate moments, best first

### A. `Menu.ModifyMenu` exists — **recommended**

The strongest cold open. A claim recorded in the project's own notes as
established fact, disproven by a three-line check. It is also the episode's
thesis in miniature.

**Search window: V1 `00:28:00` – `00:45:00`.**

Reasoning: the probe's Tier B step ran at V1 `00:25:14`. The results only reach
disk on `/reload`, so reading them began a few minutes later. The
`Menu.ModifyMenu` finding came several steps into reading the `unitPopup`
section.

Listen for the pivot from reading probe output to reacting to the menu result.

### B. The ASCII 31 catch

Funnier, and self-contained — the textbook-correct answer is the one that
fails. Weaker as an opener because it needs setup about the messaging library.

**Search window: V2 `02:00:00` – `02:45:00`.**

Reasoning: the v0.3 Chomp work was the last major block before the recording
stopped at `00:05:35`. The separator bug surfaced while reading Chomp's
`StringManip.lua`, late in that block.

### C. The auctioneer result

Good energy — a ten-second test unblocking a parked project. Off-thesis for
this episode, but excellent for a *different* episode about the gold project.

**Search window: V2 `00:05:00` – `00:40:00`.**

Reasoning: the auction house detour came after the v0.1 editor bug and before
the landscape redesign; the card existed by `00:40:56`, which bounds it.

## Audio caveat

`publish/audio/session-part1.mp3` and `session-part2.mp3` are the extracted,
loudness-normalised (`I=-16 TP=-1.5 LRA=11`) mono tracks. Scrub these rather
than the 2–3 GB MKVs.

**There is no separate microphone stem.** Streamlabs wrote three audio tracks
but routed only one:

```
track1   mean -35.4 dB   max -10.2 dB   ← everything, mixed
track2   mean -91.0 dB                  digital silence
track3   mean -91.0 dB                  digital silence
```

So voice and game audio are inseparable in this recording, and the source level
was low. The normalised MP3s fix audibility; they cannot unmix the voice.

**Before the next session**, route mic → track 2 and desktop → track 3 in
Streamlabs output settings. Stems make cold opens trivial and let you duck game
audio under speech.

## Cutting the clip

Once you have exact in/out points, from `F:\videos`:

```powershell
$ff = "$env:LOCALAPPDATA\Microsoft\WinGet\Links\ffmpeg.exe"

# Replace START and DURATION. -ss before -i seeks fast and accurately enough.
& $ff -hide_banner -ss 00:31:40 -t 00:00:45 `
      -i "2026-09-20_19-07-38.mkv" -map "0:a:0" -ac 1 `
      -af "loudnorm=I=-16:TP=-1.5:LRA=11" `
      -c:a libmp3lame -b:a 192k `
      "publish\audio\cold-open-raw.mp3"
```

For a tighter edit with fades, add to the filter chain:

```
-af "loudnorm=I=-16:TP=-1.5:LRA=11,afade=t=in:st=0:d=0.4,afade=t=out:st=44.6:d=0.4"
```

Adjust `st=44.6` to `(duration - 0.4)`.

## Using it

Lead the episode with the raw tape, then let the hosts take over. Thirty to
sixty seconds is plenty. The value is authenticity — a generated conversation
cannot fake the sound of someone finding out they were wrong in real time.

If the audio proves too rough to use, the fallback is to have the hosts quote
the moment rather than play it. Say so explicitly in the brief; do not let a
generator imply tape exists when it does not.
