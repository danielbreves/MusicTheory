//
//  Music.swift
//  MusicTheory
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Foundation

public struct Music {
  public static let Notes: [String: Int8] = [
    "C": 0,
    "D": 2,
    "E": 4,
    "F": 5,
    "G": 7,
    "A": 9,
    "B": 11
  ]

  public static let Degrees = ["I", "II", "III", "IV", "V", "VI", "VII"]

  public static let Alphabet = Array(Notes.keys).sort()

  public typealias Interval = (degree: Int8, steps: Int8)

  public static let Intervals: [String: Interval] = [
    "m2": (1, 1),
    "M2": (1, 2),
    "m3": (2, 3),
    "M3": (2, 4),
    "P4": (3, 5),
    "A4": (3, 6),
    "P5": (4, 7),
    "m6": (5, 8),
    "M6": (5, 9),
    "m7": (6, 10),
    "M7": (6, 11),
    "P8": (7, 12),
  ]

  public static let Scales = [
    "major": ["M2", "M2", "m2", "M2", "M2", "M2"],
    "minor": ["M2", "m2", "M2", "M2", "m2", "M2"]
  ]

  public static let Chords = [
    "maj":  ["M3", "m3"],
    "min":  ["m3", "M3"],
    "dom7": ["M3", "m3", "m3"],
    "dim":  ["m3", "m3"],
    "aug":  ["M3", "M3"],
    "sus4": ["P4", "M2"],
    "sus2": ["M2", "P4"]
  ]

  public static let CircleOfFifths = [
    "major": ["C", "G", "D", "A", "E", "B", "F#", "C#", "F", "Bb", "Eb", "Ab", "Db", "Gb", "Cb"],
    "minor": ["A", "E", "B", "F#", "C#", "G#", "D#", "A#", "D", "G", "C", "F", "Bb", "Eb", "Ab"]
  ]
}