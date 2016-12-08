//
//  Chord.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 12/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

open class Chord: RootWithIntervals {
  open let name: String

  open var position: Int8 = 0 {
    didSet {
      let steps = oldValue.distance(to: position)

      if steps > 0 {
        for _ in 0...steps - 1 {
          let note = self.notes.remove(at: 0)
          note.octave += 1
          self.notes.append(note)
        }
      } else if steps < 0 {
        for _ in 0...abs(steps) - 1 {
          let note = self.notes.removeLast()
          note.octave -= 1
          self.notes.insert(note, at: 0)
        }
      }
    }
  }

  open var octave: Int8 {
    didSet {
      let diff = oldValue.distance(to: octave)
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

  fileprivate init(name: String, octave: Int8, position: Int8, notes: [Note]) {
    self.name = name
    self.octave = octave
    self.position = position
    super.init(notes: notes)
  }

  open override func copy() -> Chord {
    let copiedNotes = super.copy().notes
    return Chord(name: self.name, octave: self.octave, position: self.position, notes: copiedNotes)
  }
}

prefix public func ++(chord: inout Chord) -> Chord {
  chord.notes = chord.notes.map {
    (note) -> Note in
    var note = note
    return ++note
  }

  return chord
}

prefix public func --(chord: inout Chord) -> Chord {
  chord.notes = chord.notes.map {
    (note) -> Note in
    var note = note
    return --note
  }

  return chord
}
