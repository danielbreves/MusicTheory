//
//  NoteWithIntervals.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

public class RootWithIntervals {
  public var notes: [Note]

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

  private(set) public lazy var names: [String] = {
    return self.notes.map {
      (var note) -> String in
      return note.name
    }
  }()

  private(set) public lazy var values: [Int8] = {
    return self.notes.map {
      (var note) -> Int8 in
      return note.value
    }
  }()

  public func root() -> Note {
    return notes[0]
  }

  public func copy() -> RootWithIntervals {
    let copiedNotes = notes.map { $0.copy() }
    return RootWithIntervals(notes: copiedNotes)
  }
}