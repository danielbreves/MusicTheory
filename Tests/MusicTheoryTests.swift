//
//  MusicTheoryTests.swift
//  MusicTheoryTests
//
//  Created by Daniel Breves Ribeiro on 2/04/2015.
//  Copyright (c) 2015 Daniel Breves. All rights reserved.
//

import Cocoa
import XCTest
@testable import MusicTheory

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
    let cFlat = Note(name: "C♭")

    XCTAssertEqual(cFlat.name, "C♭",
      "C♭ returns correct name")

    XCTAssertEqual(cFlat.value, 59,
      "C♭ return correct value")
  }

  func testScales() {
    let cFlat = Note(name: "C♭")
    let cFlatMinorScale = cFlat.scale("minor")

    XCTAssertEqual(cFlatMinorScale.names, ["C♭", "D♭", "E♭♭", "F♭", "G♭", "A♭♭", "B♭♭"],
      "C♭ minor scale returns correct names")

    XCTAssertEqual(cFlatMinorScale.values, [59, 61, 62, 64, 66, 67, 69],
      "C♭ minor scale returns correct values")

    let eSharp = Note(name: "E♯")
    let eSharpMajorScale = eSharp.scale("major")

    XCTAssertEqual(eSharpMajorScale.names, ["E♯", "F♯♯", "G♯♯", "A♯", "B♯", "C♯♯", "D♯♯"],
      "E♯ major scale returns correct names")

    XCTAssertEqual(eSharpMajorScale.values, [65, 67, 69, 70, 72, 74, 76],
      "E♯ major scale returns correct values")

    let fFlat = Note(name: "F♭")
    let fFlatMinorScale = fFlat.scale("minor")

    XCTAssertEqual(fFlatMinorScale.names, ["F♭", "G♭", "A♭♭", "B♭♭", "C♭", "D♭♭", "E♭♭"],
      "F♭ minor scale returns correct names")

    XCTAssertEqual(fFlatMinorScale.values, [64, 66, 67, 69, 71, 72, 74],
      "F♭ minor scale returns correct values")

    let bSharp = Note(name: "B♯")
    let bSharpMajorScale = bSharp.scale("major")

    XCTAssertEqual(bSharpMajorScale.names, ["B♯", "C♯♯", "D♯♯", "E♯", "F♯♯", "G♯♯", "A♯♯"],
      "B♯ major scale returns correct names")

    XCTAssertEqual(bSharpMajorScale.values, [72, 74, 76, 77, 79, 81, 83],
      "B♯ major scale returns correct values")
  }

  func testModes() {
    let c = Note(name: "C")
    let cDorian = c.scale("dorian")

    XCTAssertEqual(cDorian.names, ["C", "D", "E♭", "F", "G", "A", "B♭"],
                   "C dorian scale returns correct names")

    XCTAssertEqual(cDorian.values, [60, 62, 63, 65, 67, 69, 70],
                   "C dorian scale returns correct values")

    let cPhrygian = c.scale("phrygian")

    XCTAssertEqual(cPhrygian.names, ["C", "D♭", "E♭", "F", "G", "A♭", "B♭"],
                   "C phrygian scale returns correct names")

    XCTAssertEqual(cPhrygian.values, [60, 61, 63, 65, 67, 68, 70],
                   "C phrygian scale returns correct values")

    let cLydian = c.scale("lydian")

    XCTAssertEqual(cLydian.names, ["C", "D", "E", "F♯", "G", "A", "B"],
                   "C lydian scale returns correct names")

    XCTAssertEqual(cLydian.values, [60, 62, 64, 66, 67, 69, 71],
                   "C lydian scale returns correct values")

    let cMixolydian = c.scale("mixolydian")

    XCTAssertEqual(cMixolydian.names, ["C", "D", "E", "F", "G", "A", "B♭"],
                   "C mixolydian scale returns correct names")

    XCTAssertEqual(cMixolydian.values, [60, 62, 64, 65, 67, 69, 70],
                   "C mixolydian scale returns correct values")

    let cLocrian = c.scale("locrian")

    XCTAssertEqual(cLocrian.names, ["C", "D♭", "E♭", "F", "G♭", "A♭", "B♭"],
                   "C locrian scale returns correct names")

    XCTAssertEqual(cLocrian.values, [60, 61, 63, 65, 66, 68, 70],
                   "C locrian scale returns correct values")
  }

  func testChords() {
    let cFlat = Note(name: "C♭")
    let cFlatMin = cFlat.chord("min")

    XCTAssertEqual(cFlatMin.names, ["C♭", "E♭♭", "G♭"],
      "C♭ min chord returns correct names")

    XCTAssertEqual(cFlatMin.values, [59, 62, 66],
      "C♭ min chord returns correct values")

    let eSharp = Note(name: "E♯")
    let eSharpMaj = eSharp.chord("maj")

    XCTAssertEqual(eSharpMaj.names, ["E♯", "G♯♯", "B♯"],
      "E♯ maj chord returns correct names")

    XCTAssertEqual(eSharpMaj.values, [65, 69, 72],
      "E♯ maj chord returns correct values")

    let fFlat = Note(name: "F♭")
    let fFlatMin = fFlat.chord("min")

    XCTAssertEqual(fFlatMin.names, ["F♭", "A♭♭", "C♭"],
      "F♭ min chord returns correct names")

    XCTAssertEqual(fFlatMin.values, [64, 67, 71],
      "F♭ min chord returns correct values")

    let bSharp = Note(name: "B♯")
    let bSharpMaj = bSharp.chord("maj")

    XCTAssertEqual(bSharpMaj.names, ["B♯", "D♯♯", "F♯♯"],
      "B♯ maj chord returns correct names")

    XCTAssertEqual(bSharpMaj.values, [72, 76, 79],
      "B♯ maj chord returns correct values")
  }

  func testKey() {
    let cFlat = Note(name: "C♭")
    let cFlatMajor = Key(note: cFlat, quality: "major")

    let cFlatMajorScale = cFlatMajor.scale
    XCTAssertEqual(cFlatMajorScale.values, cFlat.scale("major").values,
      "C♭ major scale returns the correct values")

    let cFlatI = cFlatMajor.chord("I")!
    XCTAssertEqual(cFlatI.name, "C♭",
      "I in the key of C♭ major chord return the correct name")
    XCTAssertEqual(cFlatI.names, ["C♭", "E♭", "G♭"],
      "I in the key of C♭ major chord returns the correct notes")

    let cFlatIIm = cFlatMajor.chord("II", type: "m")!
    XCTAssertEqual(cFlatIIm.names, ["D♭", "F♭", "A♭"],
      "IIm in the key of C♭ Major returns the correct notes")

    let cFlatbII = cFlatMajor.chord("♭II")!
    XCTAssertEqual(cFlatbII.names, ["D♭♭", "F♭", "A♭♭"],
      "IIm in the key of C♭ Major returns the correct notes")

    let cFlatIIm7 = cFlatMajor.chord("II", type: "m7")!
    XCTAssertEqual(cFlatIIm7.names, ["D♭", "F♭", "A♭", "C♭"],
      "IIm7 in the key of C♭ Major returns the correct notes")

    let cFlatIVM7 = cFlatMajor.chord("IV", type: "M7")!
    XCTAssertEqual(cFlatIVM7.names, ["F♭", "A♭", "C♭", "E♭"],
      "IVM7 in the key of C♭ Major returns the correct notes")

    let cFlatIVmM7 = cFlatMajor.chord("IV", type: "mM7")!
    XCTAssertEqual(cFlatIVmM7.names, ["F♭", "A♭♭", "C♭", "E♭"],
      "IVmM7 in the key of C♭ Major returns the correct notes")

    let cFlatV7 = cFlatMajor.chord("V", type: "7")!
    XCTAssertEqual(cFlatV7.names, ["G♭", "B♭", "D♭", "F♭"],
      "V7 in the key of C♭ Major returns the correct notes")

    let cFlatVaug = cFlatMajor.chord("V", type: "aug")!
    XCTAssertEqual(cFlatVaug.names, ["G♭", "B♭", "D"],
      "Vaug in the key of C♭ Major returns the correct notes")

    let cFlatVaug7 = cFlatMajor.chord("V", type: "aug7")!
    XCTAssertEqual(cFlatVaug7.names, ["G♭", "B♭", "D", "F♭"],
      "Vaug7 in the key of C♭ Major returns the correct notes")

    let cFlatVsus = cFlatMajor.chord("V", type: "sus")!
    XCTAssertEqual(cFlatVsus.names, ["G♭", "C♭", "D♭"],
      "Vsus in the key of C♭ Major returns the correct notes")

    let cFlatVsus2 = cFlatMajor.chord("V", type: "sus2")!
    XCTAssertEqual(cFlatVsus2.names, ["G♭", "A♭", "D♭"],
      "Vsus2 in the key of C♭ Major returns the correct notes")

    let cFlatV7sus = cFlatMajor.chord("V", type: "7sus")!
    XCTAssertEqual(cFlatV7sus.names, ["G♭", "C♭", "D♭", "F♭"],
      "V7sus in the key of C♭ Major returns the correct notes")

    let cFlatVM7sharp5 = cFlatMajor.chord("V", type: "M7♯5")!
    XCTAssertEqual(cFlatVM7sharp5.names, ["G♭", "B♭", "D", "F"],
      "VM7♯5 in the key of C Major returns the correct notes")

    let cFlatVM7flat5 = cFlatMajor.chord("V", type: "M7♭5")!
    XCTAssertEqual(cFlatVM7flat5.names, ["G♭", "B♭", "D♭♭", "F"],
      "VM7♭5 in the key of C Major returns the correct notes")

    let cFlatVIIdim = cFlatMajor.chord("VII", type: "dim")!
    XCTAssertEqual(cFlatVIIdim.names, ["B♭", "D♭", "F♭"],
      "cFlatVIIdim in the key of C♭ Major returns the correct notes")

    let cFlatVIIm7b5 = cFlatMajor.chord("VII", type: "m7♭5")!
    XCTAssertEqual(cFlatVIIm7b5.names, ["B♭", "D♭", "F♭", "A♭"],
      "VIIm7b5 in the key of C♭ Major returns the correct notes")

    let cFlatVIIdim7 = cFlatMajor.chord("VII", type: "dim7")!
    XCTAssertEqual(cFlatVIIdim7.names, ["B♭", "D♭", "F♭", "A♭♭"],
      "cFlatVIIdim in the key of C♭ Major returns the correct notes")
  }

}
