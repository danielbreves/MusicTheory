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
  let scaleDegree = "(I{1,3}|IV|VI{0,2})"
  let minMajDimAugOrSus = "(min|maj|dim|aug|sus4|sus2)?"
  let seventh = "([mMd+]?7)?"
  let fifth = "([b#]5)?"
  let added = "([b#]?(?:6|9|11|13))*"
  let chordSymbolRegex = Regex("^\(flatOrSharp)\(scaleDegree)\(minMajDimAugOrSus)\(seventh)\(fifth)\(added)$")

  return chordSymbolRegex.match(name)
}

func buildChord(parts: [String?]) -> [String] {
  var minMajDimAugOrSus = parts[2]
  var seventh = parts[3]
  let fifth = parts[4]

  if (seventh == "7" || seventh == "+7") {
    switch parts[2] {
    case "maj"?:
      seventh = "M7"
    case "dim"?:
      seventh = "d7"
    default:
      seventh = "m7"
    }
  }

  if (minMajDimAugOrSus == nil) {
    switch parts[3] {
    case "m7"?:
      minMajDimAugOrSus = "min"
    case "d7"?:
      minMajDimAugOrSus = "dim"
    case "+7"?:
      minMajDimAugOrSus = "aug"
    default:
      minMajDimAugOrSus = "maj"
    }
  }

  var intervals = Music.Chords[minMajDimAugOrSus!]

  let indexOfFifth = intervals?.indexOf("P5")
  if (indexOfFifth != nil && fifth != nil) {
    let flatOrSharp = fifth?.characters.first!
    intervals![indexOfFifth!] = flatOrSharp == "b" ? "d5" : "A5"
  }

  if (seventh != nil) {
    intervals?.append(seventh!)
  }

  print(intervals)

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
    print(name)
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
