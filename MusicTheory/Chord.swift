//
//  Chord.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 12/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

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
    let chordTypeName = type == "maj" || type == "M" ? "" : type
    self.name = "\(root.name)\(chordTypeName)"
    self.octave = root.octave
    super.init(root: root, intervals: Music.Chords[type]!)
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
