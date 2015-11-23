# MusicTheory
A music theory library for Swift OS X and iOS apps.

## Usage:

```swift
let cFlat = Note(name: "Cb")

let cFlatMinorScale = cFlat.scale("minor")

cFlatMinorScale.names // ["Cb", "Db", "Ebb", "Fb", "Gb", "Abb", "Bbb"]
cFlatMinorScale.values // [59, 61, 62, 64, 66, 67, 69]

let cFlatMinChord = cFlat.chord("min")

cFlatMinChord.names // ["Cb", "Ebb", "Gb"]
cFlatMinChord.values // [59, 62, 66]

let cFlatMajor = Key(note: cFlat, quality: "major")
let cFlatMajorChord = cFlatMajor.chord("I")

cFlatMajorChord.name // "Cb maj"
cFlatMajorChord.notes.map { $0.name } // ["Cb", "Eb", "Gb"]