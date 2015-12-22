//
//  Chord.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 12/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation
import Regex

func parseChord(name: String) -> MatchResult? {
  let flatOrSharp = "([b#])?"
  let scaleDegree = "((?:I{1,3}|i{1,3})|(?:IV|iv|VI{0,2}|vi{0,2}))"
  let minMajDimAugOrSus = "(min|maj|dim|aug|sus4|sus2)?"
  let seventh = "([mM]?7)?"
  let added = "([b#]?(?:5|6|9|11|13))*"
  let chordSymbolRegex = Regex("^\(flatOrSharp)\(scaleDegree)\(minMajDimAugOrSus)\(seventh)\(added)$")

  return chordSymbolRegex.match(name)
}

func buildChord(parts: [String?]) -> [String] {
  let minMajDimAugOrSus = parts[2]
  let seventh = parts[3]
  var intervals = Music.Chords["maj"]

  if (minMajDimAugOrSus != nil) {
    intervals = Music.Chords[minMajDimAugOrSus!]

    if (seventh == "7") {
      if (minMajDimAugOrSus == "maj") {
        intervals?.append("M3")
      } else if (["min", "dim", "sus2", "sus4"].contains(minMajDimAugOrSus!)) {
        intervals?.append("m3")
      }
    }
  } else if (seventh == "7") {
    intervals = Music.Chords["dom7"]
  }

  if (seventh == "M7") {
    intervals?.append("M3")
  } else if (seventh == "m7") {
    intervals = Music.Chords["min"]
    intervals?.append("m3")
  }

  // implement added notes

  return intervals!
}

public class Chord: RootWithIntervals {
  public let name: String

  public var position: Int8 = 0 {
    didSet {
      let steps = oldValue.distanceTo(position)

      if steps > 0 {
        for _ in 0...steps - 1 {
          let note = self.notes.removeAtIndex(0)
          note.octave++
          self.notes.append(note)
        }
      } else if steps < 0 {
        for _ in 0...abs(steps) - 1 {
          let note = self.notes.removeLast()
          note.octave--
          self.notes.insert(note, atIndex: 0)
        }
      }
    }
  }

  public var octave: Int8 {
    didSet {
      let diff = oldValue.distanceTo(octave)
      for note in notes {
        note.octave += diff
      }
    }
  }

  public init(root: Note, type: String) {
    self.name = "\(root.name) \(type)"
    self.octave = root.octave
    super.init(root: root, intervals: Music.Chords[type]!)
  }

  public init(key: Key, name: String) {
    let chordParts = parseChord(name)?.captures
    let flatOrSharp = chordParts![0]
    let scaleDegree = chordParts![1]
    let scaleIndex = Music.Degrees.indexOf(scaleDegree!)
    var root = key.scale.notes[scaleIndex!]

    if (flatOrSharp == "b") {
      --root
    } else if (flatOrSharp == "#") {
      ++root
    }

    self.name = name.stringByReplacingOccurrencesOfString(scaleDegree!, withString: root.name)
    self.octave = root.octave

    super.init(root: root, intervals: buildChord(chordParts!))
  }

  private init(name: String, octave: Int8, position: Int8, notes: [Note]) {
    self.name = name
    self.octave = octave
    self.position = position
    super.init(notes: notes)
  }

  public override func copy() -> Chord {
    let copiedNotes = super.copy().notes
    return Chord(name: self.name, octave: self.octave, position: self.position, notes: copiedNotes)
  }
}

prefix public func ++(inout chord: Chord) -> Chord {
  chord.notes = chord.notes.map {
    (var note) -> Note in
    return ++note
  }

  return chord
}

prefix public func --(inout chord: Chord) -> Chord {
  chord.notes = chord.notes.map {
    (var note) -> Note in
    return --note
  }

  return chord
}
