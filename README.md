# MusicTheory
A music theory library for Swift OS X and iOS apps.

MusicTheory provides objects to work with musical keys, notes, scales and chords. It can be used to generate a scale from a key or note symbol, or a chord from a key and a chord degree for example. You can also use it to translate a sequence of notes to a sequence of MIDI values.

## Installation

### CocoaPods

Put this in your Podfile:

```ruby
pod "MusicTheory", "~> 1.1"
```

## Usage:

```swift
let cFlat = Note(name: "C♭")

let cFlatMinorScale = cFlat.scale("minor")

cFlatMinorScale.names // ["C♭", "D♭", "E♭♭", "F♭", "G♭", "A♭♭", "B♭♭"]
cFlatMinorScale.values // [59, 61, 62, 64, 66, 67, 69]

let cFlatMinChord = Chord(root: cFlat, type: "min") // or cFlat.chord("min")

cFlatMinChord.names // ["C♭", "E♭♭", "G♭"]
cFlatMinChord.values // [59, 62, 66]

let cFlatMajor = Key(note: cFlat, quality: "major")
let cFlatV7 = cFlatMajor.chord("V", type: "7")!

cFlatV7.name // "G♭7"
cFlatV7.notes.map { $0.name } // ["G♭", "B♭", "D♭", "F♭"]
```

For a list of all supported chord types see: [Sources/Music.swift](https://github.com/danielbreves/MusicTheory/blob/master/Sources/Music.swift)

For more usage examples see: [Tests/MusicTheoryTests.swift](https://github.com/danielbreves/MusicTheory/blob/master/Tests/MusicTheoryTests.swift)

## Contributing

Improvements are always welcome. Please follow these steps to contribute:

1. Submit a Pull Request with a detailed explanation of changes and tests
2. Receive a :+1: from a core team member
3. Core team will merge your changes

## License

See [LICENSE](LICENSE).
