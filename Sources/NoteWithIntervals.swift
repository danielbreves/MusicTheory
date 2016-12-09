//
//  NoteWithIntervals.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

/**
  A root note with intervals (or a scale).
*/
open class RootWithIntervals {
  internal(set) open var notes: [Note]

  /**
    Initializes the scale with a root note and intervals.

    - parameter root:The root note of the scale.
    - parameter intervals:an array of interval symbols for the scale.

    - returns: The new RootWithIntervals instance.
  */
  public init(root: Note, intervals: [String]) {
    var currentNote = root
    var notes = [currentNote]

    for interval in intervals {
      currentNote = root.add(interval)
      notes.append(currentNote)
    }

    self.notes = notes
  }

  internal init(notes: [Note]) {
    self.notes = notes
  }

  fileprivate(set) open lazy var names: [String] = {
    return self.notes.map {
      (note) -> String in
      return note.name
    }
  }()

  fileprivate(set) open lazy var values: [Int8] = {
    return self.notes.map {
      (note) -> Int8 in
      return note.value
    }
  }()

  /**
    The root note.

    - returns: the root note.
  */
  open func root() -> Note {
    return notes[0]
  }

  /**
    Copies the scale.

    - returns: the copy of the scale.
  */
  open func copy() -> RootWithIntervals {
    let copiedNotes = notes.map { $0.copy() }
    return RootWithIntervals(notes: copiedNotes)
  }
}
