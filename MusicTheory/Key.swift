//
//  Key.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 26/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

open class Key: Comparable {
  open let note: Note
  open let quality: String
  open let name: String
  fileprivate var chordCache = [String: Chord]()

  fileprivate(set) open lazy var scale: RootWithIntervals = {
    return self.note.scale(self.quality)
  }()

  public init(note: Note, quality: String) {
    note.octave = 4
    self.note = note
    self.quality = quality
    self.name = "\(note.name) \(quality)"
  }

  public convenience init(name: String, quality: String = "major") {
    let note = Note(name: name)
    self.init(note: note, quality: quality)
  }

  open func chord(_ degree: String, type: String = "maj") -> Chord? {
    let chordName = "\(degree)\(type)"
    var chord = chordCache[chordName]
    if (chord != nil) {
      return chord
    }

    var degreeSymbol = degree
    let flatOrSharp = degree.characters.first

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

public func <(lhs: Key, rhs: Key) -> Bool {
  let lhsNote = lhs.note
  let rhsNote = rhs.note
  rhsNote.octave = lhsNote.octave
  return rhsNote.value < lhsNote.value
}

public func ==(lhs: Key, rhs: Key) -> Bool {
  return lhs.name == rhs.name
}
