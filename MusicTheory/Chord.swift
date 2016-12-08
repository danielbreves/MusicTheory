//
//  Chord.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 12/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

/**
  A subclass of `RootWithIntervals` with a name (e.g. G maj). It supports changing octaves and position.
*/
open class Chord: RootWithIntervals {
  /**
    The name of the chord.
  */
  open let name: String

  /**
    The current position or inversion of the chord.
  */
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

  /**
    The current octave of the chord.
  */
  open var octave: Int8 {
    didSet {
      let diff = oldValue.distance(to: octave)
      for note in notes {
        note.octave += diff
      }
    }
  }

  /**
    Initializes the chord with a root note and a type.

    @param root The root note.
    @param type The type of chord (e.g. maj).

    @return The new Chord instance.
  */
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

  /**
    Copies the chord.

    @return the copy of the chord.
  */
  open override func copy() -> Chord {
    let copiedNotes = super.copy().notes
    return Chord(name: self.name, octave: self.octave, position: self.position, notes: copiedNotes)
  }
}

/**
  Moves each note of the chord up one semitone.

  @param chord The chord to move up.

  @return the chord object.
*/
prefix public func ++(chord: inout Chord) -> Chord {
  chord.notes = chord.notes.map {
    (note) -> Note in
    var note = note
    return ++note
  }

  return chord
}

/**
  Moves each note of the chord down one semitone.

  @param chord The chord to move down.

  @return the chord object.
*/
prefix public func --(chord: inout Chord) -> Chord {
  chord.notes = chord.notes.map {
    (note) -> Note in
    var note = note
    return --note
  }

  return chord
}
