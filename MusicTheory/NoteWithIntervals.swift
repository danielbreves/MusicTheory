//
//  NoteWithIntervals.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

open class RootWithIntervals {
  internal(set) open var notes: [Note]

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

  open func root() -> Note {
    return notes[0]
  }

  open func copy() -> RootWithIntervals {
    let copiedNotes = notes.map { $0.copy() }
    return RootWithIntervals(notes: copiedNotes)
  }
}
