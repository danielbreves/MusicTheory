//
//  Music.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

/**
  A collection of musical constants to be used in various calculations.
*/
public struct Music {
  /**
    The sharp symbol.
  */
  public static let SHARP: Character = "♯"
  /**
    The flat symbol.
  */
  public static let FLAT: Character = "♭"

  /**
    A dictionary of notes and an Int8 representing their index.
  */
  public static let Notes: [String: Int8] = [
    "C": 0,
    "D": 2,
    "E": 4,
    "F": 5,
    "G": 7,
    "A": 9,
    "B": 11
  ]

  /**
    An array of musical degrees.
  */
  public static let Degrees = ["I", "II", "III", "IV", "V", "VI", "VII"]

  /**
    The letters used to represent notes sorted in alphabetical order.
  */
  public static let Alphabet = Array(Notes.keys).sorted()

  /**
    The interval type definition as a tuple of a degree index and number of steps.
  */
  public typealias Interval = (degree: Int8, steps: Int8)

  /**
    A dictionary of intervals symbols and their value.
  */
  public static let Intervals: [String: Interval] = [
    "m2": (1, 1),
    "M2": (1, 2),
    "m3": (2, 3),
    "M3": (2, 4),
    "P4": (3, 5),
    "A4": (3, 6),
    "d5": (4, 6),
    "P5": (4, 7),
    "A5": (4, 8),
    "m6": (5, 8),
    "M6": (5, 9),
    "d7": (6, 9),
    "m7": (6, 10),
    "M7": (6, 11),
    "A7": (6, 12),
    "P8": (7, 12),
  ]

  /**
    A dictionary of scale names and their intervals.
  */
  public static let Scales = [
    "major": ["M2", "M3", "P4", "P5", "M6", "M7"],
    "minor": ["M2", "m3", "P4", "P5", "m6", "m7"],
    "dorian": ["M2", "m3", "P4", "P5", "M6", "m7"],
    "phrygian": ["m2", "m3", "P4", "P5", "m6", "m7"],
    "lydian": ["M2", "M3", "A4", "P5", "M6", "M7"],
    "mixolydian": ["M2", "M3", "P4", "P5", "M6", "m7"],
    "locrian": ["m2", "m3", "P4", "d5", "m6", "m7"]
  ]

  /**
    A dictionary of chord names and their intervals.
  */
  public static let Chords: [String: [String]] = {
    var chordSymbolMap = [
      "min":  ["m3", "P5"],
      "maj":  ["M3", "P5"],
      "dim":  ["m3", "d5"],
      "aug":  ["M3", "A5"],
      "sus":  ["P4", "P5"],
      "sus2": ["M2", "P5"],
      "m2":   ["M2", "m3", "P5"],
      "M2":   ["M2", "M3", "P5"],
      "m6":   ["m3", "P5", "M6"],
      "M6":   ["M3", "P5", "M6"],
      "7":    ["M3", "P5", "m7"],
      "m7":   ["m3", "P5", "m7"],
      "M7":   ["M3", "P5", "M7"],
      "7sus": ["P4", "P5", "m7"],
      "dim7": ["m3", "d5", "d7"],
      "m7♭5": ["m3", "d5", "m7"],
      "mM7":  ["m3", "P5", "M7"],
      "aug7": ["M3", "A5", "m7"],
      "M7♭5": ["M3", "d5", "M7"],
      "M7♯5": ["M3", "A5", "M7"],
    ]

    chordSymbolMap["m"] = chordSymbolMap["min"]
    chordSymbolMap["M"] = chordSymbolMap["maj"]

    return chordSymbolMap
  }()

  /**
    A dictionary representing the circle of fifths, both major and minor.
  */
  public static let CircleOfFifths = [
    "major": ["C", "G", "D", "A", "E", "B", "F♯", "C♯", "F", "B♭", "E♭", "A♭", "D♭", "G♭", "C♭"],
    "minor": ["A", "E", "B", "F♯", "C♯", "G♯", "D♯", "A♯", "D", "G", "C", "F", "B♭", "E♭", "A♭"]
  ]
}
