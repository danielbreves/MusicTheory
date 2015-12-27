//
//  MusicTheoryTests.swift
//  MusicTheoryTests
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Cocoa
import XCTest
import MusicTheory
import Regex

class MusicTheoryTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

  func testNote() {
    let cFlat = Note(name: "Cb")

    XCTAssertEqual(cFlat.name, "Cb",
      "Cb returns correct name")

    XCTAssertEqual(cFlat.value, 59,
      "Cb return correct value")
  }

  func testScales() {
    let cFlat = Note(name: "Cb")
    let cFlatMinorScale = cFlat.scale("minor")

    XCTAssertEqual(cFlatMinorScale.names, ["Cb", "Db", "Ebb", "Fb", "Gb", "Abb", "Bbb"],
      "Cb minor scale returns correct names")

    XCTAssertEqual(cFlatMinorScale.values, [59, 61, 62, 64, 66, 67, 69],
      "Cb minor scale returns correct values")

    let eSharp = Note(name: "E#")
    let eSharpMajorScale = eSharp.scale("major")

    XCTAssertEqual(eSharpMajorScale.names, ["E#", "F##", "G##", "A#", "B#", "C##", "D##"],
      "E# major scale returns correct names")

    XCTAssertEqual(eSharpMajorScale.values, [65, 67, 69, 70, 72, 74, 76],
      "E# major scale returns correct values")

    let fFlat = Note(name: "Fb")
    let fFlatMinorScale = fFlat.scale("minor")

    XCTAssertEqual(fFlatMinorScale.names, ["Fb", "Gb", "Abb", "Bbb", "Cb", "Dbb", "Ebb"],
      "Fb minor scale returns correct names")

    XCTAssertEqual(fFlatMinorScale.values, [64, 66, 67, 69, 71, 72, 74],
      "Fb minor scale returns correct values")

    let bSharp = Note(name: "B#")
    let bSharpMajorScale = bSharp.scale("major")

    XCTAssertEqual(bSharpMajorScale.names, ["B#", "C##", "D##", "E#", "F##", "G##", "A##"],
      "B# major scale returns correct names")

    XCTAssertEqual(bSharpMajorScale.values, [72, 74, 76, 77, 79, 81, 83],
      "B# major scale returns correct values")
  }

  func testChords() {
    let cFlat = Note(name: "Cb")
    let cFlatMin = cFlat.chord("min")

    XCTAssertEqual(cFlatMin.names, ["Cb", "Ebb", "Gb"],
      "Cb min chord returns correct names")

    XCTAssertEqual(cFlatMin.values, [59, 62, 66],
      "Cb min chord returns correct values")

    let eSharp = Note(name: "E#")
    let eSharpMaj = eSharp.chord("maj")

    XCTAssertEqual(eSharpMaj.names, ["E#", "G##", "B#"],
      "E# maj chord returns correct names")

    XCTAssertEqual(eSharpMaj.values, [65, 69, 72],
      "E# maj chord returns correct values")

    let fFlat = Note(name: "Fb")
    let fFlatMin = fFlat.chord("min")

    XCTAssertEqual(fFlatMin.names, ["Fb", "Abb", "Cb"],
      "Fb min chord returns correct names")

    XCTAssertEqual(fFlatMin.values, [64, 67, 71],
      "Fb min chord returns correct values")

    let bSharp = Note(name: "B#")
    let bSharpMaj = bSharp.chord("maj")

    XCTAssertEqual(bSharpMaj.names, ["B#", "D##", "F##"],
      "B# maj chord returns correct names")

    XCTAssertEqual(bSharpMaj.values, [72, 76, 79],
      "B# maj chord returns correct values")
  }

  func testKey() {
    let cFlat = Note(name: "Cb")
    let cFlatMajor = Key(note: cFlat, quality: "major")
    let cFlatMajorChord = cFlatMajor.chord("I")

    XCTAssertEqual(cFlatMajorChord?.name, "Cb maj",
      "Cb major chord return the correct name")

    XCTAssertEqual((cFlatMajorChord?.notes.map { $0.name })!, ["Cb", "Eb", "Gb"],
      "Cb major chord returns the correct notes")
  }
  
  func testChordsInKey() {
    let cMajor = Key(name: "C")

    let chordG7 = Chord(key: cMajor, name: "V7")
    XCTAssertEqual(chordG7.names, ["G", "B", "D", "F"],
      "V7 in the key of C Major returns the correct notes")

    let chordGM7 = Chord(key: cMajor, name: "Vmaj7")
    XCTAssertEqual(chordGM7.names, ["G", "B", "D", "F#"],
      "Vmaj7 in the key of C Major returns the correct notes")
    XCTAssertEqual(chordGM7.names, Chord(key: cMajor, name: "VM7").names,
      "Vmaj7 is equivalent to VM7")

    let chordGmaj7b5 = Chord(key: cMajor, name: "Vmaj7b5")
    XCTAssertEqual(chordGmaj7b5.names, ["G", "B", "Db", "F#"],
      "Vmaj7b5 in the key of C Major returns the correct notes")

    let chordGmaj7sharp5 = Chord(key: cMajor, name: "Vmaj7#5")
    XCTAssertEqual(chordGmaj7sharp5.names, ["G", "B", "D#", "F#"],
      "Vmaj7#5 in the key of C Major returns the correct notes")

    let chordGm7 = Chord(key: cMajor, name: "Vmin7")
    XCTAssertEqual(chordGm7.names, ["G", "Bb", "D", "F"],
      "Vmin7 in the key of C Major returns the correct notes")
    XCTAssertEqual(chordGm7.names, Chord(key: cMajor, name: "Vm7").names,
      "Vmin7 is equivalent to Vm7")

    let chordGmin7b5 = Chord(key: cMajor, name: "Vmin7b5")
    XCTAssertEqual(chordGmin7b5.names, ["G", "Bb", "Db", "F"],
      "Vmin7b5 in the key of C Major returns the correct notes")

    let chordGdim = Chord(key: cMajor, name: "Vdim")
    XCTAssertEqual(chordGdim.names, ["G", "Bb", "Db"],
      "Vdim in the key of C Major returns the correct notes")

    let chordGdim7 = Chord(key: cMajor, name: "Vdim7")
    XCTAssertEqual(chordGdim7.names, ["G", "Bb", "Db", "Fb"],
      "Vdim7 in the key of C Major returns the correct notes")
    XCTAssertEqual(chordGdim7.names, Chord(key: cMajor, name: "Vd7").names,
      "Vdim7 is equivalent to Vd7")

    let chordGaug = Chord(key: cMajor, name: "Vaug")
    XCTAssertEqual(chordGaug.names, ["G", "B", "D#"],
      "Vaug in the key of C Major returns the correct notes")

    let chordGaug7 = Chord(key: cMajor, name: "Vaug7")
    XCTAssertEqual(chordGaug7.names, ["G", "B", "D#", "F"],
      "Vaug7 in the key of C Major returns the correct notes")
    XCTAssertEqual(chordGaug7.names, Chord(key: cMajor, name: "V+7").names,
      "Vaug7 is equivalent to V+7")

    let chordGsus2 = Chord(key: cMajor, name: "Vsus2")
    XCTAssertEqual(chordGsus2.names, ["G", "A", "D"],
      "Vsus2 in the key of C Major returns the correct notes")

    let chordGsus4 = Chord(key: cMajor, name: "Vsus4")
    XCTAssertEqual(chordGsus4.names, ["G", "C", "D"],
      "Vsus4 in the key of C Major returns the correct notes")

    let chordGsus7 = Chord(key: cMajor, name: "Vsus47")
    XCTAssertEqual(chordGsus7.names, ["G", "C", "D", "F"],
      "Vsus47 in the key of C Major returns the correct notes")

    let chordGminM7 = Chord(key: cMajor, name: "VminM7")
    XCTAssertEqual(chordGminM7.names, ["G", "Bb", "D", "F#"],
      "VminM7 in the key of C Major returns the correct notes")
  }

}
