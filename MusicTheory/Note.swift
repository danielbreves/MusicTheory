//
//  Note.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

open class Note: Comparable {
  var _name: String

  open var name: String {
    return _name
  }

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

  public init(name: String, octave: Int8 = 4) {
    self._name = name
    self.octave = octave
  }

  fileprivate init(name: String, value: Int8, octave: Int8) {
    self._name = name
    self.octave = octave
    self._value = value
  }

  open func scale(_ type: String) -> RootWithIntervals {
    return RootWithIntervals(root: self, intervals: Music.Scales[type]!)
  }

  open func chord(_ type: String) -> Chord {
    return Chord(root: self, type: type)
  }

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

  open func copy() -> Note {
    return Note(name: self.name, value: self.value, octave: self.octave)
  }
}

prefix public func ++(note: inout Note) -> Note {
  note._value = note._value! + 1

  if (note._name.characters.last == Music.FLAT) {
    note._name.remove(at: note._name.characters.index(before: note._name.endIndex))
  } else {
    note._name.append(Music.SHARP)
  }

  return note
}

prefix public func --(note: inout Note) -> Note {
  note._value = note._value! - 1

  if (note._name.characters.last == Music.SHARP) {
    note._name.remove(at: note._name.characters.index(before: note._name.endIndex))
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
