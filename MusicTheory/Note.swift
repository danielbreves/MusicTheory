//
//  Note.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

public class Note {
  public let name: String
  public let value: Int8
  public let octave: Int8
  
  lazy var letter: String = {
    return String(first(self.name)!)
  }()
  
  lazy var letterIndex: Int = {
    let letter = String(first(self.name)!)
    return find(Music.Alphabet, letter)!
  }()
  
  public init(name: String, octave: Int8 = 4) {
    self.name = name
    self.octave = octave
    
    let keyLetter = String(first(name)!)
    var oct = octave
    var noteValue = Music.Notes[keyLetter]!
    
    if countElements(name) > 1 {
      let accident = name[name.endIndex.predecessor()]
      
      if accident == "#" {
        noteValue++
      } else if accident == "b" {
        noteValue--
      }
    }
    
    noteValue += (octave + 1) * 12
    
    self.value = noteValue
  }
  
  private init(name: String, value: Int8, octave: Int8) {
    self.name = name
    self.value = value
    self.octave = octave
  }
  
  public func scale(type: String) -> RootWithIntervals {
    return RootWithIntervals(root: self, intervals: Music.Scales[type]!)
  }
  
  public func chord(quality: String) -> RootWithIntervals {
    return RootWithIntervals(root: self, intervals: Music.Chords[quality]!)
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
    
    let accidentals = distance(resultantLetterValue, resultantNoteValue)
    
    if accidentals != 0 {
      let accidentalSymbol = accidentals > 0 ? "#" : "b"
      let numberOfAccidentals = abs(accidentals)
      
      for _ in 0..<numberOfAccidentals {
        resultantNoteName += accidentalSymbol
      }
    }
    
    return Note(name: resultantNoteName, value: resultantNoteValue, octave: octave)
  }
}