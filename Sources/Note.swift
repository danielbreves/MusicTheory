//
//  Note.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

/**
  A musical note.
*/
open class Note: Comparable {
  var _name: String

  /**
    The name of the note.
  */
  open var name: String {
    return _name
  }

  /**
    The current octave of the note.
  */
  open var octave: Int8 {
    didSet {
      self._value = nil
    }
  }

  lazy var letter: String = {
    return String(self.name.characters.first!)
  }()

  lazy var letterIndex: Int = {
    let letter = String(self.name.characters.first!)
    return Music.Alphabet.index(of: letter)!
  }()

  var _value: Int8?

  /**
    The midi value of the note.
  */
  open var value: Int8 {
    if self._value != nil {
      return self._value!
    }

    let keyLetter = String(self.name.characters.first!)
    var noteValue = Music.Notes[keyLetter]!

    if self.name.characters.count > 1 {
      let accident = self.name[self.name.characters.index(before: self.name.endIndex)]

      if accident == Music.SHARP {
        noteValue += 1
      } else if accident == Music.FLAT {
        noteValue -= 1
      }
    }

    noteValue += (self.octave + 1) * 12

    self._value = noteValue

    return self._value!
  }

  /**
    Initializes the note with a name and octave.

    - parameter name:The name of the note.
    - parameter octave:The initial octave of the note.

    - returns: The new Note instance.
  */
  public init(name: String, octave: Int8 = 4) {
    self._name = name
    self.octave = octave
  }

  fileprivate init(name: String, value: Int8, octave: Int8) {
    self._name = name
    self.octave = octave
    self._value = value
  }

  /**
    Generates a scale from a type, with the note as root.

    - parameter type:The type of scale to generate.

    - returns: a RootWithIntervals.
  */
  open func scale(_ type: String) -> RootWithIntervals {
    return RootWithIntervals(root: self, intervals: Music.Scales[type]!)
  }

  /**
    Generates a chord from a type, with the note as root.

    - parameter type:The type of chord to generate.

    - returns: a Chord.
  */
  open func chord(_ type: String) -> Chord {
    return Chord(root: self, type: type)
  }

  /**
    Generate a new note after adding the passed interval.

    - parameter intervalSymbol:The symbol of the interval to add to the note (e.g. m2).

    - returns: a new Note.
  */
  open func add(_ intervalSymbol: String) -> Note {
    let interval = Music.Intervals[intervalSymbol]!
    let noteLetterValue = Music.Notes[self.letter]!
    let resultantLetterIndex = (self.letterIndex + Int(interval.degree)) % Music.Alphabet.count
    var resultantNoteName = Music.Alphabet[resultantLetterIndex]
    var resultantLetterValue = Music.Notes[resultantNoteName]!

    let resultantNoteValue = self.value + interval.steps
    var octave = self.octave

    if resultantLetterValue < noteLetterValue {
      octave += 1
    }

    resultantLetterValue += (octave + 1) * 12

    let accidentals = resultantLetterValue.distance(to: resultantNoteValue)

    if accidentals != 0 {
      let accidentalSymbol = accidentals > 0 ? Music.SHARP : Music.FLAT
      let numberOfAccidentals = abs(accidentals)

      for _ in 0..<numberOfAccidentals {
        resultantNoteName.append(accidentalSymbol)
      }
    }

    return Note(name: resultantNoteName, value: resultantNoteValue, octave: octave)
  }

  /**
    Copies the note.

    - returns: the copy of the note.
  */
  open func copy() -> Note {
    return Note(name: self.name, value: self.value, octave: self.octave)
  }
}

/**
  Moves the note up one semitone.

  - parameter note:The note to move up.

  - returns: the note object.
*/
@discardableResult
prefix public func ++(note: inout Note) -> Note {
  note._value = note._value! + 1

  if (note._name.characters.last == Music.FLAT) {
    note._name.remove(at: note._name.characters.index(before: note._name.endIndex))
  } else {
    note._name.append(Music.SHARP)
  }

  return note
}

/**
  Moves the note down one semitone.

  - parameter note:The note to move down.

  - returns: the note object.
*/
@discardableResult
prefix public func --(note: inout Note) -> Note {
  note._value = note._value! - 1

  if (note._name.characters.last == Music.SHARP) {
    note._name.remove(at: note._name.characters.index(before: note._name.endIndex))
  } else {
    note._name.append(Music.FLAT)
  }

  return note
}

/**
  Checks if the first note's value is less than the second.

  - parameter lhs:The first note to compare.
  - parameter rhs:The second note to compare.

  - returns: a bool.
*/
public func <(lhs: Note, rhs: Note) -> Bool {
  return lhs.value < rhs.value
}

/**
  Checks if two notes are equal in value.

  - parameter lhs:The first note to compare.
  - parameter rhs:The second note to compare.

  - returns: a bool.
*/
public func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.value == rhs.value
}
