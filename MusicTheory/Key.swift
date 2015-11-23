//
//  Key.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 26/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

public class Key: Comparable {
  let note: Note
  let quality: String
  let name: String

  lazy var scale: RootWithIntervals = {
    return self.note.scale(self.quality)
  }()

  lazy var chordTypes: [String] = {
    if (self.quality == "minor") {
      return ["min", "dim", "maj", "min", "min", "maj", "maj"]
    }

    return ["maj", "min", "min", "maj", "maj", "min", "dim"]
  }()

  typealias ChordSetItem = (degree: String, chord: Chord)

  lazy var chordSet: [ChordSetItem] = {
    var result = [ChordSetItem]()

    for (i, note) in self.scale.notes.enumerate() {
      let chordDegree = Music.Degrees[i]
      result.append(degree: chordDegree, chord: Chord(root: note, type: self.chordTypes[i]))
    }

    return result
  }()

  public init(note: Note, quality: String) {
    note.octave = 4
    self.note = note
    self.quality = quality
    self.name = "\(note.name) \(quality)"
  }

  convenience init(name: String, quality: String = "major") {
    let note = Note(name: name)
    self.init(note: note, quality: quality)
  }

  public func chord(degree: String) -> Chord? {
    for item in self.chordSet {
      if (item.degree == degree) {
        return item.chord
      }
    }

    return nil
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