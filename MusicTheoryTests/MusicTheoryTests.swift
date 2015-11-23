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

}
