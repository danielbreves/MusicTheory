//
//  Key.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 26/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

/**
  Represents a musical key with a note, a quality (e.g. major or minor) and a name (e.g. C minor).
*/
open class Key: Comparable {
  /**
    The key note.
  */
  open let note: Note

  /**
    The quality of the key (e.g. minor).
  */
  open let quality: String

  /**
    The name of the key (e.g. C minor).
  */
  open let name: String
  fileprivate var chordCache = [String: Chord]()

  fileprivate(set) open lazy var scale: RootWithIntervals = {
    return self.note.scale(self.quality)
  }()

  /**
    Initializes the key with a note and a quality.

    - parameter note:The key note.
    - parameter note:The quality of the key (e.g. major or minor).

    - returns: The new Key instance.
  */
  public init(note: Note, quality: String) {
    note.octave = 4
    self.note = note
    self.quality = quality
    self.name = "\(note.name) \(quality)"
  }

  /**
    Initializes the key with a name and a quality.

    - parameter name:The name of the key.
    - parameter quality:The quality of the key (e.g. major or minor).

    - returns: The new Key instance.
  */
  public convenience init(name: String, quality: String = "major") {
    let note = Note(name: name)
    self.init(note: note, quality: quality)
  }

  /**
    Generates a chord from a key degree and a type.

    - parameter degree:The degree of the chord to generate.
    - parameter degree:The type of chord to generate (e.g. maj).

    - returns: a new chord.
  */
  open func chord(_ degree: String, type: String = "maj") -> Chord? {
    let chordName = "\(degree)\(type)"
    var chord = chordCache[chordName]
    if (chord != nil) {
      return chord
    }

    var degreeSymbol = degree
    let flatOrSharp = degree[degree.startIndex]

    if (flatOrSharp == Music.FLAT || flatOrSharp == Music.SHARP) {
      degreeSymbol.remove(at: degreeSymbol.startIndex)
    }

    let scaleIndex = Music.Degrees.index(of: degreeSymbol)
    var root = self.scale.notes[scaleIndex!].copy()

    if (flatOrSharp == Music.FLAT) {
      --root
    } else if (flatOrSharp == Music.SHARP) {
      ++root
    }

    chord = root.chord(type)
    chordCache[chordName] = chord

    return chord
  }
}

/**
  Checks if the first key note's value is less than the second.

  - parameter lhs:The first key to compare.
  - parameter rhs:The second key to compare.

  - returns: a bool.
*/
public func <(lhs: Key, rhs: Key) -> Bool {
  let lhsNote = lhs.note
  let rhsNote = rhs.note
  rhsNote.octave = lhsNote.octave
  return rhsNote.value < lhsNote.value
}

/**
  Checks if two keys have the same name.

  - parameter lhs:The first key to compare.
  - parameter rhs:The second key to compare.

  - returns: a bool.
*/
public func ==(lhs: Key, rhs: Key) -> Bool {
  return lhs.name == rhs.name
}
