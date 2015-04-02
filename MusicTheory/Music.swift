//
//  Constants.swift
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
  
  public static let Alphabet = sorted(Notes.keys.array)
  
  public typealias Interval = (degree: Int8, steps: Int8)
  
  public static let Intervals: [String: Interval] = [
    "m2": (1, 1),
    "M2": (1, 2),
    "m3": (2, 3),
    "M3": (2, 4)
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
    "aug":  ["M3", "M3"]
  ]
}