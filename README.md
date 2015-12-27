# MusicTheory
A music theory library for Swift OS X and iOS apps. 

MusicTheory provides objects to work with musical keys, notes, scales and chords. It can be used to generate a scale from a key or note symbol, or a chord from a key and a chord degree for example. You can also use it to translate a sequence of notes to a sequence of MIDI values.

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
```

## Installation

### CocoaPods

Put this in your Podfile:

```ruby
pod 'MusicTheory', '~> 0.2'
```
