//
//  Note.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

public class Note: Comparable {
  var _name: String

  public var name: String {
    return _name
  }

  public var octave: Int8 {
    didSet {
      self._value = nil
    }
  }

  lazy var letter: String = {
    return String(self.name.characters.first!)
  }()

  lazy var letterIndex: Int = {
    let letter = String(self.name.characters.first!)
    return Music.Alphabet.indexOf(letter)!
  }()

  var _value: Int8?

  public var value: Int8 {
    if self._value != nil {
      return self._value!
    }

    let keyLetter = String(self.name.characters.first!)
    var noteValue = Music.Notes[keyLetter]!

    if self.name.characters.count > 1 {
      let accident = self.name[self.name.endIndex.predecessor()]

      if accident == Music.SHARP {
        noteValue++
      } else if accident == Music.FLAT {
        noteValue--
      }
    }

    noteValue += (self.octave + 1) * 12

    self._value = noteValue

    return self._value!
  }

  public init(name: String, octave: Int8 = 4) {
    self._name = name
    self.octave = octave
  }

  private init(name: String, value: Int8, octave: Int8) {
    self._name = name
    self.octave = octave
    self._value = value
  }

  public func scale(type: String) -> RootWithIntervals {
    return RootWithIntervals(root: self, intervals: Music.Scales[type]!)
  }

  public func chord(type: String) -> Chord {
    return Chord(root: self, type: type)
  }

  public func add(intervalSymbol: String) -> Note {
    let interval = Music.Intervals[intervalSymbol]!
    let noteLetterValue = Music.Notes[self.letter]!
    let resultantLetterIndex = (self.letterIndex + Int(interval.degree)) % Music.Alphabet.count
    var resultantNoteName = Music.Alphabet[resultantLetterIndex]
    var resultantLetterValue = Music.Notes[resultantNoteName]!

    let resultantNoteValue = self.value + interval.steps
    var octave = self.octave

    if resultantLetterValue < noteLetterValue {
      octave++
    }

    resultantLetterValue += (octave + 1) * 12

    let accidentals = resultantLetterValue.distanceTo(resultantNoteValue)

    if accidentals != 0 {
      let accidentalSymbol = accidentals > 0 ? Music.SHARP : Music.FLAT
      let numberOfAccidentals = abs(accidentals)

      for _ in 0..<numberOfAccidentals {
        resultantNoteName.append(accidentalSymbol)
      }
    }

    return Note(name: resultantNoteName, value: resultantNoteValue, octave: octave)
  }

  public func copy() -> Note {
    return Note(name: self.name, value: self.value, octave: self.octave)
  }
}

prefix public func ++(inout note: Note) -> Note {
  note._value = note._value! + 1

  if (note._name.characters.last == Music.FLAT) {
    note._name.removeAtIndex(note._name.endIndex.predecessor())
  } else {
    note._name.append(Music.SHARP)
  }

  return note
}

prefix public func --(inout note: Note) -> Note {
  note._value = note._value! - 1

  if (note._name.characters.last == Music.SHARP) {
    note._name.removeAtIndex(note._name.endIndex.predecessor())
  } else {
    note._name.append(Music.FLAT)
  }

  return note
}

public func <(lhs: Note, rhs: Note) -> Bool {
  return lhs.value < rhs.value
}

public func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.value == rhs.value
}